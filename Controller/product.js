const express=require('express')
const {Product}=require('../Model/product_model')
// crud

// create/add a product

exports.productAdd=async(req,res)=>{
     const productData = req.body;

  try {
    // Create a new Product instance with data from the request body
    const newProduct = new Product(productData);

    // Save the product to the database
    const savedProduct = await newProduct.save();

    // Send a success response
    res.status(201).json({
      message: 'Product added successfully!',
      product: savedProduct // Return the saved product document
    });

  } catch (error) {
    console.error('Error adding product via POST request:', error);

    // Handle Mongoose validation errors
    if (error.name === 'ValidationError') {
      const errors = {};
      for (const field in error.errors) {
        errors[field] = error.errors[field].message;
      }
      return res.status(400).json({
        message: 'Validation failed',
        errors: errors
      });
    }
    // Handle duplicate key error (e.g., productId unique constraint violation)
    else if (error.code === 11000) {
      return res.status(409).json({ // 409 Conflict status for duplicate resource
        message: 'A product with this Product ID already exists.',
        error: error.message
      });
    }
    // Handle other server errors
    else {
      res.status(500).json({
        message: 'Server error while adding product.',
        error: error.message
      });
    }
  }
}