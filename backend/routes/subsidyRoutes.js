const express = require('express');
const router = express.Router();
const Subsidy = require('../models/Subsidy');
const Farmer = require('../models/Farmer');
const mongoose = require('mongoose'); 

const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "_" + file.originalname);
  }
});

const upload = multer({ storage: storage });

// Apply Subsidy
router.post('/apply', upload.single('document'), async (req, res) => {
  try {
    const { farmerId, cows, location, bankAccount, ifsc } = req.body;

    const subsidy = new Subsidy({
  farmerId,
  cows: Number(cows),   // 🔥 FIX
  location,
  bankAccount,
  ifsc,
  document: req.file ? req.file.filename : "",
  status: "Pending"
});
    await subsidy.save();

    res.json({ message: "Applied successfully", subsidy });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/all', async (req, res) => {
  try {
    const subsidies = await Subsidy.find().populate('farmerId');

    const result = subsidies.map(sub => ({
      _id: sub._id,
      cows: sub.cows,
      status: sub.status,
      location: sub.location,
      bankAccount: sub.bankAccount,
      ifsc: sub.ifsc,
      document: sub.document,

      // 🔥 NEW FIELDS
      farmerName: sub.farmerId?.name || "N/A",
      farmerMobile: sub.farmerId?.mobile || "N/A"
    }));

    res.json(result);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 🔥 UPDATE STATUS
router.put('/update/:id', async (req, res) => {
  const { status } = req.body;

  const updated = await Subsidy.findByIdAndUpdate(
    req.params.id,
    { status },
    { new: true }
  );

  res.json(updated);
});

// Get Subsidy Status
router.get('/:farmerId', async (req, res) => {
  const data = await Subsidy.find({ farmerId: req.params.farmerId });
  res.json(data);
});




module.exports = router;