# 🚀 START HERE - ScholarSync Quick Start

## ⚡ 3-Step Setup (5 Minutes)

### Step 0: Fix Database (If You See Duplicate Key Error)

**If you see this error:**
```
E11000 duplicate key error collection: scholarsync.scholarships index: id_1 dup key: { id: null }
```

**Run this first:**
```bash
cd backend
npm run fix-db
```

This will clean all old indexes and collections. Then proceed to Step 1.

**📖 For detailed troubleshooting, see:** `FIX_DUPLICATE_KEY_ERROR.md`

### Step 1: Seed Database from scholarships.json

```bash
cd backend
npm install
npm run seed
```

**✅ You should see:**
```
📚 Found 15 scholarships in JSON file
✓ Processed: Mahindra Saarthi Abhiyaan Scholarship - ₹10,000 - Status: expired
✓ Processed: Aspire Leaders Program - ₹1,00,000 - Status: live
... (15 total)
✅ Inserted 15 scholarships into MongoDB
📊 Live: 6
📊 Expired: 9
```

**Verify the import:**
```bash
npm run verify
```

### Step 2: Start Backend

```bash
npm run dev
```

**✅ You should see:**
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

**✅ You should see:**
```
➜  Local:   http://localhost:3000/
```

## 🌐 Open Application

**Go to:** http://localhost:3000

## 🧪 Quick Test

### 1. Register
- Click "Get Started"
- Fill in details:
  - Name: Test Student
  - Email: test@example.com
  - Password: test123
  - Category: SC
  - Income: 250000
  - Education: Undergraduate

### 2. Check Dashboard
- Should see 7 live scholarships
- Each card has:
  - ✅ Days left badge (top right)
  - ✅ Blue "View Details" button
  - ✅ Proper ₹ amount (no NaN)

### 3. Test Filters
- **Eligible**: Shows personalized scholarships
- **Closing Soon**: Shows scholarships ≤ 7 days
- **High Amount**: Shows eligible scholarships ≥ ₹50,000

## ✅ Success Indicators

You'll know it's working when:
1. Dashboard shows "Total Live: 7"
2. No ₹NaN errors anywhere
3. Days left badges are color-coded
4. "View Details" button is blue
5. Eligible page shows personalized results

## 🐛 Troubleshooting

**Problem**: No scholarships showing
**Solution**: Run `npm run seed` in backend folder

**Problem**: ₹NaN appearing
**Solution**: Re-run seed script

**Problem**: MongoDB connection error
**Solution**: Start MongoDB service

## 📚 Documentation

- **QUICK_RUN_GUIDE.md** - Detailed testing guide
- **SEED_VERIFICATION.md** - Data verification
- **FINAL_IMPLEMENTATION_SUMMARY.md** - Complete overview

## 🎉 That's It!

Your ScholarSync application is now running with real data from scholarships.json!

**Happy Testing!** 🎓✨
