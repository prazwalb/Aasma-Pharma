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
});

// creating a schema for porduct



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

exports.user=mongoose.model('Patient',patientSchema);
exports.pharmacist=mongoose.model('Pharmacist',pharmacistSchema);
// exports.Product = mongoose.model('Product', productSchema);
exports.Transaction = mongoose.model('Transaction', transactionSchema);
