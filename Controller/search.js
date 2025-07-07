const express=require('express')
const {Product}=require('../Model/product_model')


// search by name
exports.searchProductByName = async (req, res) => {
  const {name}=req.params

  if (!name) {
    return res.status(400).json({ message: 'Product name query is required.' });
  }

  try {
    // Case-insensitive partial match using RegExp
    const products = await Product.find({
      productName: { $regex: name, $options: 'i' }
    });

    if (products.length === 0) {
      return res.status(404).json({ message: 'No products found matching that name.' });
    }

    res.status(200).json({
      message: 'Products found.',
      count: products.length,
      products
    });
  } catch (error) {
    console.error('Search error:', error);
    res.status(500).json({ message: 'Server error.', error: error.message });
  }
};