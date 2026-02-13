# Quick Start Guide

Get ScholarSync running in 5 minutes!

## Prerequisites Check

```bash
# Check Node.js (need v16+)
node --version

# Check npm
npm --version

# Check MongoDB
mongosh --version
# OR
mongo --version
```

Don't have them? Install:
- **Node.js**: https://nodejs.org/
- **MongoDB**: https://www.mongodb.com/try/download/community

## 1. Start MongoDB

**Windows:** Start MongoDB service from Services app

**Mac:**
```bash
brew services start mongodb-community
```

**Linux:**
```bash
sudo systemctl start mongodb
```

**Verify it's running:**
```bash
mongosh
# Should connect successfully
exit
```

## 2. Setup Backend

```bash
# Navigate to backend
cd backend

# Install dependencies (takes 1-2 minutes)
npm install

# Seed database with 15 scholarships
npm run seed

# You should see:
# ✅ Data Imported Successfully!
# 📚 Imported 15 scholarships

# Start backend server
npm run dev

# You should see:
# MongoDB Connected: 127.0.0.1
# Server running in development mode on port 5000
```

**Keep this terminal open!**

## 3. Setup Frontend

Open a **NEW terminal window**:

```bash
# Navigate to frontend
cd frontend

# Install dependencies (takes 1-2 minutes)
npm install

# Start development server
npm run dev

# You should see:
# VITE ready in XXX ms
# Local: http://localhost:3000
```

**Keep this terminal open too!**

## 4. Open Application

Open your browser to: **http://localhost:3000**

You should see the ScholarSync landing page!

## 5. Create Account

1. Click **"Get Started"** or **"Sign Up"**

2. **Step 1 - Basic Info:**
   - Name: Your Name
   - Email: test@example.com
   - Password: test123 (min 6 chars)
   - Age: 20
   - Gender: Select one

3. **Step 2 - Academic Info:**
   - State: Your State
   - Category: General (or SC/ST/OBC/EWS/Minority/PWD)
   - Annual Income: 300000 (₹3 lakh)
   - Education Level: Undergraduate
   - Institute Name: Your College
   - Class 10%: 85 (optional)
   - Class 12%: 90 (optional)
   - Guardian Occupation: Any (optional)

4. Click **"Create Account"**

## 6. Explore Features

You'll be redirected to the dashboard!

### View All Scholarships
- See all 15 scholarships
- Click any card to view details

### Check Eligible Scholarships
- Click **"Eligible"** in sidebar
- See only scholarships you qualify for
- Based on your income, category, and education level

### Bookmark Scholarships
- Click bookmark icon on any scholarship card
- View saved scholarships in **"Bookmarks"**

### View Scholarship Details
- Click any scholarship card
- See full details, eligibility rules, required documents
- Click **"APPLY NOW"** to visit official website

### Edit Profile
- Click **"Profile"** in sidebar
- Click **"Edit Profile"**
- Update your information
- Click **"Save"**

## 7. Test Different Scenarios

Want to see different eligible scholarships? Update your profile:

### Scenario A: Low Income Student
- Annual Income: 100000 (₹1 lakh)
- Category: EWS
- Should see: Post Matric Scholarship for EWS, SC/ST scholarships

### Scenario B: High Income Student
- Annual Income: 800000 (₹8 lakh)
- Category: General
- Should see: National Merit, INSPIRE, Technical Education

### Scenario C: Postgraduate Student
- Education Level: Postgraduate
- Should see: Women Empowerment, Research Fellowship

## Troubleshooting

### Backend won't start
```bash
# Check if MongoDB is running
mongosh

# Check if port 5000 is free
# Windows: netstat -ano | findstr :5000
# Mac/Linux: lsof -ti:5000
```

### Frontend won't start
```bash
# Check if port 3000 is free
# Windows: netstat -ano | findstr :3000
# Mac/Linux: lsof -ti:3000
```

### No scholarships showing
```bash
# Re-seed database
cd backend
npm run seed
```

### Can't login
- Check email and password
- Try signup with different email
- Clear browser localStorage (F12 > Application > Local Storage > Clear)

### Not seeing eligible scholarships
- Check your profile values (income, category, education)
- See [ELIGIBILITY_LOGIC.md](ELIGIBILITY_LOGIC.md) for how matching works
- Use debug endpoint: http://localhost:5000/api/scholarships/debug-eligibility

## Next Steps

- Read [ELIGIBILITY_LOGIC.md](ELIGIBILITY_LOGIC.md) to understand matching
- See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
- Check [backend/SETUP_INSTRUCTIONS.md](backend/SETUP_INSTRUCTIONS.md) for advanced setup

## Quick Commands Reference

```bash
# Backend
cd backend
npm install          # Install dependencies
npm run seed         # Seed database
npm run dev          # Start server
npm run test-eligibility  # Test eligibility logic

# Frontend
cd frontend
npm install          # Install dependencies
npm run dev          # Start dev server
npm run build        # Build for production

# MongoDB
mongosh              # Connect to MongoDB
use scholarsync      # Switch to database
db.scholarships.find()  # View scholarships
db.users.find()      # View users
```

## Support

Having issues? Check:
1. [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Common problems and solutions
2. Backend terminal - Look for error messages
3. Browser console (F12) - Check for errors
4. MongoDB connection - Verify it's running

## Success Checklist

- ✅ MongoDB running
- ✅ Backend running on port 5000
- ✅ Frontend running on port 3000
- ✅ Can access http://localhost:3000
- ✅ Can signup and login
- ✅ Can see scholarships
- ✅ Can view scholarship details
- ✅ Can bookmark scholarships
- ✅ Can edit profile

**All checked? You're ready to go! 🎉**
