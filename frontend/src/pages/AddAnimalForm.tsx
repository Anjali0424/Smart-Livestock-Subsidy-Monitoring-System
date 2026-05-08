import React, { useState, useEffect } from 'react';
import { Button } from '../components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/card';
import { Input } from '../components/ui/input';
import { Label } from '../components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '../components/ui/select';
import { Animal, Farmer } from '../types';
import { api } from '../services/api';

const AddAnimalForm: React.FC = () => {
  const [farmers, setFarmers] = useState<Farmer[]>([]);
  const [formData, setFormData] = useState({
    animalType: '' as 'cow' | 'buffalo' | 'goat' | '',
    age: '',
    tagId: '',
    animalImage: '',
    ownerId: '',
  });

  useEffect(() => {
    loadFarmers();
  }, []);

  const loadFarmers = async () => {
    try {
      const response = await api.getFarmers();
      setFarmers(response.data);
    } catch (error) {
      console.error('Error loading farmers:', error);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const animalData = {
        ...formData,
        age: parseInt(formData.age),
        ownerId: parseInt(formData.ownerId),
      };
      await api.createAnimal(animalData);
      setFormData({
        animalType: '',
        age: '',
        tagId: '',
        animalImage: '',
        ownerId: '',
      });
    } catch (error) {
      console.error('Error creating animal:', error);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  return (
    <div className="max-w-2xl mx-auto">
      <Card>
        <CardHeader>
          <CardTitle>Add New Animal</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <Label htmlFor="animalType">Animal Type</Label>
              <Select value={formData.animalType} onValueChange={(value) => setFormData({ ...formData, animalType: value as 'cow' | 'buffalo' | 'goat' })}>
                <SelectTrigger>
                  <SelectValue placeholder="Select animal type" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="cow">Cow</SelectItem>
                  <SelectItem value="buffalo">Buffalo</SelectItem>
                  <SelectItem value="goat">Goat</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label htmlFor="age">Age (years)</Label>
              <Input
                id="age"
                name="age"
                type="number"
                value={formData.age}
                onChange={handleInputChange}
                required
              />
            </div>
            <div>
              <Label htmlFor="tagId">Tag ID</Label>
              <Input
                id="tagId"
                name="tagId"
                value={formData.tagId}
                onChange={handleInputChange}
                required
              />
            </div>
            <div>
              <Label htmlFor="ownerId">Owner</Label>
              <Select value={formData.ownerId} onValueChange={(value) => setFormData({ ...formData, ownerId: value })}>
                <SelectTrigger>
                  <SelectValue placeholder="Select owner" />
                </SelectTrigger>
                <SelectContent>
                  {farmers.map((farmer) => (
                    <SelectItem key={farmer.id} value={farmer.id.toString()}>
                      {farmer.fullName} ({farmer.village})
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label htmlFor="animalImage">Animal Image URL</Label>
              <Input
                id="animalImage"
                name="animalImage"
                value={formData.animalImage}
                onChange={handleInputChange}
                placeholder="Upload image URL"
              />
            </div>
            <Button type="submit">Add Animal</Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default AddAnimalForm;