const mongoose=require('mongoose')
const bcrypt = require('bcryptjs');
const validator=require('validator')
const transactionSchema = new mongoose.Schema({
  // Reference to the Product being transacted
  productId: {
    type: String,
    required: [true, 'Product ID is required for the transaction.']
  },
  // Denormalized product name (for historical record, in case product name changes)
  productName: {
    type: String,
    required: [true, 'Product name is required for the transaction.'],
    trim: true
  },
  quantity: {
    type: Number,
    required: [true, 'Quantity is required for the transaction.'],
    min: [1, 'Quantity must be at least 1.'], // A transaction must involve at least one item
    validate: {
      validator: Number.isInteger,
      message: 'Quantity must be a whole number.'
    }
  },
  // Price at the time of transaction (denormalized, as prices can change over time)
  priceAtTransaction: {
    type: Number,
    required: [true, 'Price at transaction is required.'],
    min: [0, 'Price cannot be negative.']
  },
  username: {
    type: String,
    required: [true, 'Username is required for the transaction.']
  },
  transactionType: {
    type: String,
    required: [true, 'Transaction type is required.'],
  },
  // --- TRANSACTION DATE FIELD ---
  transactionDate: {
    type: Date,
    default: Date.now, // Automatically sets the current date/time when created
    required: true
  },
  // --- END TRANSACTION DATE FIELD ---
  totalAmount: {
    type: Number,
    required: [true, 'Total amount is required.'],
    min: [0, 'Total amount cannot be negative.']
  },
  status: {
    type: String,
    enum: {
      values: ['completed', 'pending', 'cancelled'],
      message: '"{VALUE}" is not a valid transaction status.'
    },
    default: 'completed', // Most transactions will be completed immediately
    required: true
  }
}, {
  timestamps: true // Adds createdAt and updatedAt timestamps automatically
});

// Pre-save hook to calculate totalAmount before saving
// This ensures totalAmount is always consistent with quantity and priceAtTransaction
transactionSchema.pre('save', function(next) {
  // Only calculate if quantity or priceAtTransaction has been modified or if it's a new document
  if (this.isModified('quantity') || this.isModified('priceAtTransaction') || this.isNew) {
    this.totalAmount = this.quantity * this.priceAtTransaction;
  }
  next();
});

exports.Transaction = mongoose.model('Transaction', transactionSchema);