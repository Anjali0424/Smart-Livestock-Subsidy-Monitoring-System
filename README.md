# Animal Husbandry IoT Subsidy Verification Dashboard

A full-stack web application for managing animal husbandry subsidy verification system with IoT integration.

## Tech Stack

### Frontend
- React.js with TypeScript
- Vite
- Tailwind CSS
- shadcn/ui component library
- Recharts for analytics charts

### Backend
- Node.js
- Express.js
- In-memory storage (ready for MongoDB integration)

## Features

### Authentication
- Role-based login (Admin, Officer, Verifier)
- Simple authentication system

### Dashboard Modules
1. Dashboard Overview - Statistics and charts
2. Farmer Management - Add and view farmers
3. Officer Management - Manage officers
4. Aadhaar Verification Panel
5. Animal Registry
6. Add Animal Form
7. Animal Details Page
8. Subsidy Application Management
9. Scheme Management
10. Fraud Detection Panel
11. Location Map View
12. Document Management
13. Bank Verification Panel
14. Role Based Access Control UI
15. Analytics Dashboard
16. Village Report Page
17. Notifications Panel
18. Application Status Tracker
19. Audit Logs Page
20. Export Data Page
21. Image Moderation Panel
22. Cattle Health Record Panel
23. Support Ticket Panel
24. API Logs Page
25. 3D Visualization Page

## Getting Started

### Prerequisites
- Node.js (v16 or higher)
- npm

### Installation

1. Clone the repository
2. Install frontend dependencies:
   ```bash
   cd frontend
   npm install
   ```
3. Install backend dependencies:
   ```bash
   cd backend
   npm install
   ```

### Running the Application

1. Start the backend server:
   ```bash
   cd backend
   npm start
   ```
   Server will run on http://localhost:5000

2. Start the frontend development server:
   ```bash
   cd frontend
   npm run dev
   ```
   Frontend will run on http://localhost:5173

### Building for Production

```bash
cd frontend
npm run build
```

## API Endpoints

- GET /farmers - Get all farmers
- POST /farmers - Create a new farmer
- GET /animals - Get all animals
- POST /animals - Create a new animal
- GET /subsidies - Get all subsidies
- POST /subsidies - Create a new subsidy
- GET /officers - Get all officers
- POST /officers - Create a new officer

## Database Integration

The application currently uses in-memory storage. To integrate MongoDB:

1. Install MongoDB driver
2. Create Mongoose models in `backend/models/`
3. Update controllers to use MongoDB instead of arrays
4. Add MongoDB connection in `server.js`

## Project Structure

```
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── ui/          # shadcn/ui components
│   │   │   └── Sidebar.tsx
│   │   ├── pages/           # Page components
│   │   ├── services/        # API services
│   │   └── types/           # TypeScript types
│   └── package.json
├── backend/
│   ├── routes/              # API routes
│   ├── controllers/         # Business logic
│   ├── models/              # Data models (for MongoDB)
│   └── server.js
└── README.md
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.