const express = require('express');
const router = express.Router();
const Animal = require('../models/Animal');
const multer = require('multer');

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const upload = multer({ storage });

router.post('/add-with-image', upload.single('image'), async (req, res) => {
  try {
    const { rfid, breed, age, farmerId } = req.body;

    console.log("BODY:", req.body); // debug

    const animal = new Animal({
      rfid,
      breed,
      age,
      image: req.file ? req.file.filename : "",
      farmerId   // 🔥 IMPORTANT
    });

    await animal.save();

    res.json({ message: "Animal added", animal });

  } catch (err) {
    console.log("ERROR:", err); // 🔥 VERY IMPORTANT
    res.status(500).json({ error: err.message });
  }
});

// UPDATE
router.put('/update/:id', async (req, res) => {
  const { breed, age } = req.body;

  const updated = await Animal.findByIdAndUpdate(
    req.params.id,
    { breed, age },
    { new: true }
  );

  res.json(updated);
});

// DELETE
router.delete('/delete/:id', async (req, res) => {
  await Animal.findByIdAndDelete(req.params.id);
  res.json({ message: "Deleted successfully" });
});

// 🔥 GET ALL ANIMALS (ADMIN)
router.get('/all', async (req, res) => {
  try {
    const animals = await Animal.find();
    res.json(animals);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:farmerId', async (req, res) => {
  try {
    const animals = await Animal.find({
      farmerId: req.params.farmerId
    });

    res.json(animals);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;