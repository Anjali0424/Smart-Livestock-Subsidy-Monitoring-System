import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '../components/ui/card';

interface PlaceholderPageProps {
  title: string;
}

const PlaceholderPage: React.FC<PlaceholderPageProps> = ({ title }) => {
  return (
    <Card className="max-w-4xl mx-auto">
      <CardHeader>
        <CardTitle>{title}</CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-gray-600">
          This page is under development. It will contain the full functionality for {title.toLowerCase()}.
        </p>
        <div className="mt-4 p-4 bg-gray-100 rounded">
          <p className="text-sm text-gray-500">
            Features to be implemented:
          </p>
          <ul className="list-disc list-inside mt-2 text-sm text-gray-500">
            <li>Data management interface</li>
            <li>Search and filter functionality</li>
            <li>CRUD operations</li>
            <li>Integration with backend APIs</li>
          </ul>
        </div>
      </CardContent>
    </Card>
  );
};

export default PlaceholderPage;