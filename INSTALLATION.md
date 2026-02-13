# ScholarSync - Installation Guide

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v16 or higher) - [Download](https://nodejs.org/)
- **MongoDB** (v4.4 or higher) - [Download](https://www.mongodb.com/try/download/community) or use [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
- **npm** (comes with Node.js) or **yarn**
- **Git** - [Download](https://git-scm.com/)

## 🚀 Quick Installation (5 Minutes)

### Step 1: Clone the Repository

```bash
git clone <your-repository-url>
cd ScholarSync
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# The .env file is already created with default values
# For production, update these values:
# - MONGODB_URI (if using MongoDB Atlas)
# - JWT_SECRET (use a strong random string)

# Seed the database with scholarships and success stories
npm run seed

# Start the backend server
npm run dev
```

✅ Backend should now be running on `http://localhost:5000`

### Step 3: Frontend Setup (New Terminal)

```bash
# Navigate to frontend directory (from project root)
cd frontend

# Install dependencies
npm install

# Start the frontend development server
npm run dev
```

✅ Frontend should now be running on `http://localhost:3000`

### Step 4: Access the Application

Open your browser and go to: `http://localhost:3000`

🎉 **You're all set!** Create an account and start exploring scholarships.

---

## 📝 Detailed Installation

### MongoDB Setup

#### Option 1: Local MongoDB

**macOS (using Homebrew):**
```bash
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

**Ubuntu/Debian:**
```bash
sudo apt-get install mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
```

**Windows:**
1. Download MongoDB Community Server from [mongodb.com](https://www.mongodb.com/try/download/community)
2. Run the installer
3. Start MongoDB service from Services

#### Option 2: MongoDB Atlas (Cloud - Recommended)

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free account
3. Create a new cluster (free tier available)
4. Create a database user
5. Whitelist your IP address (or use 0.0.0.0/0 for development)
6. Get your connection string
7. Update `backend/.env`:
   ```env
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/scholarsync?retryWrites=true&w=majority
   ```

### Environment Configuration

#### Backend Environment Variables

The `backend/.env` file should contain:

```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/scholarsync
JWT_SECRET=your_jwt_secret_key_change_in_production_2024
JWT_EXPIRE=1d
NODE_ENV=development
```

**Important**: Change `JWT_SECRET` to a strong random string in production!

Generate a secure JWT secret:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

#### Frontend Configuration

The frontend is pre-configured to proxy API requests to `http://localhost:5000`.

For production, update `frontend/vite.config.js`:
```javascript
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'https://your-production-api.com',
        changeOrigin: true
      }
    }
  }
})
```

### Database Seeding

The seed script will:
- Clear existing scholarships and success stories
- Import 15 scholarships from `scholarships.json`
- Enhance scholarships with trust scores and metadata
- Add 2 sample success stories

```bash
cd backend
npm run seed
```

Expected output:
```
MongoDB Connected: localhost
✅ Data Imported Successfully!
📚 Imported 15 scholarships
🏆 Imported 2 success stories
```

### Verify Installation

#### Check Backend

```bash
# Test API health
curl http://localhost:5000

# Expected response:
# {"message":"ScholarSync API is running"}
```

#### Check Frontend

Open `http://localhost:3000` in your browser. You should see the ScholarSync landing page.

---

## 🔧 Troubleshooting

### Common Issues

#### 1. MongoDB Connection Error

**Error**: `MongooseServerSelectionError: connect ECONNREFUSED`

**Solution**:
```bash
# Check if MongoDB is running
mongod --version

# Start MongoDB
# macOS
brew services start mongodb-community

# Ubuntu
sudo systemctl start mongodb

# Windows
# Start MongoDB service from Services panel
```

#### 2. Port Already in Use

**Error**: `Error: listen EADDRINUSE: address already in use :::5000`

**Solution**:
```bash
# Find process using port 5000
# macOS/Linux
lsof -i :5000

# Windows
netstat -ano | findstr :5000

# Kill the process
# macOS/Linux
kill -9 <PID>

# Windows
taskkill /PID <PID> /F

# Or change port in backend/.env
PORT=5001
```

#### 3. Module Not Found

**Error**: `Error: Cannot find module 'express'`

**Solution**:
```bash
# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### 4. CORS Error

**Error**: `Access to XMLHttpRequest blocked by CORS policy`

**Solution**:
- Ensure backend is running on port 5000
- Check `backend/server.js` has `app.use(cors())`
- Clear browser cache

#### 5. Seed Script Fails

**Error**: `Error: ENOENT: no such file or directory`

**Solution**:
```bash
# Ensure you're in the backend directory
cd backend

# Check if scholarships.json exists in parent directory
ls ../scholarships.json

# Run seed script
npm run seed
```

---

## 🧪 Testing the Installation

### 1. Test Backend API

```bash
# Health check
curl http://localhost:5000

# Get scholarships (requires authentication)
# First, create an account via the frontend
```

### 2. Test Frontend

1. Open `http://localhost:3000`
2. Click "Get Started" or "Sign Up"
3. Fill in the 2-step registration form
4. You should be redirected to the dashboard
5. You should see 15 scholarships

### 3. Test Features

- ✅ View eligible scholarships
- ✅ Bookmark a scholarship
- ✅ View scholarship details
- ✅ Upload a document
- ✅ View deadline calendar
- ✅ Generate roadmap
- ✅ View success stories
- ✅ Chat with AI assistant
- ✅ Edit profile

---

## 📦 Package Information

### Backend Dependencies

```json
{
  "express": "^4.18.2",
  "mongoose": "^8.0.3",
  "bcryptjs": "^2.4.3",
  "jsonwebtoken": "^9.0.2",
  "dotenv": "^16.3.1",
  "cors": "^2.8.5",
  "express-validator": "^7.0.1"
}
```

### Frontend Dependencies

```json
{
  "react": "^18.2.0",
  "react-dom": "^18.2.0",
  "react-router-dom": "^6.20.1",
  "axios": "^1.6.2",
  "lucide-react": "^0.294.0"
}
```

---

## 🔄 Development Workflow

### Backend Development

```bash
cd backend

# Start with auto-reload
npm run dev

# The server will restart automatically when you make changes
```

### Frontend Development

```bash
cd frontend

# Start with hot reload
npm run dev

# Changes will reflect immediately in the browser
```

### Making Changes

1. **Backend**: Edit files in `backend/` directory
   - Models: `backend/models/`
   - Controllers: `backend/controllers/`
   - Routes: `backend/routes/`

2. **Frontend**: Edit files in `frontend/src/` directory
   - Pages: `frontend/src/pages/`
   - Components: `frontend/src/components/`
   - Styles: `frontend/src/index.css`

---

## 🏗️ Building for Production

### Backend

```bash
cd backend

# Install production dependencies only
npm install --production

# Set environment to production
export NODE_ENV=production

# Start server
npm start
```

### Frontend

```bash
cd frontend

# Build for production
npm run build

# Output will be in frontend/dist/
# Serve with any static file server
```

---

## 📱 Mobile Development Setup

The API is ready for mobile app development:

```bash
# React Native
npx react-native init ScholarSyncMobile
# Update API_URL to your backend URL

# Flutter
flutter create scholarsync_mobile
# Add http package and configure API endpoint
```

---

## 🐳 Docker Setup (Optional)

```bash
# Build and run with Docker Compose
docker-compose up -d

# Access application
# Frontend: http://localhost:80
# Backend: http://localhost:5000
# MongoDB: localhost:27017
```

---

## 📊 Database Management

### View Database

```bash
# Connect to MongoDB
mongosh

# Switch to scholarsync database
use scholarsync

# View collections
show collections

# View scholarships
db.scholarships.find().pretty()

# View users
db.users.find().pretty()

# Count documents
db.scholarships.countDocuments()
```

### Backup Database

```bash
# Backup
mongodump --db scholarsync --out ./backup

# Restore
mongorestore --db scholarsync ./backup/scholarsync
```

---

## 🎯 Next Steps

After installation:

1. ✅ Create a test account
2. ✅ Explore all features
3. ✅ Upload sample documents
4. ✅ Generate a roadmap
5. ✅ Chat with AI assistant
6. ✅ Customize for your needs
7. ✅ Deploy to production

---

## 📞 Support

If you encounter any issues:

1. Check this troubleshooting guide
2. Review error messages in terminal
3. Check browser console for frontend errors
4. Verify all dependencies are installed
5. Ensure MongoDB is running
6. Check environment variables

---

## 🎉 Success!

You now have ScholarSync running locally! Start exploring the features and helping students find scholarships.

**Happy Coding! 🚀**
