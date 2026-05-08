import React, { useState } from 'react';
import Sidebar from '../components/Sidebar';
import DashboardOverview from './DashboardOverview';
import FarmerManagement from './FarmerManagement';
import OfficerManagement from './OfficerManagement';
import AadhaarVerification from './AadhaarVerification';
import AnimalRegistry from './AnimalRegistry';
import AddAnimalForm from './AddAnimalForm';
import AnimalDetails from './AnimalDetails';
import SubsidyManagement from './SubsidyManagement';
import SchemeManagement from './SchemeManagement';
import FraudDetection from './FraudDetection';
import LocationMap from './LocationMap';
import DocumentManagement from './DocumentManagement';
import BankVerification from './BankVerification';
import RoleBasedAccess from './RoleBasedAccess';
import AnalyticsDashboard from './AnalyticsDashboard';
import VillageReport from './VillageReport';
import NotificationsPanel from './NotificationsPanel';
import ApplicationStatus from './ApplicationStatus';
import AuditLogs from './AuditLogs';
import ExportData from './ExportData';
import ImageModeration from './ImageModeration';
import CattleHealth from './CattleHealth';
import SupportTicket from './SupportTicket';
import ApiLogs from './ApiLogs';
import Visualization3D from './Visualization3D';

const Dashboard: React.FC = () => {
  const [activePage, setActivePage] = useState('dashboard');

  const renderPage = () => {
    switch (activePage) {
      case 'dashboard':
        return <DashboardOverview />;
      case 'farmers':
        return <FarmerManagement />;
      case 'officers':
        return <OfficerManagement />;
      case 'aadhaar':
        return <AadhaarVerification />;
      case 'animals':
        return <AnimalRegistry />;
      case 'add-animal':
        return <AddAnimalForm />;
      case 'animal-details':
        return <AnimalDetails />;
      case 'subsidies':
        return <SubsidyManagement />;
      case 'schemes':
        return <SchemeManagement />;
      case 'fraud':
        return <FraudDetection />;
      case 'map':
        return <LocationMap />;
      case 'documents':
        return <DocumentManagement />;
      case 'bank':
        return <BankVerification />;
      case 'rbac':
        return <RoleBasedAccess />;
      case 'analytics':
        return <AnalyticsDashboard />;
      case 'village':
        return <VillageReport />;
      case 'notifications':
        return <NotificationsPanel />;
      case 'status':
        return <ApplicationStatus />;
      case 'logs':
        return <AuditLogs />;
      case 'export':
        return <ExportData />;
      case 'moderation':
        return <ImageModeration />;
      case 'health':
        return <CattleHealth />;
      case 'support':
        return <SupportTicket />;
      case 'api-logs':
        return <ApiLogs />;
      case 'visualization':
        return <Visualization3D />;
      default:
        return <DashboardOverview />;
    }
  };

  return (
    <div className="flex h-screen bg-gray-100">
      <Sidebar activePage={activePage} onPageChange={setActivePage} />
      <div className="flex-1 overflow-auto">
        <header className="bg-white shadow-sm p-4">
          <h1 className="text-2xl font-bold text-gray-800">
            Animal Husbandry IoT Subsidy Verification System
          </h1>
        </header>
        <main className="p-6">
          {renderPage()}
        </main>
      </div>
    </div>
  );
};

export default Dashboard;