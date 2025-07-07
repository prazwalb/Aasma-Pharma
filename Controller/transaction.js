const mongoose = require('mongoose');
const {Transaction} = require('../Model/transaction_model');
const { Product } = require('../Model/product_model');

exports.Transactions = async (req, res) => {
  const salesData = req.body;

  if (!Array.isArray(salesData) || salesData.length === 0) {
    return res.status(400).json({ message: 'Sales data must be a non-empty array.' });
  }

  const session = await mongoose.startSession();
  session.startTransaction();

  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const createdTransactions = [];

    for (const sale of salesData) {
      const { productId, productName, quantity, priceAtTransaction, username } = sale;

      const product = await Product.findOne({ productId }).session(session);
      if (!product) throw new Error(`Product not found: ${productId}`);

      let totalAvailable = 0;
      const validBatches = product.batches
        .filter(batch =>
          (batch.availability === true || new Date(batch.expiringDate) > today) &&
          batch.quantity > 0
        )
        .sort((a, b) => new Date(a.manufacturedDate) - new Date(b.manufacturedDate));

      for (const batch of validBatches) {
        totalAvailable += batch.quantity;
      }

      if (totalAvailable < quantity) {
        throw new Error(`Insufficient stock for product ${productId}. Required: ${quantity}, Available: ${totalAvailable}`);
      }

      // Deduct quantity
      let qtyToDeduct = quantity;
      for (const batch of validBatches) {
        if (qtyToDeduct === 0) break;

        if (batch.quantity <= qtyToDeduct) {
          qtyToDeduct -= batch.quantity;
          batch.quantity = 0;
          batch.availability = false;
        } else {
          batch.quantity -= qtyToDeduct;
          batch.availability = batch.quantity > 1;
          qtyToDeduct = 0;
        }
      }

      await product.save({ session });

      const transaction = new Transaction({
        productId,
        productName,
        quantity,
        priceAtTransaction,
        username,
        transactionType: 'sale',
        status: 'completed'
      });

      await transaction.save({ session });
      createdTransactions.push(transaction);
    }

    await session.commitTransaction();
    session.endSession();

    res.status(201).json({
      message: 'All sale transactions completed successfully.',
      transactions: createdTransactions
    });

  } catch (error) {
    await session.abortTransaction();
    session.endSession();
    console.error('Bulk transaction error:', error.message);

    res.status(400).json({
      message: 'Transaction failed. No changes were saved.',
      error: error.message
    });
  }
};
