const express=require('express')
const {pharmacist}=require('../Model/User_model')
const jwt = require('jsonwebtoken');

const generateToken =async (id) => {
  return await jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: '1h', // Token expires in 1 hour
  });
};

exports.adminLogin=async(req,res)=>{
 const { username, password } = req.body;

  // 1. Basic validation
  if (!username || !password) {
    return res.status(400).json({ message: 'Please enter both username and password.' });
  }

  try {
    // 2. Find the pharmacist by username
    // Use .select('+password') to explicitly include the password field,
    // which was set to select: false in the schema for security reasons.
    const pharma = await pharmacist.findOne({ username }).select('+password');

    // 3. Check if pharmacist exists and password is correct
    if (!pharma || !(await pharma.comparePassword(password))) {
      return res.status(401).json({ message: 'Invalid username or password.' });
    }

    // 4. If credentials are valid, generate a JWT
    const token =await generateToken(pharma.username);

    // 5. Send success response with token and basic user info (excluding sensitive data)
    res.status(200).json({
      message: 'Login successful!',
      token,
      user: {
        username: pharma.username,
        email: pharma.email,
        fullName: pharma.fullName,
      }
    });

  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server error during login process.' });
  }
}

exports.adminRegister=async(req,res)=>{
    const { username, password, email, name,gender,address,license} = req.body;

    try {
        const newPharmacist = new pharmacist({ username,name,gender,email,address,license,password});
        await newPharmacist.save(); // Password hashing happens via pre('save') hook

        // Generate token upon successful registration
        const token = generateToken(newPharmacist.username);

        res.status(201).json({
            message: 'Pharmacist registered successfully!',
            token,
            user: {
                username: newPharmacist.username,
                name: newPharmacist.fullName,
                gender:newPharmacist.gender,
                email: newPharmacist.email,
                address:newPharmacist.address,
                license:newPharmacist.license
            }
        });
    } catch (error) {
        console.error('Registration error:', error);
        if (error.code === 11000) { // Duplicate key error (for unique fields like username/email)
            return res.status(400).json({ message: 'Username or email already exists.' });
        }
        if (error.name === 'ValidationError') {
            const errors = Object.values(error.errors).map(err => err.message);
            return res.status(400).json({ message: errors.join(', ') });
        }
        res.status(500).json({ message: 'Server error during registration.' });
    }
}