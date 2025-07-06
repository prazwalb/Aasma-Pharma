const mongoose = require('mongoose');
const validator=require('validator')

const prescriptionSchema = new mongoose.Schema({
  // Field for the uploaded prescription image
  // This will store the filename or URL of the image after it's uploaded
  prescriptionImage: {
    type: String,
    required: [true, 'Prescription image is required.'],
    trim: true,
    // Basic validation for image filename/URL format
    match: [
      /^(?!.*[\\/]).*\.(jpg|jpeg|png|gif|svg|webp)$/i,
      'Invalid image filename. Must be a valid image file (e.g., .jpg, .png) and should not contain path separators.'
    ],
    minlength: [5, 'Image filename must be at least 5 characters long.'],
    maxlength: [200, 'Image filename cannot exceed 200 characters.']
  },
  Name:{
    type:String,
    required:true,
  },
  // --- User Details (from "Your Details" section) ---
  // This could be a reference to a Patient model, or denormalized fields
  // For simplicity and direct mapping to your UI, we'll denormalize here.
  // If you have a Patient model, consider using patientId: { type: ObjectId, ref: 'Patient' }
  userName: { // Corresponds to "Name" field in "Your Details"
    type: String,
    required: [true, 'User name is required for the prescription order.'],
    trim: true,
    minlength: [2, 'User name must be at least 2 characters long.'],
    maxlength: [100, 'User name cannot exceed 100 characters.']
  },
  mobileNo: { // Corresponds to "Mobile No." field
    type: String,
    required: [true, 'Mobile number is required.'],
    trim: true,
    match: [/^\+?\d{7,15}$/, 'Please enter a valid mobile number.'], // Basic international phone number regex
    minlength: [7, 'Mobile number must be at least 7 digits.'],
    maxlength: [15, 'Mobile number cannot exceed 15 digits.']
  },
  pin: { // Corresponds to "Pin" field (e.g., postal code, PIN code)
    type: String,
    required: [true, 'PIN code is required.'],
    trim: true,
    match: [/^\d{4,10}$/, 'Please enter a valid PIN code (4-10 digits).'] // Adjust regex based on country's PIN format
  },
  address: { // Corresponds to "Address" field
    type: String,
    required: [true, 'Address is required.'],
    trim: true,
    minlength: [5, 'Address must be at least 5 characters long.'],
    maxlength: [250, 'Address cannot exceed 250 characters.']
  },

  // --- Saved Details (from "Saved Details" section) ---
  // These fields seem to represent a summary of the order or the details used for the order.
  // They might be redundant if the above "Your Details" are the source,
  // but included to match your UI's explicit display.
  orderName: { // Corresponds to "Order Name: Nishan Karki"
    type: String,
    required: [true, 'Order name is required.'], // Could be same as userName or a specific order name
    trim: true,
    minlength: [2, 'Order name must be at least 2 characters long.'],
    maxlength: [100, 'Order name cannot exceed 100 characters.']
  },
  // --- Order Status and Timestamp ---
  orderDate: {
    type: Date,
    default: Date.now,
    required: true
  },
  // Reference to the patient who uploaded this prescription
}, {
  timestamps: true // Adds createdAt and updatedAt fields
});

const Prescription = mongoose.model('Prescription', prescriptionSchema);

module.exports = Prescription;
