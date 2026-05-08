import React, { useState, useEffect } from 'react';
import { Button } from '../components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/card';
import { Input } from '../components/ui/input';
import { Label } from '../components/ui/label';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '../components/ui/table';
import { Farmer } from '../types';
import { api } from '../services/api';

const FarmerManagement: React.FC = () => {
  const [farmers, setFarmers] = useState<Farmer[]>([]);
  const [formData, setFormData] = useState({
    fullName: '',
    phone: '',
    aadhaarNumber: '',
    village: '',
    district: '',
    state: '',
    aadhaarImage: '',
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
      await api.createFarmer(formData);
      setFormData({
        fullName: '',
        phone: '',
        aadhaarNumber: '',
        village: '',
        district: '',
        state: '',
        aadhaarImage: '',
      });
      loadFarmers();
    } catch (error) {
      console.error('Error creating farmer:', error);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Add New Farmer</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <Label htmlFor="fullName">Full Name</Label>
                <Input
                  id="fullName"
                  name="fullName"
                  value={formData.fullName}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div>
                <Label htmlFor="phone">Phone</Label>
                <Input
                  id="phone"
                  name="phone"
                  value={formData.phone}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div>
                <Label htmlFor="aadhaarNumber">Aadhaar Number</Label>
                <Input
                  id="aadhaarNumber"
                  name="aadhaarNumber"
                  value={formData.aadhaarNumber}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div>
                <Label htmlFor="village">Village</Label>
                <Input
                  id="village"
                  name="village"
                  value={formData.village}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div>
                <Label htmlFor="district">District</Label>
                <Input
                  id="district"
                  name="district"
                  value={formData.district}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div>
                <Label htmlFor="state">State</Label>
                <Input
                  id="state"
                  name="state"
                  value={formData.state}
                  onChange={handleInputChange}
                  required
                />
              </div>
            </div>
            <div>
              <Label htmlFor="aadhaarImage">Aadhaar Image URL</Label>
              <Input
                id="aadhaarImage"
                name="aadhaarImage"
                value={formData.aadhaarImage}
                onChange={handleInputChange}
                placeholder="Upload image URL"
              />
            </div>
            <Button type="submit">Add Farmer</Button>
          </form>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Farmers List</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>ID</TableHead>
                <TableHead>Name</TableHead>
                <TableHead>Phone</TableHead>
                <TableHead>Aadhaar</TableHead>
                <TableHead>Village</TableHead>
                <TableHead>District</TableHead>
                <TableHead>State</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {farmers.map((farmer) => (
                <TableRow key={farmer.id}>
                  <TableCell>{farmer.id}</TableCell>
                  <TableCell>{farmer.fullName}</TableCell>
                  <TableCell>{farmer.phone}</TableCell>
                  <TableCell>{farmer.aadhaarNumber}</TableCell>
                  <TableCell>{farmer.village}</TableCell>
                  <TableCell>{farmer.district}</TableCell>
                  <TableCell>{farmer.state}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
};

export default FarmerManagement;