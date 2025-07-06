// mongoose schema for patient/user
const mongoose=require('mongoose')
const bcrypt = require('bcryptjs');
const validator=require('validator')
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
    ],
    select: false 
  },
  gender:{
    type:String,
    required:[true,'Gender must required field'],
     enum:{
            values:['Male','Female','Others'], // <-- ERROR: Should be 'values'
            message: '{VALUE} is not a valid gender.'
        }
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
    max: [290, 'Height cannot exceed 250 cm.'], // Realistic maximum height
    validate: {
      validator: Number.isInteger, // Ensure it's an integer
      message: 'Height must be a whole number in centimeters.'
    }
  },
  medicalConditions: [{ // An array of strings for multiple conditions
    type: String,
    required:false,
    trim: true,
    minlength: [2, 'Medical condition must be at least 2 characters long.'],
    maxlength: [100, 'Medical condition cannot exceed 100 characters.']
  }],
  allergies: [{ // An array of strings for multiple allergies
    type: String,
    required:false,
    trim: true,
    minlength: [2, 'Allergy must be at least 2 characters long.'],
    maxlength: [100, 'Allergy cannot exceed 100 characters.']
  }],
  bloodGroup: {
    type: String,
    uppercase:true,
    required: true, // Make this optional
    enum: {
      values: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
      message: '"{VALUE}" is not a valid blood group. Valid options are A+, A-, B+, B-, AB+, AB-, O+, O-.'
    }
  }
})



patientSchema.pre('save', async function(next) {
  // Only hash the password if it has been modified (or is new)
  if (!this.isModified('password')) {
    return next();
  }
  // Hash the password with a salt (e.g., 10 rounds)
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});


// --- Mongoose Method: Compare password for login ---
patientSchema.methods.comparePassword = async function(candidatePassword) {
  // 'this.password' here refers to the hashed password stored in the database
  // We explicitly select the password in the login query (see route below)
  return await bcrypt.compare(candidatePassword, this.password);
};

exports.Patient=mongoose.model('Patient',patientSchema);