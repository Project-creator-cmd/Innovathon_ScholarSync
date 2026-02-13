# Troubleshooting Guide

## Issue: Profile Data Not Updating

### Symptoms
- You edit your profile but changes don't persist
- After refresh, old data appears

### Solutions

1. **Check Browser Console**
   - Open DevTools (F12)
   - Look for errors in Console tab
   - Check Network tab for failed API calls

2. **Verify Backend is Running**
   ```bash
   # Should see: Server running in development mode on port 5000
   ```

3. **Test API Directly**
   ```bash
   # Login first to get token
   curl -X POST http://localhost:5000/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"email":"your@email.com","password":"yourpassword"}'
   
   # Copy the token from response, then update profile
   curl -X PUT http://localhost:5000/api/auth/profile \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_TOKEN" \
     -d '{"annualIncome":300000}'
   ```

4. **Check MongoDB**
   ```bash
   mongosh
   use scholarsync
   db.users.find().pretty()
   ```

5. **Clear Browser Cache**
   - Clear localStorage: DevTools > Application > Local Storage > Clear
   - Hard refresh: Ctrl+Shift+R (Windows) or Cmd+Shift+R (Mac)

## Issue: No Eligible Scholarships Showing

### Symptoms
- Dashboard shows scholarships but "Eligible" filter shows none
- You expect to see scholarships but list is empty

### Understanding Eligibility

A scholarship is eligible ONLY if ALL three conditions are met:

1. **Income**: Your annual income ≤ scholarship's max income
2. **Category**: 
   - Scholarship is "General" (open to all), OR
   - Your category matches scholarship category, OR
   - You are "General" category
3. **Education Level**: Must match exactly

### Debug Steps

1. **Check Your Profile**
   - Go to Profile page
   - Verify: Annual Income, Category, Education Level
   - Make sure values are saved (not empty)

2. **Run Test Script**
   ```bash
   cd backend
   npm run test-eligibility
   ```
   This shows which scholarships match different profiles.

3. **Use Debug Endpoint**
   - Login to get your token
   - Visit: http://localhost:5000/api/scholarships/debug-eligibility
   - Or use curl:
   ```bash
   curl http://localhost:5000/api/scholarships/debug-eligibility \
     -H "Authorization: Bearer YOUR_TOKEN"
   ```
   This shows exactly why each scholarship is/isn't eligible.

4. **Example Scenarios**

   **Scenario A: General Undergraduate with ₹5 lakh income**
   ```
   Income: 500000
   Category: General
   Education: Undergraduate
   
   Should see:
   - National Merit Scholarship (max: ₹8 lakh)
   - State Merit Scholarship (max: ₹5 lakh)
   - Central Sector Scholarship (max: ₹4.5 lakh) ❌ (income too high)
   - Single Girl Child (max: ₹5 lakh)
   - Sports Excellence (max: ₹7 lakh)
   ```

   **Scenario B: SC Student with ₹2 lakh income**
   ```
   Income: 200000
   Category: SC
   Education: Undergraduate
   
   Should see:
   - SC/ST National Scholarship (max: ₹2.5 lakh, category: SC)
   - All General category scholarships with max income ≥ ₹2 lakh
   ```

   **Scenario C: Postgraduate Student**
   ```
   Income: 600000
   Category: General
   Education: Postgraduate
   
   Should see:
   - Women Empowerment Scholarship
   - Research Fellowship for Postgraduates
   
   Should NOT see:
   - Any Undergraduate scholarships (education level mismatch)
   ```

5. **Common Mistakes**

   ❌ **Wrong**: Income entered as "3 lakh" (text)
   ✅ **Correct**: Income entered as 300000 (number)

   ❌ **Wrong**: Education level "UG" or "Under Graduate"
   ✅ **Correct**: Education level "Undergraduate" (exact match)

   ❌ **Wrong**: Category "general" (lowercase)
   ✅ **Correct**: Category "General" (proper case)

## Issue: Scholarships Not in Database

### Symptoms
- Dashboard shows 0 scholarships
- All filters show empty

### Solutions

1. **Check if Seed Ran Successfully**
   ```bash
   cd backend
   npm run seed
   
   # Should see:
   # ✅ Data Imported Successfully!
   # 📚 Imported 15 scholarships
   ```

2. **Verify MongoDB Connection**
   ```bash
   mongosh
   use scholarsync
   db.scholarships.countDocuments()
   # Should return: 15
   ```

3. **Check scholarships.json**
   - File should be in root directory (not in backend/)
   - Should contain 15 scholarship objects
   - Check JSON is valid (no syntax errors)

4. **Re-seed Database**
   ```bash
   cd backend
   npm run seed -- -d  # Delete all data
   npm run seed        # Import fresh data
   ```

## Issue: Cannot Login After Signup

### Symptoms
- Signup succeeds but login fails
- "Invalid email or password" error

### Solutions

1. **Check Password Length**
   - Minimum 6 characters required
   - Check User model validation

2. **Verify Email Format**
   - Must be valid email format
   - Check for typos

3. **Check Database**
   ```bash
   mongosh
   use scholarsync
   db.users.find({ email: "your@email.com" })
   ```

4. **Clear and Try Again**
   ```bash
   # Delete user and try signup again
   mongosh
   use scholarsync
   db.users.deleteOne({ email: "your@email.com" })
   ```

5. **Check Backend Logs**
   - Look at terminal where backend is running
   - Should show any errors during login

## Issue: CORS Errors

### Symptoms
- "CORS policy" errors in browser console
- API calls fail with CORS error

### Solutions

1. **Verify Both Servers Running**
   - Backend: http://localhost:5000
   - Frontend: http://localhost:3000

2. **Check Vite Proxy**
   - File: `frontend/vite.config.js`
   - Should have proxy configuration

3. **Restart Both Servers**
   ```bash
   # Stop both servers (Ctrl+C)
   # Start backend
   cd backend
   npm run dev
   
   # Start frontend (new terminal)
   cd frontend
   npm run dev
   ```

## Issue: Port Already in Use

### Symptoms
- "Port 5000 is already in use"
- "Port 3000 is already in use"

### Solutions

**Windows:**
```bash
# Find process on port 5000
netstat -ano | findstr :5000

# Kill process (replace PID)
taskkill /PID <PID> /F
```

**Mac/Linux:**
```bash
# Kill process on port 5000
lsof -ti:5000 | xargs kill -9

# Kill process on port 3000
lsof -ti:3000 | xargs kill -9
```

## Issue: MongoDB Connection Failed

### Symptoms
- "MongoServerError: connect ECONNREFUSED"
- Backend crashes on startup

### Solutions

1. **Check MongoDB is Running**
   ```bash
   # Windows: Check Services
   # Mac: brew services list
   # Linux: sudo systemctl status mongodb
   ```

2. **Start MongoDB**
   ```bash
   # Windows: Start MongoDB service from Services
   # Mac: brew services start mongodb-community
   # Linux: sudo systemctl start mongodb
   ```

3. **Try Different Connection String**
   In `backend/.env`:
   ```
   # Try this instead:
   MONGODB_URI=mongodb://127.0.0.1:27017/scholarsync
   ```

4. **Use MongoDB Atlas (Cloud)**
   - Sign up at https://www.mongodb.com/cloud/atlas
   - Create free cluster
   - Get connection string
   - Update MONGODB_URI in .env

## Issue: Bookmarks Not Working

### Symptoms
- Clicking bookmark icon does nothing
- Bookmarks page shows empty

### Solutions

1. **Check Browser Console**
   - Look for API errors
   - Check network requests

2. **Verify Token**
   - Check localStorage has valid token
   - Try logout and login again

3. **Test API**
   ```bash
   # Get scholarship ID from database
   mongosh
   use scholarsync
   db.scholarships.findOne()
   # Copy the _id
   
   # Test bookmark API
   curl -X POST http://localhost:5000/api/bookmark/SCHOLARSHIP_ID \
     -H "Authorization: Bearer YOUR_TOKEN"
   ```

## Issue: Frontend Build Errors

### Symptoms
- npm install fails
- npm run dev shows errors

### Solutions

1. **Clear node_modules**
   ```bash
   cd frontend
   rm -rf node_modules package-lock.json
   npm install
   ```

2. **Check Node Version**
   ```bash
   node --version
   # Should be v16 or higher
   ```

3. **Update npm**
   ```bash
   npm install -g npm@latest
   ```

## Getting More Help

If issues persist:

1. **Check Backend Logs**
   - Terminal where `npm run dev` is running
   - Look for error messages

2. **Check Browser DevTools**
   - Console tab for JavaScript errors
   - Network tab for failed API calls
   - Application tab for localStorage issues

3. **Test with curl**
   - Test API endpoints directly
   - Isolate frontend vs backend issues

4. **Check MongoDB Logs**
   - Look for connection issues
   - Verify data is being saved

5. **Create Minimal Test Case**
   - Use the test-eligibility script
   - Use the debug-eligibility endpoint
   - Test with curl commands

## Quick Reset

If everything is broken, start fresh:

```bash
# Stop all servers

# Clear MongoDB
mongosh
use scholarsync
db.dropDatabase()
exit

# Backend
cd backend
rm -rf node_modules package-lock.json
npm install
npm run seed
npm run dev

# Frontend (new terminal)
cd frontend
rm -rf node_modules package-lock.json
npm install
npm run dev

# Clear browser
# - Clear localStorage
# - Clear cookies
# - Hard refresh (Ctrl+Shift+R)
```
