const mongoose = require('mongoose');

const subsidySchema = new mongoose.Schema({
  farmerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Farmer'
  },
  cows: Number,

   location: String,          // 🔥 ADD
  bankAccount: String,       // 🔥 ADD
  ifsc: String,              // 🔥 ADD
  document: String,          // 🔥 ADD (file name)
  
  status: {
    type: String,
    default: "Pending"
  }
});

module.exports = mongoose.model('Subsidy', subsidySchema, 'subsidies');