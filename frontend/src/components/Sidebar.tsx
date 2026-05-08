import React from 'react';
import { Button } from '../components/ui/button';
import { cn } from '../lib/utils';

interface SidebarProps {
  activePage: string;
  onPageChange: (page: string) => void;
}

const Sidebar: React.FC<SidebarProps> = ({ activePage, onPageChange }) => {
  const menuItems = [
    { id: 'dashboard', label: 'Dashboard Overview' },
    { id: 'farmers', label: 'Farmer Management' },
    { id: 'officers', label: 'Officer Management' },
    { id: 'aadhaar', label: 'Aadhaar Verification Panel' },
    { id: 'animals', label: 'Animal Registry' },
    { id: 'add-animal', label: 'Add Animal Form' },
    { id: 'animal-details', label: 'Animal Details Page' },
    { id: 'subsidies', label: 'Subsidy Application Management' },
    { id: 'schemes', label: 'Scheme Management' },
    { id: 'fraud', label: 'Fraud Detection Panel' },
    { id: 'map', label: 'Location Map View' },
    { id: 'documents', label: 'Document Management' },
    { id: 'bank', label: 'Bank Verification Panel' },
    { id: 'rbac', label: 'Role Based Access Control UI' },
    { id: 'analytics', label: 'Analytics Dashboard' },
    { id: 'village', label: 'Village Report Page' },
    { id: 'notifications', label: 'Notifications Panel' },
    { id: 'status', label: 'Application Status Tracker' },
    { id: 'logs', label: 'Audit Logs Page' },
    { id: 'export', label: 'Export Data Page' },
    { id: 'moderation', label: 'Image Moderation Panel' },
    { id: 'health', label: 'Cattle Health Record Panel' },
    { id: 'support', label: 'Support Ticket Panel' },
    { id: 'api-logs', label: 'API Logs Page' },
    { id: 'visualization', label: '3D Visualization Page' },
  ];

  return (
    <div className="w-64 bg-white shadow-lg h-full overflow-y-auto">
      <div className="p-4 border-b">
        <h2 className="text-lg font-semibold text-gray-800">Dashboard</h2>
      </div>
      <nav className="p-4">
        <ul className="space-y-2">
          {menuItems.map((item) => (
            <li key={item.id}>
              <Button
                variant={activePage === item.id ? 'default' : 'ghost'}
                className={cn(
                  'w-full justify-start',
                  activePage === item.id && 'bg-blue-100 text-blue-700'
                )}
                onClick={() => onPageChange(item.id)}
              >
                {item.label}
              </Button>
            </li>
          ))}
        </ul>
      </nav>
    </div>
  );
};

export default Sidebar;