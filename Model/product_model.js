
const mongoose=require('mongoose')
const validator=require('validator')
// 1. Define the Schema for the Embedded Batch/Inventory Document
const batchSchema = new mongoose.Schema({
  quantity: {
    type: Number,
    required: [true, 'Batch quantity is required.'],
    min: [2, 'Batch quantity must be greater than 1.'], // Enforcing quantity > 1 per batch
    validate: {
      validator: Number.isInteger,
      message: 'Batch quantity must be a whole number.'
    }
  },
  manufacturedDate: {
    type: Date,
    required: [true, 'Batch manufactured date is required.'],
    validate: {
      validator: function(v) {
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize today to start of day (July 6, 2025, 00:00:00)
        return v <= today; // Manufactured date must be today or in the past
      },
      message: 'Manufactured date cannot be in the future.'
    }
  },
  expiringDate: {
    type: Date,
    required: [true, 'Batch expiring date is required.'], // Making it required for each batch
    validate: {
      validator: function(v) {
        // Basic validation: ensure it's a valid Date object
        return v instanceof Date && !isNaN(v.getTime());
      },
      message: 'Invalid expiring date format.'
    }
  },
  // Availability for this specific batch, calculated dynamically in the parent's pre-save hook
  availability: {
    type: Boolean,
    default: false, // Default to false, will be calculated
    required: true // Still explicitly present, but calculated
  }
}, {
  _id: false // Crucial: Embedded documents in arrays usually don't need their own _id
});

// 2. Define the Main Product Schema
const productSchema = new mongoose.Schema({
  productId: { // Corresponds to your "ID" field
    type: String,
    required: [true, 'Product ID is required.'],
    unique: true, // Product IDs should typically be unique
    trim: true,
    minlength: [3, 'Product ID must be at least 3 characters long.'],
    maxlength: [50, 'Product ID cannot exceed 50 characters.'],
    match: [/^[a-zA-Z0-9\-]+$/, 'Product ID can only contain alphanumeric characters and hyphens.']
  },
  productName: { // Corresponds to your "Name" field
    type: String,
    required: [true, 'Product name is required.'],
    trim: true,
    minlength: [3, 'Product name must be at least 3 characters long.'],
    maxlength: [100, 'Product name cannot exceed 100 characters.'],
  },
  manufacturer: { // Corresponds to your "Manufacturer" field
    type: String,
    required: [true, 'Manufacturer is required.'],
    trim: true,
    minlength: [2, 'Manufacturer name must be at least 2 characters long.'],
    maxlength: [100, 'Manufacturer name cannot exceed 100 characters.']
  },
  image: { // Corresponds to your "Image" field
    type: String,
    required: false, // Image can be optional
    trim: true,
    match: [
      /^(?!.*[\\/]).*\.(jpg|jpeg|png|gif|svg|webp)$/i,
      'Invalid image filename. Must be a valid image file (e.g., .jpg, .png) and should not contain path separators.'
    ],
    minlength: [5, 'Image filename must be at least 5 characters long.'],
    maxlength: [100, 'Image filename cannot exceed 100 characters.']
  },
  category:{
    type:String,
    required:[true,'Category must be defined'],
    trim:true
  },
  price: { // Price is a top-level field (was missing from your last JSON example, but good to keep)
    type: Number,
    required: [true, 'Price is required.'],
    min: [0, 'Price cannot be negative.']
  },
  // The 'Sub' array from your JSON will be an array of 'batchSchema' documents
  batches: {
    type: [batchSchema], // This defines an array of embedded documents
    required: [true, 'Product must have at least one batch entry.']
  }
}, {
  timestamps: true // Adds createdAt and updatedAt timestamps automatically
});

// --- Pre-save hook for the main Product Schema ---
// This hook will iterate through each batch to calculate its availability
// and perform inter-field validation (manufacturedDate vs. expiringDate).
productSchema.pre('save', function(next) {
  const today = new Date();
  today.setHours(0, 0, 0, 0); // Normalize today to start of day (July 6, 2025, 00:00:00)

  // Check if batches array is empty or missing, though 'required' already handles missing
  if (!this.batches || this.batches.length === 0) {
      return next(new Error('Product must have at least one batch entry.'));
  }

  // Iterate over each batch in the 'batches' array
  for (let i = 0; i < this.batches.length; i++) {
    const batch = this.batches[i];

    // Ensure date fields are valid Date objects before comparison (if they passed initial field validators)
    if (!(batch.manufacturedDate instanceof Date) || isNaN(batch.manufacturedDate.getTime())) {
        return next(new Error(`Batch ${i+1}: Invalid manufactured date.`));
    }
    if (batch.expiringDate && (!(batch.expiringDate instanceof Date) || isNaN(batch.expiringDate.getTime()))) {
        return next(new Error(`Batch ${i+1}: Invalid expiring date.`));
    }

    // 1. Calculate Availability for the current batch
    let isBatchAvailable = false;
    const hasSufficientQuantity = batch.quantity > 1; // Check quantity rule for this batch

    // Check expiry date for this batch: Must be strictly in the future relative to today.
    // If expiringDate is in the past (or not provided/invalid if not required), the batch is considered expired.
    const isBatchNotExpired = batch.expiringDate && (batch.expiringDate.getTime() > today.getTime());

    isBatchAvailable = hasSufficientQuantity && isBatchNotExpired;
    batch.availability = isBatchAvailable; // Set the calculated availability for this batch

    // 2. Validate Manufactured Date vs. Expiring Date for the current batch
    // This check is crucial for logical consistency of dates
    if (batch.manufacturedDate && batch.expiringDate) {
      if (batch.expiringDate.getTime() <= batch.manufacturedDate.getTime()) {
        // If validation fails for any batch, throw an error to stop saving the document
        return next(new Error(`Batch ${i+1}: Expiring date (${batch.expiringDate.toISOString().split('T')[0]}) must be after manufactured date (${batch.manufacturedDate.toISOString().split('T')[0]}).`));
      }
    }
  }

  next(); // Continue with the save operation
});

exports.Product = mongoose.model('Product', productSchema);