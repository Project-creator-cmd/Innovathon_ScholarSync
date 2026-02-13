# 🔄 Migration Guide: 3-Section Layout Update

## Quick Migration (5 Minutes)

### Step 1: Clean Database
```bash
cd backend
npm run fix-db
```

**Expected Output:**
```
🔧 Fixing database indexes and collections...
✅ Dropped scholarships collection
✅ Dropped successstories collection
✅ Database cleaned successfully!
```

### Step 2: Import Fresh Data
```bash
npm run seed
```

**Expected Output:**
```
📚 Found 15 scholarships in JSON file
✓ Processed: [15 scholarships]
✅ Inserted 15 scholarships into MongoDB
📊 Live: 6
📊 Closed: 9
```

### Step 3: Verify Import
```bash
npm run verify
```

**Expected Output:**
```
✅ All scholarship amounts are valid numbers
✅ VERIFICATION COMPLETE!
📋 CHECKLIST:
   ✅ 15 scholarships imported
   ✅ All amounts are valid
   ✅ Success stories imported
   ✅ Database indexes created
```

### Step 4: Start Servers

**Backend:**
```bash
npm start
```

**Frontend (new terminal):**
```bash
cd ../frontend
npm run dev
```

### Step 5: Test New Features

Open browser: http://localhost:3000

1. **Test All Scholarships Page**
   - Click "All Scholarships" in sidebar
   - Should see 3 tabs: Live / Upcoming / Closed
   - Verify counts match

2. **Test Eligible Page**
   - Click "Eligible" in sidebar
   - Should see 3 tabs with eligible scholarships only
   - Verify personalized messaging

3. **Test Scholarship Details**
   - Click any scholarship
   - Verify Apply button shows correct state:
     - Live → Blue "APPLY NOW"
     - Upcoming → Yellow "REGISTRATION NOT STARTED"
     - Closed → Gray "REGISTRATIONS CLOSED"

## What Changed?

### Database Schema
- **Added**: `registrationStartDate` field (Date, required)
- **Changed**: Status enum: 'expired' → 'closed'
- **Added**: Performance indexes

### API Endpoints
- **NEW**: `GET /api/scholarships/all` - Returns `{ live, upcoming, closed }`
- **NEW**: `GET /api/scholarships/eligible` - Returns `{ live, upcoming, closed }`
- **Updated**: Existing endpoints now calculate status dynamically

### Frontend Routes
- **NEW**: `/scholarships` - All Scholarships page with 3 tabs
- **NEW**: `/eligible` - Eligible Scholarships page with 3 tabs
- **Updated**: Sidebar navigation

## Troubleshooting

### Issue: "registrationStartDate is required"
**Solution**: Run `npm run fix-db` then `npm run seed`

### Issue: Still seeing 'expired' status
**Solution**: Database not updated. Run migration steps again.

### Issue: Eligible page shows no scholarships
**Solution**: 
1. Check your profile has all required fields
2. Verify scholarships exist in database
3. Check browser console for errors

### Issue: Apply button not working
**Solution**: 
1. Check scholarship status in database
2. Verify `applicationLink` field exists
3. Check browser console for errors

## Rollback (If Needed)

If you need to rollback:

1. **Restore old seed data**:
   ```bash
   # Use git to restore old seed.js
   git checkout HEAD~1 backend/seed.js
   npm run seed
   ```

2. **Revert frontend changes**:
   ```bash
   git checkout HEAD~1 frontend/src/
   ```

3. **Restart servers**

## API Changes for External Integrations

If you have external services using the API:

### Old Eligible Endpoint
```javascript
// OLD: Returns array
GET /api/scholarships/eligible
Response: [scholarship1, scholarship2, ...]
```

### New Eligible Endpoint
```javascript
// NEW: Returns object with 3 arrays
GET /api/scholarships/eligible
Response: {
  live: [scholarship1, ...],
  upcoming: [scholarship2, ...],
  closed: [scholarship3, ...]
}
```

**Migration Code:**
```javascript
// OLD CODE
const scholarships = await fetch('/api/scholarships/eligible');
// Use scholarships array

// NEW CODE
const { live, upcoming, closed } = await fetch('/api/scholarships/eligible');
// Use live, upcoming, or closed arrays
// Or combine: const all = [...live, ...upcoming, ...closed];
```

## Performance Improvements

After migration, you should see:
- ✅ Faster scholarship queries (lean queries + indexes)
- ✅ Faster eligibility calculations (optimized logic)
- ✅ Better user experience (clear status separation)
- ✅ Reduced database load (field selection)

## Verification Checklist

After migration, verify:

- [ ] Database has 15 scholarships
- [ ] All scholarships have `registrationStartDate`
- [ ] Status is 'live', 'upcoming', or 'closed' (not 'expired')
- [ ] All Scholarships page loads with 3 tabs
- [ ] Eligible page loads with 3 tabs
- [ ] Scholarship detail page shows correct Apply button state
- [ ] Sidebar navigation works
- [ ] Dashboard still functional
- [ ] Bookmarks still work
- [ ] All other features intact

## Support

Need help? Check these files:
- `3_SECTION_LAYOUT_IMPLEMENTATION.md` - Complete implementation details
- `FIX_DUPLICATE_KEY_ERROR.md` - Database troubleshooting
- `START_HERE.md` - Quick start guide
- `TROUBLESHOOTING.md` - General troubleshooting

---

**Migration Time**: ~5 minutes
**Downtime Required**: Yes (during database migration)
**Data Loss**: No (data is re-imported from scholarships.json)
