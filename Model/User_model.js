const mongoose=require('mongoose')
const validator=require('validator')

// mongoose schema for patient/user
const patientSchema=new mongoose.Schema({
    username:{
        type:String,
        required:true,
        unique:true,
       match: [
  /^(?!.*[_.]{2})(?!.*[_.]$)[a-zA-Z][a-zA-Z0-9._]{4,19}$/,
  'Please enter a valid username.'
    ],
    },
    name:{
        type:String,
        required:[true,'Name is required field'],
        trim:true,
         match: [
      /^[a-zA-Z\u00C0-\u017F]+(?:[.'\-\s][a-zA-Z\u00C0-\u017F]+)*[a-zA-Z\u00C0-\u017F]$/,
      'Please enter a valid full name'
    ]
    },
    email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
    match: [/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/, 'Please enter a valid email address.']
  },
  password: {
    type: String,
    required: true,
    match: [
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,20}$/,
      'Password must be between 8 and 20 characters, and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.'
    ]
  },

  address: {
    type: String,
    required: true, // Make this optional based on your needs
    trim: true,
    minlength: [5, 'Address must be at least 5 characters long.'],
    maxlength: [200, 'Address cannot exceed 200 characters.']
  },

  height: { 
    type: Number,
    required: true, // Make this optional based on your needs
    min: [50, 'Height must be at least 50 cm.'], // Realistic minimum height
    max: [250, 'Height cannot exceed 250 cm.'], // Realistic maximum height
    validate: {
      validator: Number.isInteger, // Ensure it's an integer
      message: 'Height must be a whole number in centimeters.'
    }
  },
  medicalConditions: [{ // An array of strings for multiple conditions
    type: String,
    trim: true,
    minlength: [2, 'Medical condition must be at least 2 characters long.'],
    maxlength: [100, 'Medical condition cannot exceed 100 characters.']
  }],
  allergies: [{ // An array of strings for multiple allergies
    type: String,
    trim: true,
    minlength: [2, 'Allergy must be at least 2 characters long.'],
    maxlength: [100, 'Allergy cannot exceed 100 characters.']
  }],
  bloodGroup: {
    type: String,
    required: false, // Make this optional
    enum: {
      values: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
      message: '"{VALUE}" is not a valid blood group. Valid options are A+, A-, B+, B-, AB+, AB-, O+, O-.'
    }
  }
})

// mongoose schema for Medical store
const  pharmacistSchema =mongooose.Schema({
    username:{
        type:String,
        required:true,
        unique:true,
       match: [
  /^(?!.*[_.]{2})(?!.*[_.]$)[a-zA-Z][a-zA-Z0-9._]{4,19}$/,
  'Please enter a valid username.'
    ],
    },
    name:{
        type:String,
        required:[true,'Pharmacy Name is required field'],
        unique:true,
        trim:true,
         match: [
      /^[a-zA-Z\u00C0-\u017F]+(?:[.'\-\s][a-zA-Z\u00C0-\u017F]+)*[a-zA-Z\u00C0-\u017F]$/,
      'Please enter a valid full name'
    ]
    },
    email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
    match: [/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/, 'Please enter a valid email address.']
  },
  password: {
    type: String,
    required: true,

    match: [
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,20}$/,
      'Password must be between 8 and 20 characters, and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.'
    ]
  },

  address: {
    type: String,
    required: true, // Make this optional based on your needs
    trim: true,
    minlength: [5, 'Address must be at least 5 characters long.'],
    maxlength: [200, 'Address cannot exceed 200 characters.']
    // You could add a regex here for specific address format if necessary,
    // but addresses are highly varied, so it's often best to be flexible.
  },
  license:{
    type:String,
    required:true,
    unique:true,
    trim: true,
    uppercase: true, 
    match: [/^[A-Z0-9\-\/]+$/, 'Invalid pharmacy license number format. It should contain letters, numbers, hyphens, and slashes.'],
    minlength: [5, 'Pharmacy license number must be at least 5 characters long.'],
    maxlength: [50, 'Pharmacy license number cannot exceed 50 characters.']
  }
})

// creating a schema for porduct



const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Product name is required.'],
    trim: true,
    minlength: [3, 'Product name must be at least 3 characters long.'],
    maxlength: [100, 'Product name cannot exceed 100 characters.'],
  },
  productId: {
    type: String,
    required: [true, 'Product ID is required.'],
    unique: true,
    trim: true,
    minlength: [3, 'Product ID must be at least 3 characters long.'],
    maxlength: [50, 'Product ID cannot exceed 50 characters.'],
    match: [/^[a-zA-Z0-9\-]+$/, 'Product ID can only contain alphanumeric characters and hyphens.']
  },
  manufacturer: {
    type: String,
    required: [true, 'Manufacturer is required.'],
    trim: true,
    minlength: [2, 'Manufacturer name must be at least 2 characters long.'],
    maxlength: [100, 'Manufacturer name cannot exceed 100 characters.']
  },
  description: {
    type: String,
    required: false,
    trim: true,
    maxlength: [500, 'Description cannot exceed 500 characters.']
  },
  quantity: {
    type: Number,
    required: [true, 'Quantity is required.'],
    min: [2, 'Quantity must be greater than 1.'], // Changed to min: 2
    validate: {
      validator: Number.isInteger,
      message: 'Quantity must be a whole number.'
    }
  },
  price: {
    type: Number,
    required: [true, 'Price is required.'],
    min: [0, 'Price cannot be negative.']
  },
  // --- New and Modified Date Fields ---

  manufacturedDate: {
    type: Date,
    required: [true, 'Manufactured date is required.'],
    validate: {
      validator: function(v) {
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize today to start of day
        return v <= today; // Manufactured date must be today or in the past
      },
      message: 'Manufactured date cannot be in the future.'
    }
  },
  expiringDate: {
    type: Date,
    required: false, // Keeping it optional as some items might not expire (e.g., devices)
                     // However, its presence and value will influence 'availability'
    validate: {
      validator: function(v) {
        // This validator ONLY checks that IF a date is provided, it's valid.
        // The "must be less than today" part for availability is handled in the pre-save hook.
        if (v) {
            // Here, we just ensure it's a valid date object if provided
            return v instanceof Date && !isNaN(v.getTime());
        }
        return true; // Valid if no date is provided
      },
      message: 'Invalid expiring date.'
    }
  },
  // --- Availability now calculated and not directly set ---
  // We'll set this via a pre-save hook based on quantity and expiringDate
  availability: {
    type: Boolean,
    default: false, // Default to false, will be calculated
    required: true // Still explicitly present, but calculated
  },
  // --- End New and Modified Date Fields ---

  image: {
    type: String,
    required: false,
    trim: true,
    match: [
      /^(?!.*[\\/]).*\.(jpg|jpeg|png|gif|svg|webp)$/i,
      'Invalid image filename. Must be a valid image file (e.g., .jpg, .png) and should not contain path separators.'
    ],
    minlength: [5, 'Image filename must be at least 5 characters long.'],
    maxlength: [100, 'Image filename cannot exceed 100 characters.']
  },
}, {
  timestamps: true // Adds createdAt and updatedAt timestamps automatically
});

// --- Pre-save hook to calculate availability ---
productSchema.pre('save', function(next) {
  const today = new Date();
  today.setHours(0, 0, 0, 0); // Normalize today to start of day

  let isAvailable = false;

  // 1. Check quantity: Must be greater than 1
  const hasSufficientQuantity = this.quantity > 0;

  // 2. Check expiry date:
  //    If expiringDate is provided, it must be in the future (relative to today).
  //    If expiringDate is NOT provided, it's considered non-expiring and thus available (if quantity allows).
  const isNotExpired = !this.expiringDate || (this.expiringDate.getTime() > today.getTime());

  // Determine availability
  isAvailable = hasSufficientQuantity && isNotExpired;

  this.availability = isAvailable; // Set the calculated availability

  // Additional validation for expiringDate relative to manufacturedDate
  if (this.manufacturedDate && this.expiringDate && this.expiringDate.getTime() <= this.manufacturedDate.getTime()) {
    return next(new Error('Expiring date must be after manufactured date.'));
  }

  // If you also want to enforce "expiringDate must be less than today"
  // to *mark it as invalid or expired immediately*, you can add another check here.
  // However, the current logic assumes "less than today" means "expired" for availability purposes.
  // If you literally mean "the user must input an expiring date that is already in the past"
  // then the 'expiringDate' field itself would fail the 'isNotExpired' check and set availability to false.

  next();
});


const transactionSchema = new mongoose.Schema({
  // Reference to the Product being transacted
  productId: {
    // ref: 'Product', // This links to your Product model
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

exports.user=mongoose.model('Patient',patientSchema);
exports.pharmacist=mongoose.model('Pharmacist',pharmacistSchema);
exports.Product = mongoose.model('Product', productSchema);
exports.Transaction = mongoose.model('Transaction', transactionSchema);
