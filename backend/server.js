const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// In-memory data stores (to be replaced with MongoDB later)
let farmers = [];
let animals = [];
let subsidies = [];
let officers = [];

// Routes
app.get('/farmers', (req, res) => {
  res.json(farmers);
});

app.post('/farmers', (req, res) => {
  const farmer = { id: Date.now(), ...req.body };
  farmers.push(farmer);
  res.json(farmer);
});

app.get('/animals', (req, res) => {
  res.json(animals);
});

app.post('/animals', (req, res) => {
  const animal = { id: Date.now(), ...req.body };
  animals.push(animal);
  res.json(animal);
});

app.get('/subsidies', (req, res) => {
  res.json(subsidies);
});

app.post('/subsidies', (req, res) => {
  const subsidy = { id: Date.now(), ...req.body };
  subsidies.push(subsidy);
  res.json(subsidy);
});

app.get('/officers', (req, res) => {
  res.json(officers);
});

app.post('/officers', (req, res) => {
  const officer = { id: Date.now(), ...req.body };
  officers.push(officer);
  res.json(officer);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});