# ScholarSync - Quick Run Guide

## 🚀 Start the Application (3 Steps)

### Step 1: Seed Database with scholarships.json

```bash
cd backend
npm install
npm run seed
```

**Expected Output:**
```
MongoDB Connected: localhost
📚 Found 15 scholarships in JSON file
🗑️  Cleared existing scholarships
✓ Processed: Mahindra Saarthi Abhiyaan Scholarship - ₹10,000 - Status: live
✓ Processed: Aspire Leaders Program - ₹1,00,000 - Status: live
... (continues for all 15)
✅ Inserted 15 scholarships into MongoDB
📊 Creating database indexes...
✅ Database indexes created
🏆 Imported 2 success stories

✅ Data Import Complete!
📚 Total Scholarships: 15
💰 Total Scholarship Amount: ₹37,36,320
📊 Live: 7
📊 Upcoming: 0
📊 Expired: 8
```

### Step 2: Start Backend Server

```bash
# In backend directory
npm run dev
```

**Expected Output:**
```
Server running in development mode on port 5000
MongoDB Connected: localhost
```

### Step 3: Start Frontend (New Terminal)

```bash
cd frontend
npm install
npm run dev
```

**Expected Output:**
```
VITE v5.0.8  ready in 500 ms

➜  Local:   http://localhost:3000/
➜  Network: use --host to expose
```

## 🌐 Access the Application

Open your browser: **http://localhost:3000**

## 📊 Test the Features

### 1. Register a New User

Go to: http://localhost:3000/signup

**Test User Profile:**
```
Name: Test Student
Email: test@example.com
Password: test123
Age: 20
Gender: Male
State: Delhi
Category: SC
Annual Income: 250000
Education Level: Undergraduate
Institute: Delhi University
```

### 2. View Dashboard

After login, you'll see:
- **Total Live Scholarships**: 7
- **Eligible for You**: (calculated based on your profile)
- **Closing Soon**: (scholarships within 7 days)
- **Bookmarked**: 0

### 3. Test Scholarship Cards

Each card should show:
- ✅ Days left badge (top right, color-coded)
- ✅ Category and status badges (top left)
- ✅ Scholarship title
- ✅ Provider name
- ✅ Amount in ₹ format (e.g., ₹10,000)
- ✅ Match score bar (if eligible)
- ✅ Deadline date
- ✅ Bookmark button
- ✅ Blue "View Details" button

### 4. Test Filters

**Eligible Scholarships:**
- Click "Eligible" in sidebar
- Should show only scholarships matching your profile
- Sorted by match percentage

**Closing Soon:**
- Click "Closing Soon" in sidebar
- Should show scholarships with deadline ≤ 7 days
- Sorted ascending (earliest first)

**High Amount:**
- Click "High Amount" in sidebar
- Should show only eligible scholarships ≥ ₹50,000
- Sorted descending (highest first)

### 5. Test Scholarship Detail Page

Click "View Details" on any card:
- Should show full scholarship information
- Days left badge
- Trust score
- Difficulty level
- Eligibility rules
- Required documents
- Blue "APPLY NOW" button (opens official link)

## 🔍 Verify Data

### Check MongoDB

```bash
mongosh

use scholarsync

# Count scholarships
db.scholarships.countDocuments()
# Should return: 15

# View all scholarships
db.scholarships.find().pretty()

# Check amounts (no NaN)
db.scholarships.find({}, {title: 1, amount: 1, _id: 0})

# Check status distribution
db.scholarships.aggregate([
  { $group: { _id: "$status", count: { $sum: 1 } } }
])
```

## 🐛 Troubleshooting

### Issue: No scholarships showing

**Solution:**
```bash
cd backend
npm run seed
```

### Issue: ₹NaN appearing

**Check:**
1. Seed script ran successfully
2. Amounts are Numbers in DB
3. Frontend formatAmount function is working

**Fix:**
```bash
# Re-seed database
cd backend
npm run seed
```

### Issue: Wrong scholarship count

**Expected:**
- Total: 15 scholarships
- Live: 7 (as of Feb 2026)
- Expired: 8

**Verify:**
```bash
mongosh
use scholarsync
db.scholarships.countDocuments()
```

### Issue: Eligibility not working

**Check:**
1. User profile has all required fields
2. Backend eligibility service is running
3. API endpoint `/api/scholarships/eligible` returns data

**Test:**
```bash
# Get auth token after login
# Then test API
curl -H "Authorization: Bearer YOUR_TOKEN" http://localhost:5000/api/scholarships/eligible
```

## 📋 Quick Checklist

Before testing, ensure:

- [x] MongoDB is running
- [x] Backend seed completed successfully
- [x] Backend server is running (port 5000)
- [x] Frontend server is running (port 3000)
- [x] No errors in terminal
- [x] Browser console has no errors

## 🎯 Expected Behavior

### Dashboard Stats (for SC category, ₹2.5L income, UG)

**Eligible Scholarships:**
- Pre-Matric Scholarship for SC Students
- Merit Scholarship for SC/ST/OBC Students
- Dr. BR Ambedkar Scholarship
- National Fellowship Scheme for SC Students
- (Others based on eligibility logic)

**Closing Soon (within 7 days from today):**
- Mahindra Saarthi Abhiyaan Scholarship (if within 7 days)
- MynVidya Myntra Cares Scholarship (if within 7 days)

**High Amount (eligible only, ≥₹50,000):**
- Aspire Leaders Program (₹1,00,000)
- KSCSTE Prathibha Scholarship (₹60,000)
- (Others if eligible)

## 🎉 Success Indicators

You'll know it's working when:

1. ✅ All 15 scholarships appear in "All Scholarships"
2. ✅ No ₹NaN errors anywhere
3. ✅ Days left badges show correct colors
4. ✅ "View Details" button is blue and clickable
5. ✅ Eligible page shows personalized results
6. ✅ Closing Soon shows correct sorting
7. ✅ High Amount shows only eligible scholarships
8. ✅ Dashboard stats are dynamic numbers
9. ✅ Bookmark functionality works
10. ✅ Apply Now button opens official links

---

**Your ScholarSync application is now fully functional with real data from scholarships.json!** 🎓✨
