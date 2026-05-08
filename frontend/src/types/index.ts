export interface Farmer {
  id: number;
  fullName: string;
  phone: string;
  aadhaarNumber: string;
  village: string;
  district: string;
  state: string;
  aadhaarImage?: string;
}

export interface Animal {
  id: number;
  animalType: 'cow' | 'buffalo' | 'goat';
  age: number;
  tagId: string;
  animalImage?: string;
  ownerId: number;
}

export interface Subsidy {
  id: number;
  farmerId: number;
  scheme: string;
  bankAccountNumber: string;
  ifscCode: string;
  documents?: string[];
  location?: string;
  status: 'pending' | 'approved' | 'rejected';
}

export interface Officer {
  id: number;
  name: string;
  department: string;
  idUpload?: string;
  degreeUpload?: string;
}

export type UserRole = 'Admin' | 'Officer' | 'Verifier';