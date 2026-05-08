import axios from 'axios';
import type { Farmer, Animal, Subsidy, Officer } from '../types';

const API_BASE_URL = 'http://localhost:5000';

export const api = {
  // Farmers
  getFarmers: () => axios.get<Farmer[]>(`${API_BASE_URL}/farmers`),
  createFarmer: (farmer: Omit<Farmer, 'id'>) => axios.post<Farmer>(`${API_BASE_URL}/farmers`, farmer),

  // Animals
  getAnimals: () => axios.get<Animal[]>(`${API_BASE_URL}/animals`),
  createAnimal: (animal: Omit<Animal, 'id'>) => axios.post<Animal>(`${API_BASE_URL}/animals`, animal),

  // Subsidies
  getSubsidies: () => axios.get<Subsidy[]>(`${API_BASE_URL}/subsidies`),
  createSubsidy: (subsidy: Omit<Subsidy, 'id'>) => axios.post<Subsidy>(`${API_BASE_URL}/subsidies`, subsidy),

  // Officers
  getOfficers: () => axios.get<Officer[]>(`${API_BASE_URL}/officers`),
  createOfficer: (officer: Omit<Officer, 'id'>) => axios.post<Officer>(`${API_BASE_URL}/officers`, officer),
};