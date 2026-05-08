const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const path = require('path');
const subsidyRoutes = require('./routes/subsidyRoutes');
const app = express();

app.use(express.json());
app.use(cors());

// Serve images
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/cattleDB')
.then(() => console.log("MongoDB Connected"))
.catch(err => console.log(err));

// Routes
app.use('/api/farmer', require('./routes/farmerRoutes'));
app.use('/api/animal', require('./routes/animalRoutes'));
app.use('/api/subsidy', require('./routes/subsidyRoutes'));
app.use('/uploads', express.static('uploads'));
app.use('/api/dashboard', require('./routes/dashboardRoutes'));

app.get("/", (req, res) => {
  res.send("API Running...");
});

app.listen(5000, '0.0.0.0', () => {
  console.log("Server running on port 5000");
});

mongoose.connection.on('connected', () => {
  console.log("Connected DB:", mongoose.connection.name);
});