const express=require('express')
const {Product}=require('../Model/product_model')
const image_upload=require('./image_uploader')
// crud

// create/add new product

exports.addNewProduct=async(req,res)=>{
     const productData = req.body;

  try {
    // image upload
    // Create a new Product instance with data from the request body
    const newProduct = new Product(productData);

    // Save the product to the database
    const savedProduct = await newProduct.save('productImage');
    let image_upload=await image_upload(req,res,'')
    // Send a success response
    res.status(201).json({
      message: 'Product added successfully!',
      product: savedProduct // Return the saved product document
    });

  } catch (error) {
    console.error('Error adding product:', error);

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


//add product or quantity in a existing system
exports.addProduct=async(req,res)=>{
  const { productId } = req.params;
  const newBatch = req.body;

  try {
    // Find the product by productId
    const product = await Product.findOne({ productId });
    console.log(product)
    if (!product) {
      return res.status(404).json({ message: 'Product not found.' });
    }else{
      console.log("Product Found")
    }

    // Add new batch to the batches array
    product.batches.push(newBatch);

    // Save the updated product (this will trigger pre-save hook for batch availability)
    await product.save();

    res.status(200).json({
      message: 'Batch added successfully',
      product
    });
  } catch (error) {
    console.error('Error adding batch:', error);
    if (error.name === 'ValidationError') {
      const errors = {};
      for (const field in error.errors) {
        errors[field] = error.errors[field].message;
      }
      return res.status(400).json({ message: 'Validation failed', errors });
    }
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

// update product
// productName,productWeight,manufacturer,price,category

exports.updateProductDetails = async (req, res) => {
  const { productId } = req.params;
  const updateFields = req.body;

  try {
    // Define which fields are allowed to update
    const allowedFields = ['productName', 'netweight', 'manufacturer', 'price', 'category'];

    // Filter only valid keys provided by the user
    const filteredUpdate = {};
    for (const field of allowedFields) {
      if (updateFields[field] !== undefined) {
        filteredUpdate[field] = updateFields[field];
      }
    }

    // If no valid field is provided
    if (Object.keys(filteredUpdate).length === 0) {
      return res.status(400).json({
        message: 'No valid fields provided to update.'
      });
    }

    const updatedProduct = await Product.findOneAndUpdate(
      { productId },
      filteredUpdate,
      {
        new: true,          // return the updated document
        runValidators: true // enforce schema validations
      }
    );

    if (!updatedProduct) {
      return res.status(404).json({ message: 'Product not found.' });
    }

    res.status(200).json({
      message: 'Product updated successfully.',
      product: updatedProduct
    });

  } catch (error) {
    console.error('Update error:', error);

    if (error.name === 'ValidationError') {
      const errors = {};
      for (let field in error.errors) {
        errors[field] = error.errors[field].message;
      }
      return res.status(400).json({ message: 'Validation failed.', errors });
    }

    res.status(500).json({ message: 'Server error.', error: error.message });
  }
};
