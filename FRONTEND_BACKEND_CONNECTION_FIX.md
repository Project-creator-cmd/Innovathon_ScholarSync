# Frontend-Backend Connection Fix Guide

## Issue Identified
The frontend is not properly connected to the backend and database. This is likely due to:
1. MongoDB not running or not installed
2. Backend server not started
3. Frontend dev server not started
4. CORS or proxy configuration issues

## Current Configuration Status ✅

### Backend Configuration
- **Port**: 5000
- **Database**: MongoDB (mongodb://localhost:27017/scholarsync)
- **API Base**: http://localhost:5000/api
- **CORS**: Enabled

### Frontend Configuration
- **Port**: 3000
- **API Proxy**: Configured to proxy /api requests to http://localhost:5000
- **Axios Base URL**: /api (uses proxy)

## Solution Steps

### Step 1: Install and Start MongoDB

#### Option A: MongoDB Community Server (Recommended)
1. Download MongoDB from: https://www.mongodb.com/try/download/community
2. Install MongoDB Community Server
3. MongoDB should auto-start as a Windows service

#### Option B: MongoDB Atlas (Cloud - No Installation)
If you prefer cloud database:
1. Go to https://www.mongodb.com/cloud/atlas
2. Create free account
3. Create a free cluster
4. Get connection string
5. Update backend/.env with the connection string

#### Option C: Use Docker (If you have Docker installed)
```bash
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

### Step 2: Verify MongoDB is Running

Run this command:
```bash
# Check if MongoDB service is running
net start | findstr -i mongo
```

Or check MongoDB Compass (GUI tool) if installed.

### Step 3: Install Dependencies

#### Backend Dependencies
```bash
cd backend
npm install
```

#### Frontend Dependencies
```bash
cd frontend
npm install
```

### Step 4: Seed the Database

```bash
cd backend
npm run seed
```

This will populate the database with initial scholarship data.

### Step 5: Start Backend Server

```bash
cd backend
npm run dev
```

You should see:
```
Server running in development mode on port 5000
MongoDB Connected: localhost
```

### Step 6: Start Frontend Dev Server

Open a NEW terminal:
```bash
cd frontend
npm run dev
```

You should see:
```
VITE v7.3.1  ready in XXX ms

➜  Local:   http://localhost:3000/
```

### Step 7: Test the Connection

1. Open browser: http://localhost:3000
2. Try to signup/login
3. Check browser console for errors
4. Check backend terminal for API requests

## Common Issues and Fixes

### Issue 1: MongoDB Not Running
**Error**: "MongoServerError: connect ECONNREFUSED"

**Fix**:
- Start MongoDB service: `net start MongoDB`
- Or install MongoDB if not installed
- Or use MongoDB Atlas (cloud)

### Issue 2: Port 5000 Already in Use
**Error**: "EADDRINUSE: address already in use :::5000"

**Fix**:
```bash
cd backend
npm run kill-port
npm run dev
```

### Issue 3: CORS Errors
**Error**: "Access to XMLHttpRequest blocked by CORS policy"

**Fix**: Already configured in backend/server.js with cors()

### Issue 4: API 404 Errors
**Error**: "Cannot GET /api/..."

**Fix**: 
- Ensure backend is running on port 5000
- Check vite.config.js proxy is correct
- Restart frontend dev server

### Issue 5: Authentication Errors
**Error**: "jwt malformed" or "No token provided"

**Fix**:
- Clear localStorage: `localStorage.clear()`
- Login again
- Check JWT_SECRET in backend/.env

## Quick Start Commands

### Terminal 1 (Backend):
```bash
cd backend
npm install
npm run seed
npm run dev
```

### Terminal 2 (Frontend):
```bash
cd frontend
npm install
npm run dev
```

### Terminal 3 (MongoDB - if not running as service):
```bash
mongod --dbpath C:\data\db
```

## Environment Variables Check

### Backend (.env)
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/scholarsync
JWT_SECRET=your_jwt_secret_key_change_in_production_2024
JWT_EXPIRE=1d
NODE_ENV=development
```

### Frontend (No .env needed - uses Vite proxy)

## Testing the Connection

### Test 1: Backend Health Check
Open browser: http://localhost:5000/
Should see: `{"message":"ScholarSync API is running"}`

### Test 2: API Endpoint Test
Open browser: http://localhost:5000/api/scholarships/all
Should see: JSON array of scholarships

### Test 3: Frontend Proxy Test
With frontend running on port 3000:
Open browser console and run:
```javascript
fetch('/api/scholarships/all')
  .then(r => r.json())
  .then(console.log)
```

Should see scholarship data in console.

## Architecture Overview

```
Frontend (React + Vite)          Backend (Express + Node.js)
Port: 3000                       Port: 5000
     |                                |
     |  HTTP Request to /api/*        |
     |------------------------------>|
     |  (Proxied to localhost:5000)  |
     |                                |
     |                                |---> MongoDB
     |                                |    Port: 27017
     |  JSON Response                 |    Database: scholarsync
     |<------------------------------|
     |                                |
```

## Verification Checklist

- [ ] MongoDB installed and running
- [ ] Backend dependencies installed (npm install)
- [ ] Frontend dependencies installed (npm install)
- [ ] Database seeded (npm run seed)
- [ ] Backend server running on port 5000
- [ ] Frontend dev server running on port 3000
- [ ] Can access http://localhost:5000 (backend)
- [ ] Can access http://localhost:3000 (frontend)
- [ ] Can signup/login successfully
- [ ] Can see scholarships on dashboard
- [ ] No CORS errors in browser console
- [ ] No connection errors in backend terminal

## Next Steps After Fix

1. Test all features:
   - Signup/Login
   - View scholarships
   - Filter scholarships
   - Bookmark scholarships
   - Chat with AI assistant
   - Check application status

2. If issues persist:
   - Check browser console (F12)
   - Check backend terminal logs
   - Check MongoDB logs
   - Share specific error messages

## Alternative: Use MongoDB Atlas (Cloud)

If local MongoDB is problematic:

1. Create account at https://cloud.mongodb.com
2. Create free cluster (M0)
3. Create database user
4. Whitelist IP (0.0.0.0/0 for development)
5. Get connection string
6. Update backend/.env:
```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/scholarsync?retryWrites=true&w=majority
```

## Support

If you continue to have issues, provide:
1. Error messages from browser console
2. Error messages from backend terminal
3. MongoDB status (running/not running)
4. Output of `npm run dev` from both terminals
