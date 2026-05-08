const express = require('express');
const router = express.Router();
const Farmer = require('../models/Farmer');

// REGISTER
router.post('/register', async (req, res) => {
  try {
    const { name, mobile, password, location } = req.body;

    const farmer = new Farmer({
      name,
      mobile,
      password,   // ✅ IMPORTANT FIX
      location
    });

    await farmer.save();

    res.json({ message: "Registered successfully", farmer });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// LOGIN
router.post('/login', async (req, res) => {
  const { mobile, password } = req.body;

  console.log("LOGIN DATA:", mobile, password);

  const farmer = await Farmer.findOne({ mobile: mobile });

  if (!farmer) {
    return res.status(400).json({ message: "User not found" });
  }

  if (farmer.password != password) {
    return res.status(400).json({ message: "Wrong password" });
  }

  res.json(farmer);
});

// GET PROFILE
router.get('/profile/:mobile', async (req, res) => {
  try {
    const farmer = await Farmer.findOne({ mobile: req.params.mobile });

    if (!farmer) {
      return res.status(404).json({ message: "Farmer not found" });
    }

    res.json(farmer);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🔥 NEW: GET PROFILE BY ID
router.get('/profile-id/:id', async (req, res) => {
  try {
    const farmer = await Farmer.findById(req.params.id);

    if (!farmer) {
      return res.status(404).json({ message: "Farmer not found" });
    }

    res.json(farmer);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// 🔥 GET ALL FARMERS (ADMIN)
router.get('/all', async (req, res) => {
  try {
    const farmers = await Farmer.find();
    res.json(farmers);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/update/:id', async (req, res) => {
  try {
    const { name, address, aadhaar } = req.body; // ✅ correct

    const updatedFarmer = await Farmer.findByIdAndUpdate(
      req.params.id,
      { name, address, aadhaar }, // ✅ correct fields
      { new: true }
    );

    res.json({
      message: "Profile updated successfully",
      farmer: updatedFarmer
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;