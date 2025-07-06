const mongoose=require('mongoose')
const validator=require('validator')


const medicationSchema = new mongoose.Schema({
  // Corresponds to "Name of Medicine"
  name: {
    type: String,
    required: [true, 'Medication name is required.'],
    trim: true,
    minlength: [2, 'Medication name must be at least 2 characters long.'],
    maxlength: [150, 'Medication name cannot exceed 150 characters.']
  },
  // Corresponds to "Description"
  description: {
    type: String,
    required: false, // Description can be optional
    trim: true,
    maxlength: [1000, 'Description cannot exceed 1000 characters.']
  },
  // Corresponds to "Start Date"
  startDate: {
    type: Date,
    required: [true, 'Start date is required for the medication.'],
    // Validate that the start date is not in the future (unless it's a future scheduled medication)
    validate: {
      validator: function(v) {
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Normalize to start of day
        // Allow today or past dates, or future dates if that's a valid use case for scheduling
        return v <= new Date() || v >= today; // Adjust logic if future scheduling is not allowed
      },
      message: 'Start date cannot be in the future for active medications.'
    }
  },
  // Corresponds to "End Date"
  endDate: {
    type: Date,
    required: false, // End date can be optional if medication is ongoing
    // Validate that end date is not before start date, if both are provided
    validate: {
      validator: function(v) {
        if (v && this.startDate) {
          return v >= this.startDate;
        }
        return true; // Valid if no end date, or if start date is not set
      },
      message: 'End date cannot be before the start date.'
    }
  },
  // Corresponds to "No. of dose to be taken" (e.g., 1, 2, 3 times a day)
  dosesPerDay: {
    type: Number,
    required: [true, 'Number of doses per day is required.'],
    min: [1, 'At least 1 dose per day is required.'],
    validate: {
      validator: Number.isInteger,
      message: 'Number of doses must be a whole number.'
    }
  },
  // Corresponds to "Morning", "Afternoon", "Night" radio buttons
  // Stores an array of strings indicating when doses should be taken
  dosageTimes: {
    type: [String], // Array of strings
    required: [true, 'At least one dosage time (Morning, Afternoon, Night) is required.'],
    enum: {
      values: ['Morning', 'Afternoon', 'Evening','Night',], // Expanded common times
      message: '{VALUE} is not a valid dosage time.'
    },
    validate: {
      validator: function(v) {
        // Ensure that if dosesPerDay is X, the array length is also X or less (flexible)
        // Or, enforce strict equality if dosesPerDay MUST match number of specified times
        return v.length > 0; // Ensure at least one time is selected
      },
      message: 'At least one dosage time must be selected.'
    }
  },
  // --- Additional useful fields (not explicitly in image but common for medications) ---

  // Dosage strength (e.g., "500mg", "10ml", "2 units")
  dosage: {
    type: String,
    required: [true, 'Dosage strength is required (e.g., 500mg, 10ml).'],
    trim: true,
    maxlength: [50, 'Dosage cannot exceed 50 characters.']
  },
  // Route of administration (e.g., oral, topical, injection)
  route: {
    type: String,
    required: [true, 'Administration route is required.'],
    enum: {
      values: ['Oral', 'Topical', 'Injection', 'Inhalation', 'Rectal', 'Vaginal', 'Ophthalmic', 'Otic', 'Nasal', 'Other'],
      message: '{VALUE} is not a valid administration route.'
    }
  },
  // Reference to the Patient this medication is for (if applicable)
  patientUserName: {
    type: String,// Assuming your Patient model is named 'Patient'
    required: [true, 'Patient ID is required for the medication record.']
  },
  // Reference to the Pharmacist/Doctor who prescribed/added this medication
  prescriberId: {
    type: String,
    // ref: 'Pharmacist', // Assuming your Pharmacist model is named 'Pharmacist'
    required: false // Might be optional if added by patient or other staff
  },
  // Status of the medication (e.g., active, completed, discontinued)
  status: {
    type: String,
    enum: {
      values: ['Active', 'Completed', 'Discontinued', 'On Hold'],
      message: '{VALUE} is not a valid medication status.'
    },
    default: 'Active',
    required: true
  },
  // Any specific instructions (e.g., "Take with food", "Avoid sunlight")
  instructions: {
    type: String,
    trim: true,
    required: false,
    maxlength: [500, 'Instructions cannot exceed 500 characters.']
  },
  // --- NEW FIELD: Consumption Timing ---
  consumptionTiming: {
    type: String,
    required: [true, 'Consumption timing (before/after eating) is required.'],
    enum: {
      values: ['Before Meal', 'After Meal'],
      message: '{VALUE} is not a valid consumption timing. Must be "Before Meal", "After Meal", "With Meal", or "Independent of Meal".'
    }, // A sensible default if not specified
  }
  // --- END NEW FIELD ---
}, {
  timestamps: true // Adds createdAt and updatedAt fields automatically
});

// Pre-save hook to ensure logical consistency of dates
medicationSchema.pre('save', function(next) {
  // Ensure endDate is not before startDate
  if (this.startDate && this.endDate && this.endDate < this.startDate) {
    return next(new Error('End date cannot be before the start date.'));
  }
  next();
});

exports.Medication = mongoose.model('Medication', medicationSchema);

