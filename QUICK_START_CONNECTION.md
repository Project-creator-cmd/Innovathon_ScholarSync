# Quick Start - Fix Frontend-Backend Connection

## 🚀 Fastest Way to Get Running

### Step 1: Run Diagnostic Check
```bash
check-setup.bat
```
This will tell you what's missing.

### Step 2: Test Database Connection
```bash
cd backend
npm run test-connection
```

If this fails, MongoDB is not running. See "MongoDB Setup" below.

### Step 3: Start Everything
```bash
start-dev.bat
```

This will automatically:
- Check MongoDB status
- Install dependencies if needed
- Free port 5000 if needed
- Start backend server
- Start frontend dev server

### Step 4: Open Browser
Go to: http://localhost:3000

---

## 📋 Manual Setup (If Automatic Fails)

### 1. Install MongoDB

**Option A: Local Installation**
1. Download: https://www.mongodb.com/try/download/community
2. Install with default settings
3. MongoDB will run as Windows service

**Option B: MongoDB Atlas (Cloud - Easier)**
1. Go to: https://www.mongodb.com/cloud/atlas
2. Sign up for free
3. Create free cluster (M0)
4. Create database user
5. Whitelist IP: 0.0.0.0/0
6. Get connection string
7. Update `backend/.env`:
```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/scholarsync
```

### 2. Install Dependencies

**Backend:**
```bash
cd backend
npm install
```

**Frontend:**
```bash
cd frontend
npm install
```

### 3. Seed Database
```bash
cd backend
npm run seed
```

### 4. Start Servers

**Terminal 1 - Backend:**
```bash
cd backend
npm run dev
```

**Terminal 2 - Frontend:**
```bash
cd frontend
npm run dev
```

---

## 🔍 Troubleshooting

### Issue: "Cannot connect to MongoDB"

**Check if MongoDB is running:**
```bash
net start | findstr MongoDB
```

**Start MongoDB:**
```bash
net start MongoDB
```

**If MongoDB not installed:**
Use MongoDB Atlas (cloud option above) - no installation needed!

### Issue: "Port 5000 already in use"

**Fix:**
```bash
cd backend
npm run kill-port
npm run dev
```

### Issue: "Cannot GET /api/..."

**Cause:** Backend not running

**Fix:**
1. Open terminal
2. `cd backend`
3. `npm run dev`
4. Wait for "Server running on port 5000"

### Issue: Frontend shows blank page

**Check browser console (F12):**
- If you see CORS errors → Backend not running
- If you see 404 errors → Check API endpoints
- If you see network errors → Backend not accessible

**Fix:**
1. Ensure backend is running on port 5000
2. Ensure frontend is running on port 3000
3. Clear browser cache and localStorage
4. Restart both servers

### Issue: "jwt malformed" or authentication errors

**Fix:**
```javascript
// Open browser console (F12) and run:
localStorage.clear()
// Then refresh page and login again
```

---

## ✅ Verification Steps

### 1. Check Backend is Running
Open: http://localhost:5000

Should see:
```json
{"message":"ScholarSync API is running"}
```

### 2. Check API Endpoint
Open: http://localhost:5000/api/scholarships/all

Should see: Array of scholarship objects

### 3. Check Frontend
Open: http://localhost:3000

Should see: ScholarSync landing page

### 4. Test Login
1. Click "Sign Up"
2. Create account
3. Login
4. Should see dashboard with scholarships

---

## 📊 Architecture

```
┌─────────────────────┐
│   Browser           │
│   localhost:3000    │
└──────────┬──────────┘
           │
           │ HTTP Request to /api/*
           │
┌──────────▼──────────┐
│   Vite Dev Server   │
│   (Frontend)        │
│   Port 3000         │
└──────────┬──────────┘
           │
           │ Proxy to localhost:5000
           │
┌──────────▼──────────┐
│   Express Server    │
│   (Backend API)     │
│   Port 5000         │
└──────────┬──────────┘
           │
           │ Mongoose
           │
┌──────────▼──────────┐
│   MongoDB           │
│   Port 27017        │
│   DB: scholarsync   │
└─────────────────────┘
```

---

## 🎯 Quick Commands Reference

| Task | Command |
|------|---------|
| Check setup | `check-setup.bat` |
| Test connection | `cd backend && npm run test-connection` |
| Start everything | `start-dev.bat` |
| Kill port 5000 | `cd backend && npm run kill-port` |
| Seed database | `cd backend && npm run seed` |
| Start backend | `cd backend && npm run dev` |
| Start frontend | `cd frontend && npm run dev` |
| Clear browser data | `localStorage.clear()` in console |

---

## 🆘 Still Having Issues?

1. **Run diagnostic:**
   ```bash
   check-setup.bat
   ```

2. **Test connection:**
   ```bash
   cd backend
   npm run test-connection
   ```

3. **Check logs:**
   - Backend terminal: Look for errors
   - Browser console (F12): Look for network errors
   - MongoDB logs: Check if database is accessible

4. **Provide these details:**
   - Output of `check-setup.bat`
   - Output of `npm run test-connection`
   - Error messages from browser console
   - Error messages from backend terminal

---

## 🎉 Success Indicators

When everything is working:

✅ Backend terminal shows:
```
Server running in development mode on port 5000
MongoDB Connected: localhost
```

✅ Frontend terminal shows:
```
VITE v7.3.1  ready in XXX ms
➜  Local:   http://localhost:3000/
```

✅ Browser shows:
- Landing page loads
- Can signup/login
- Dashboard shows scholarships
- No errors in console

✅ You can:
- Create account
- Login
- View scholarships
- Filter scholarships
- Bookmark scholarships
- Use chat assistant
- Track application status
