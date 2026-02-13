# ScholarSync - AI Scholarship Recommendation Platform 🎓

A **production-ready, full-stack** web application that helps students discover personalized scholarships with advanced AI features, document management, and comprehensive planning tools.

## 🚀 Advanced Features

### Core Features
- ✅ **Smart Matching**: AI-powered eligibility filtering based on user profile
- ✅ **Comprehensive Dashboard**: View all scholarships, eligible ones, closing soon, and high-amount scholarships
- ✅ **Bookmark System**: Save scholarships for later review
- ✅ **Profile Management**: Edit and update your profile with profile strength meter

### 🆕 Advanced Features (Production-Ready)

#### 4️⃣ Document Readiness Checker 📂
- Upload and manage all scholarship documents
- Real-time validation of document formats
- Expiry date tracking for certificates
- Per-scholarship readiness check showing:
  - Missing documents
  - Expired certificates
  - Format issues (e.g., photo format validation)
  - Overall readiness score (e.g., "Ready to Apply: 6/8 docs")

#### 5️⃣ Deadline Heatmap Calendar 🗓️
- Visual calendar with color-coded deadlines:
  - 🔴 Red: Closing soon (≤7 days)
  - 🟡 Yellow: Mid deadline (≤30 days)
  - 🟢 Green: Open
- Interactive timeline view
- Monthly/yearly navigation
- Upcoming deadlines list

#### 6️⃣ Scholarship Roadmap Planner 🛣️
- Personalized funding journey from current education to career goals
- Input: Class/Degree, Field, Income
- Output: Year-by-year scholarship recommendations
  - 2026 → Apply to X scholarships
  - 2027 → Apply to Y scholarships
  - Postgraduate → Apply to research funding
- Total estimated funding calculation
- Milestone tracking (upcoming, active, completed)

#### 7️⃣ Community Proof / Past Winners 🏆
- Real success stories from scholarship winners
- Display:
  - Student name and institution
  - Amount won
  - Academic marks (Class X & XII)
  - Winning strategy
  - Key tips for success
  - Testimonials
- Verified badge system
- Filter by scholarship

#### 8️⃣ Scam Detection Layer 🛡️
- AI-powered safety analysis for each scholarship:
  - Trust Score (0-100%)
  - Fake link detection
  - Suspicious domain checking
  - Fee requirement warnings
  - HTTPS validation
- Visual safety indicators:
  - ✓ Verified government/educational domains
  - ⚠️ Warning flags for suspicious patterns
- Real-time scam flag display

#### 9️⃣ One-Click Apply Hub 🔗
Enhanced scholarship detail page with:
- Official application link
- Required documents checklist
- Estimated time to complete
- Difficulty level (Easy/Medium/Hard)
- Success rate statistics
- Document readiness status
- Past winner strategies

#### 🔟 AI Chat Guide (Scholarship GPT) 💬
- Natural language scholarship assistant
- Intelligent query understanding:
  - "I am diploma CSE, income 2L, what can I apply?"
  - "Show me scholarships closing soon"
  - "What documents do I need?"
- Personalized responses with:
  - Matched scholarships
  - Deadline information
  - Application tips
  - Eligibility guidance
- Chat history tracking
- Quick question suggestions

## 🛠️ Tech Stack

### Backend
- Node.js + Express.js
- MongoDB + Mongoose
- JWT Authentication
- bcrypt for password hashing
- Advanced scam detection algorithms
- AI-powered chat responses

### Frontend
- React (Vite)
- Tailwind CSS
- React Router
- Axios
- Context API for state management
- Lucide React for icons
- Interactive calendar components

## 📁 Enhanced Project Structure

```
ScholarSync/
├── backend/
│   ├── config/
│   │   └── db.js
│   ├── models/
│   │   ├── User.js
│   │   ├── Scholarship.js
│   │   ├── Notification.js
│   │   ├── Document.js
│   │   ├── ScholarshipRoadmap.js
│   │   ├── SuccessStory.js
│   │   └── ChatMessage.js
│   ├── routes/
│   │   ├── authRoutes.js
│   │   ├── scholarshipRoutes.js
│   │   ├── bookmarkRoutes.js
│   │   ├── notificationRoutes.js
│   │   ├── documentRoutes.js
│   │   ├── roadmapRoutes.js
│   │   ├── successStoryRoutes.js
│   │   └── chatRoutes.js
│   ├── controllers/
│   │   ├── authController.js
│   │   ├── scholarshipController.js
│   │   ├── bookmarkController.js
│   │   ├── notificationController.js
│   │   ├── documentController.js
│   │   ├── roadmapController.js
│   │   ├── successStoryController.js
│   │   └── chatController.js
│   ├── utils/
│   │   └── scamDetection.js
│   ├── middleware/
│   │   └── authMiddleware.js
│   ├── server.js
│   ├── seed.js
│   └── .env
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Sidebar.jsx
│   │   │   ├── Navbar.jsx
│   │   │   └── ScholarshipCard.jsx
│   │   ├── pages/
│   │   │   ├── LandingPage.jsx
│   │   │   ├── SplashScreen.jsx
│   │   │   ├── Login.jsx
│   │   │   ├── Signup.jsx
│   │   │   ├── Dashboard.jsx
│   │   │   ├── ScholarshipDetail.jsx
│   │   │   ├── Bookmarks.jsx
│   │   │   ├── Profile.jsx
│   │   │   ├── DocumentManager.jsx
│   │   │   ├── DeadlineCalendar.jsx
│   │   │   ├── ScholarshipRoadmap.jsx
│   │   │   ├── SuccessStories.jsx
│   │   │   └── ScholarshipChat.jsx
│   │   ├── context/
│   │   │   └── AuthContext.jsx
│   │   ├── utils/
│   │   │   └── api.js
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css
│   └── index.html
└── scholarships.json
```

## 🚦 Getting Started

**New to the project? Start here:** [QUICK_START.md](QUICK_START.md) - Get running in 5 minutes!

### Prerequisites
- Node.js (v16 or higher)
- MongoDB (local or Atlas)
- npm or yarn

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd ScholarSync
```

2. **Setup Backend**
```bash
cd backend
npm install
```

3. **Configure Environment Variables**
Create a `.env` file in the backend directory:
```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/scholarsync
JWT_SECRET=your_jwt_secret_key_change_in_production_2024
JWT_EXPIRE=1d
NODE_ENV=development
```

4. **Seed Database**
```bash
npm run seed
```

5. **Start Backend Server**
```bash
npm run dev
```

6. **Setup Frontend** (in a new terminal)
```bash
cd frontend
npm install
```

7. **Start Frontend Development Server**
```bash
npm run dev
```

8. **Access the Application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

## 🧪 Testing Eligibility

To test the eligibility matching logic:

```bash
cd backend
npm run test-eligibility
```

This will show you which scholarships match different student profiles.

You can also use the debug endpoint after logging in:
```bash
# Get your token after login, then:
curl http://localhost:5000/api/scholarships/debug-eligibility \
  -H "Authorization: Bearer YOUR_TOKEN"
```

## 📊 Database Schema

### User Schema
- name, email, password (hashed)
- age, gender, state, category
- annualIncome, educationLevel, instituteName
- gpa10, gpa12, guardianOccupation
- bookmarks (array of Scholarship IDs)

### Scholarship Schema
- name, apply_link, category
- maxIncome, educationLevel
- deadline, startDate, scholarshipAmount
- stackable, eligibilityRules, documentsRequired

### Notification Schema
- userId, message, isRead, createdAt

## 🔐 Enhanced API Endpoints

### Authentication
- `POST /api/auth/signup` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/profile` - Get user profile (Protected)
- `PUT /api/auth/profile` - Update user profile (Protected)

### Scholarships
- `GET /api/scholarships` - Get all scholarships (Protected)
- `GET /api/scholarships/:id` - Get scholarship by ID (Protected)
- `GET /api/scholarships/eligible` - Get eligible scholarships (Protected)
- `GET /api/scholarships/closing-soon` - Get closing soon scholarships (Protected)
- `GET /api/scholarships/high-amount` - Get high amount scholarships (Protected)

### Bookmarks
- `GET /api/bookmark` - Get user bookmarks (Protected)
- `POST /api/bookmark/:id` - Add bookmark (Protected)
- `DELETE /api/bookmark/:id` - Remove bookmark (Protected)

### Notifications
- `GET /api/notifications` - Get user notifications (Protected)
- `PUT /api/notifications/:id` - Mark notification as read (Protected)
- `PUT /api/notifications/mark-all-read` - Mark all as read (Protected)

### 🆕 Documents
- `POST /api/documents/upload` - Upload document (Protected)
- `GET /api/documents` - Get user documents (Protected)
- `GET /api/documents/readiness/:scholarshipId` - Check document readiness (Protected)
- `GET /api/documents/overall-readiness` - Get overall readiness (Protected)
- `DELETE /api/documents/:id` - Delete document (Protected)

### 🆕 Roadmap
- `POST /api/roadmap/generate` - Generate scholarship roadmap (Protected)
- `GET /api/roadmap` - Get user roadmap (Protected)
- `PUT /api/roadmap/milestone/:year` - Update milestone status (Protected)

### 🆕 Success Stories
- `GET /api/success-stories` - Get all success stories (Public)
- `GET /api/success-stories/scholarship/:id` - Get stories by scholarship (Public)
- `POST /api/success-stories` - Submit success story (Protected)

### 🆕 AI Chat
- `POST /api/chat` - Send chat message (Protected)
- `GET /api/chat/history` - Get chat history (Protected)

## 🎨 Design Features

- Clean SaaS design inspired by Stripe/Linear
- White background with blue primary theme
- Inter font family
- Rounded-xl cards with soft shadows
- Smooth hover transitions
- Fully responsive layout
- Loading states and error handling

## 🔒 Security Features

- Password hashing with bcrypt
- JWT token authentication
- Protected routes
- Input validation
- CORS enabled

## 📝 License

MIT License

## 📚 Additional Documentation

- **[SETUP_INSTRUCTIONS.md](backend/SETUP_INSTRUCTIONS.md)** - Detailed setup guide with MongoDB commands and testing
- **[ELIGIBILITY_LOGIC.md](ELIGIBILITY_LOGIC.md)** - Complete explanation of how scholarship matching works with examples
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Solutions for common issues

## 🔍 Understanding Eligibility

A student is eligible for a scholarship if ALL three conditions are met:

1. **Income**: Student's annual income ≤ Scholarship's max income
2. **Category**: 
   - Scholarship is "General" (open to all), OR
   - Student's category matches scholarship category, OR
   - Student is "General" category
3. **Education Level**: Must match exactly (Undergraduate, Postgraduate, etc.)

See [ELIGIBILITY_LOGIC.md](ELIGIBILITY_LOGIC.md) for detailed examples.

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 🙏 Acknowledgments

- Scholarship data sourced from various government and private scholarship programs
- Icons by Lucide React
- UI inspiration from Stripe and Linear
