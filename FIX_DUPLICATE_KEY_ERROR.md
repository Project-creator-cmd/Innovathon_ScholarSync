# 🔧 Fix Duplicate Key Error - Step by Step Guide

## Problem
You're seeing this error:
```
E11000 duplicate key error collection: scholarsync.scholarships index: id_1 dup key: { id: null }
```

This happens because MongoDB has an old index on the `id` field from a previous schema version.

## Solution

Follow these steps **exactly** in order:

### Step 1: Clean the Database
Run the fix script to drop all old collections and indexes:

```bash
cd backend
node fix-db.js
```

**Expected Output:**
```
🔧 Fixing database indexes and collections...

📋 Found collections: scholarships, successstories, users, ...
✅ Dropped scholarships collection
✅ Dropped successstories collection
✅ Dropped applications collection

✅ Database cleaned successfully!
👉 Now run: npm run seed
```

### Step 2: Import Fresh Data
Now run the seed script to import all 15 scholarships:

```bash
npm run seed
```

**Expected Output:**
```
📚 Found 15 scholarships in JSON file
🗑️  Cleared existing scholarships
✓ Processed: Mahindra Saarthi Abhiyaan Scholarship - ₹10,000 - Status: expired
✓ Processed: Aspire Leaders Program - ₹1,00,000 - Status: live
... (all 15 scholarships)
✅ Inserted 15 scholarships into MongoDB
📊 Creating database indexes...
✅ Database indexes created
🏆 Imported 2 success stories

✅ Data Import Complete!
📚 Total Scholarships: 15
💰 Total Scholarship Amount: ₹[total amount]
📊 Live: 6
📊 Upcoming: 0
📊 Expired: 9
```

### Step 3: Verify the Import
Check that all data is imported correctly:

```bash
node test-eligibility.js
```

This will show you:
- Total scholarships in database
- Sample scholarship data
- Eligibility calculations

### Step 4: Start the Server
```bash
npm start
```

### Step 5: Test in Browser
1. Open http://localhost:5000
2. Login/Signup
3. Check Dashboard - you should see:
   - Proper ₹ amounts (no ₹NaN)
   - Days left badges
   - Blue "View Details" buttons
   - Correct scholarship counts

## What Was Fixed

1. **fix-db.js** - Enhanced to:
   - List all collections before dropping
   - Drop scholarships, successstories, and applications
   - Better error messages
   - More thorough cleanup

2. **seed.js** - Cleaned up:
   - Removed unused imports
   - Better error handling
   - Clearer console output

## If You Still Get Errors

### Error: "Cannot connect to MongoDB"
- Make sure MongoDB is running: `mongod` or start MongoDB service
- Check `.env` file has correct `MONGO_URI`

### Error: "scholarships.json not found"
- The file should be in the root folder (same level as backend/)
- Path: `Scholar/scholarships.json`

### Error: "Module not found"
- Run: `npm install` in backend folder

### Error: Still seeing duplicate key error
1. Connect to MongoDB directly:
   ```bash
   mongosh
   ```
2. Drop the database completely:
   ```javascript
   use scholarsync
   db.dropDatabase()
   exit
   ```
3. Run fix-db.js again
4. Run seed script again

## Verification Checklist

After running the seed script, verify:

- [ ] 15 scholarships imported
- [ ] 6 scholarships with status "live"
- [ ] 9 scholarships with status "expired"
- [ ] All amounts are numbers (no NaN)
- [ ] All dates are valid
- [ ] 2 success stories imported
- [ ] Database indexes created

## Next Steps

Once data is imported successfully:
1. Test all dashboard features
2. Test eligibility filtering
3. Test "Closing Soon" page (should show scholarships ending in ≤7 days)
4. Test "High Amount" page (should show only eligible scholarships ≥₹50,000)
5. Verify all amounts display as ₹10,000 format (not ₹NaN)

## Need Help?

If you're still stuck:
1. Share the complete error message
2. Share output from `node fix-db.js`
3. Share output from `npm run seed`
4. Check MongoDB is running: `mongosh` should connect successfully
