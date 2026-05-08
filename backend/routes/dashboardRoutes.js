const express = require('express');
const router = express.Router();

const Farmer = require('../models/Farmer');
const Animal = require('../models/Animal');
const Subsidy = require('../models/Subsidy');

// GET Dashboard Stats
router.get('/stats', async (req, res) => {
  try {
    const totalFarmers = await Farmer.countDocuments();
    const totalAnimals = await Animal.countDocuments();
    const totalSubsidy = await Subsidy.countDocuments();

    const approved = await Subsidy.countDocuments({ status: "Approved" });
    const pending = await Subsidy.countDocuments({ status: "Pending" });
    const rejected = await Subsidy.countDocuments({ status: "Rejected" });

    res.json({
      totalFarmers,
      totalAnimals,
      totalSubsidy,
      approved,
      pending,
      rejected
    });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;