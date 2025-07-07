const express=require('express')
const {Product}=require('../Model/product_model')
//   const {name}=req.params

// search by name
exports.searchProductByName = async (req, res) => {
  const {name}=req.params

  if (!name) {
    return res.status(400).json({ message: 'Name query is required.' });
  }

  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Normalize date

    // Search products matching the name
    const products = await Product.find({
      productName: { $regex: name, $options: 'i' }
    });

    if (products.length === 0) {
      return res.status(404).json({ message: 'No products found.' });
    }

    // Transform and filter quantity logic
    const formatted = products.map(product => {
      let totalValidQuantity = 0;

      for (const batch of product.batches) {
        const notExpired = batch.expiringDate && batch.expiringDate > today;
        const isAvailable = batch.availability === true;

        if (notExpired || isAvailable) {
          totalValidQuantity += batch.quantity;
        }
      }

      return {
        productID: product.productId,
        productName: product.productName,
        netweight: product.netweight,
        category: product.category,
        manufacturer: product.manufacturer,
        image: product.image,
        price: product.price,
        quantity: totalValidQuantity
      };
    });

    res.status(200).json({
      message: 'Search successful',
      count: formatted.length,
      products: formatted
    });

  } catch (err) {
    console.error('Search error:', err);
    res.status(500).json({ message: 'Server error', error: err.message });
  }
};