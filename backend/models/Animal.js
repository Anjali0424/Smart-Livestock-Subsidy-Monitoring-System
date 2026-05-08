const mongoose = require('mongoose');

const animalSchema = new mongoose.Schema({
  rfid: String,
  breed: String,
  age: String,
  image: String,
  farmerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Farmer'
  }
}, { timestamps: true }); // 🔥 IMPORTANT

module.exports = mongoose.model('Animal', animalSchema);