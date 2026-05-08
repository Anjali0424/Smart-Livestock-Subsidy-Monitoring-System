const mongoose = require('mongoose');

const farmerSchema = new mongoose.Schema({
  name: String,
  mobile: String,
  password: String,

  // ✅ NEW FIELDS (SAFE - optional)
  address: {
    type: String,
    default: ""
  },
  aadhaar: {
    type: String,
    default: ""
  }
});

module.exports = mongoose.model('Farmer', farmerSchema);