# Eligibility Logic Explained

## How Scholarship Matching Works

ScholarSync uses a **3-factor eligibility system**. A student is eligible for a scholarship ONLY if ALL three conditions are met:

### 1. Income Eligibility ✅

```javascript
student.annualIncome <= scholarship.maxIncome
```

**Example:**
- Student income: ₹3,00,000
- Scholarship max income: ₹5,00,000
- ✅ ELIGIBLE (3 lakh ≤ 5 lakh)

- Student income: ₹6,00,000
- Scholarship max income: ₹4,00,000
- ❌ NOT ELIGIBLE (6 lakh > 4 lakh)

### 2. Category Eligibility ✅

```javascript
scholarship.category === 'General' OR
scholarship.category === student.category OR
student.category === 'General'
```

**Logic:**
- "General" category scholarships are open to ALL students
- Category-specific scholarships (SC/ST/OBC/etc.) are for those categories
- "General" category students can apply to General scholarships only

**Examples:**

| Student Category | Scholarship Category | Eligible? | Why |
|-----------------|---------------------|-----------|-----|
| General | General | ✅ | Match |
| General | SC | ❌ | Student not SC |
| SC | General | ✅ | General open to all |
| SC | SC | ✅ | Match |
| SC | OBC | ❌ | Categories don't match |
| OBC | General | ✅ | General open to all |

### 3. Education Level Eligibility ✅

```javascript
student.educationLevel === scholarship.educationLevel
```

**Must be EXACT match:**
- High School
- Undergraduate
- Postgraduate
- Doctorate

**Examples:**
- Student: "Undergraduate", Scholarship: "Undergraduate" → ✅
- Student: "Undergraduate", Scholarship: "Postgraduate" → ❌
- Student: "Postgraduate", Scholarship: "Undergraduate" → ❌

## Complete Examples

### Example 1: General Undergraduate Student

**Student Profile:**
```
Name: Rahul Sharma
Annual Income: ₹5,00,000
Category: General
Education Level: Undergraduate
```

**Scholarship: National Merit Scholarship**
```
Max Income: ₹8,00,000
Category: General
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹5,00,000 ≤ ₹8,00,000 → ✅
2. Category: General = General → ✅
3. Education: Undergraduate = Undergraduate → ✅

**Result: ✅ ELIGIBLE**

---

### Example 2: SC Category Student

**Student Profile:**
```
Name: Priya Kumar
Annual Income: ₹2,00,000
Category: SC
Education Level: Undergraduate
```

**Scholarship A: SC/ST National Scholarship**
```
Max Income: ₹2,50,000
Category: SC
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹2,00,000 ≤ ₹2,50,000 → ✅
2. Category: SC = SC → ✅
3. Education: Undergraduate = Undergraduate → ✅

**Result: ✅ ELIGIBLE**

---

**Scholarship B: National Merit Scholarship**
```
Max Income: ₹8,00,000
Category: General
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹2,00,000 ≤ ₹8,00,000 → ✅
2. Category: General (open to all) → ✅
3. Education: Undergraduate = Undergraduate → ✅

**Result: ✅ ELIGIBLE**

---

**Scholarship C: OBC Merit Scholarship**
```
Max Income: ₹4,00,000
Category: OBC
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹2,00,000 ≤ ₹4,00,000 → ✅
2. Category: SC ≠ OBC → ❌
3. Education: Undergraduate = Undergraduate → ✅

**Result: ❌ NOT ELIGIBLE** (Category mismatch)

---

### Example 3: High Income Student

**Student Profile:**
```
Name: Amit Patel
Annual Income: ₹10,00,000
Category: General
Education Level: Undergraduate
```

**Scholarship: Central Sector Scholarship**
```
Max Income: ₹4,50,000
Category: General
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹10,00,000 ≤ ₹4,50,000 → ❌
2. Category: General = General → ✅
3. Education: Undergraduate = Undergraduate → ✅

**Result: ❌ NOT ELIGIBLE** (Income too high)

---

### Example 4: Postgraduate Student

**Student Profile:**
```
Name: Sneha Reddy
Annual Income: ₹6,00,000
Category: General
Education Level: Postgraduate
```

**Scholarship A: Women Empowerment Scholarship**
```
Max Income: ₹6,00,000
Category: General
Education Level: Postgraduate
```

**Eligibility Check:**
1. Income: ₹6,00,000 ≤ ₹6,00,000 → ✅
2. Category: General = General → ✅
3. Education: Postgraduate = Postgraduate → ✅

**Result: ✅ ELIGIBLE**

---

**Scholarship B: National Merit Scholarship**
```
Max Income: ₹8,00,000
Category: General
Education Level: Undergraduate
```

**Eligibility Check:**
1. Income: ₹6,00,000 ≤ ₹8,00,000 → ✅
2. Category: General = General → ✅
3. Education: Postgraduate ≠ Undergraduate → ❌

**Result: ❌ NOT ELIGIBLE** (Education level mismatch)

## Common Misconceptions

### ❌ Myth: "I'm General category, so I can apply to SC scholarships"
**Reality:** No. SC scholarships are specifically for SC category students. General students can only apply to General category scholarships.

### ❌ Myth: "If my income is close to the limit, I'm eligible"
**Reality:** Your income must be LESS THAN OR EQUAL TO the max income. If scholarship max is ₹5,00,000 and your income is ₹5,00,001, you're NOT eligible.

### ❌ Myth: "Postgraduate students can apply to Undergraduate scholarships"
**Reality:** No. Education level must match exactly. Postgraduate students can only apply to Postgraduate scholarships.

### ❌ Myth: "If I meet 2 out of 3 criteria, I'm partially eligible"
**Reality:** No. You must meet ALL THREE criteria. Even if you meet income and category but not education level, you're NOT eligible.

## Testing Your Eligibility

### Method 1: Use the Dashboard
1. Login to ScholarSync
2. Go to "Eligible" in the sidebar
3. See only scholarships you qualify for

### Method 2: Use Debug Endpoint
```bash
# After login, get your token
curl http://localhost:5000/api/scholarships/debug-eligibility \
  -H "Authorization: Bearer YOUR_TOKEN"
```

This shows:
- Your profile details
- Each scholarship
- Why you are/aren't eligible for each one

### Method 3: Run Test Script
```bash
cd backend
npm run test-eligibility
```

This shows eligibility for different test profiles.

## Tips for Maximum Eligibility

1. **Keep Profile Updated**
   - Update income if it changes
   - Update education level when you progress
   - Ensure all fields are filled

2. **Check Multiple Categories**
   - General scholarships are open to all
   - Category-specific scholarships are additional opportunities

3. **Plan Ahead**
   - Some scholarships have different education levels
   - Check what you'll be eligible for next year

4. **Income Threshold**
   - If you're close to a threshold, check if you can apply
   - Some scholarships have higher limits

## Code Reference

The eligibility logic is in `backend/controllers/scholarshipController.js`:

```javascript
export const getEligibleScholarships = async (req, res) => {
  const user = await User.findById(req.user._id);
  const allScholarships = await Scholarship.find({});

  const eligibleScholarships = allScholarships.filter(scholarship => {
    // Check 1: Income
    const incomeEligible = user.annualIncome <= scholarship.maxIncome;

    // Check 2: Category
    const categoryEligible = 
      scholarship.category === 'General' || 
      scholarship.category === user.category ||
      user.category === 'General';

    // Check 3: Education Level
    const educationEligible = scholarship.educationLevel === user.educationLevel;

    // ALL must be true
    return incomeEligible && categoryEligible && educationEligible;
  });

  res.json(eligibleScholarships);
};
```

## Questions?

If you're not seeing expected scholarships:
1. Check your profile values (especially income, category, education)
2. Use the debug endpoint to see detailed eligibility breakdown
3. Verify scholarship data in database
4. See TROUBLESHOOTING.md for more help
