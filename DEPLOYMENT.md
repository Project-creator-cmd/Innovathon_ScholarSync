# ScholarSync - Deployment Guide

## 🚀 Quick Start (Development)

### Prerequisites
- Node.js v16+ 
- MongoDB (local or Atlas)
- npm or yarn

### Backend Setup

```bash
# Navigate to backend
cd backend

# Install dependencies
npm install

# Configure environment
# Edit .env file with your MongoDB URI and JWT secret

# Seed database with scholarships and success stories
npm run seed

# Start development server
npm run dev
```

Backend will run on `http://localhost:5000`

### Frontend Setup

```bash
# Navigate to frontend (in new terminal)
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

Frontend will run on `http://localhost:3000`

## 🌐 Production Deployment

### Option 1: Traditional VPS (DigitalOcean, AWS EC2, etc.)

#### Backend Deployment

```bash
# On your server
git clone <your-repo>
cd ScholarSync/backend

# Install dependencies
npm install --production

# Set environment variables
export MONGODB_URI="your_mongodb_atlas_uri"
export JWT_SECRET="your_secure_jwt_secret"
export NODE_ENV="production"
export PORT=5000

# Seed database (first time only)
npm run seed

# Install PM2 for process management
npm install -g pm2

# Start with PM2
pm2 start server.js --name scholarsync-api
pm2 save
pm2 startup
```

#### Frontend Deployment

```bash
cd ../frontend

# Build for production
npm run build

# Serve with nginx or any static server
# Copy dist/ folder to your web server
```

### Option 2: Heroku

#### Backend (Heroku)

```bash
cd backend

# Login to Heroku
heroku login

# Create app
heroku create scholarsync-api

# Add MongoDB Atlas addon or use your own
heroku addons:create mongolab:sandbox

# Set environment variables
heroku config:set JWT_SECRET="your_jwt_secret"
heroku config:set NODE_ENV="production"

# Deploy
git push heroku main

# Seed database
heroku run npm run seed
```

#### Frontend (Vercel/Netlify)

**Vercel:**
```bash
cd frontend

# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Set environment variable for API URL
# In Vercel dashboard: VITE_API_URL=https://your-api.herokuapp.com
```

**Netlify:**
```bash
# Build
npm run build

# Deploy dist/ folder via Netlify dashboard or CLI
netlify deploy --prod --dir=dist
```

### Option 3: Docker

#### Backend Dockerfile

```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
```

#### Frontend Dockerfile

```dockerfile
FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Docker Compose

```yaml
version: '3.8'
services:
  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

  backend:
    build: ./backend
    ports:
      - "5000:5000"
    environment:
      - MONGODB_URI=mongodb://mongodb:27017/scholarsync
      - JWT_SECRET=your_jwt_secret
      - NODE_ENV=production
    depends_on:
      - mongodb

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  mongo-data:
```

Run with:
```bash
docker-compose up -d
```

### Option 4: Cloud Platforms

#### AWS (Elastic Beanstalk + RDS)

1. **Backend**: Deploy to Elastic Beanstalk
2. **Database**: Use MongoDB Atlas or DocumentDB
3. **Frontend**: Deploy to S3 + CloudFront

#### Google Cloud Platform

1. **Backend**: Deploy to App Engine or Cloud Run
2. **Database**: Use MongoDB Atlas
3. **Frontend**: Deploy to Firebase Hosting or Cloud Storage

#### Microsoft Azure

1. **Backend**: Deploy to App Service
2. **Database**: Use Cosmos DB (MongoDB API) or MongoDB Atlas
3. **Frontend**: Deploy to Static Web Apps

## 🔧 Environment Variables

### Backend (.env)

```env
PORT=5000
MONGODB_URI=mongodb://localhost:27017/scholarsync
JWT_SECRET=your_super_secret_jwt_key_change_in_production
JWT_EXPIRE=1d
NODE_ENV=production
```

### Frontend (Vite)

Update `vite.config.js` for production API URL:

```javascript
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: process.env.VITE_API_URL || 'http://localhost:5000',
        changeOrigin: true
      }
    }
  }
})
```

## 🔒 Security Checklist

- [ ] Change JWT_SECRET to a strong random string
- [ ] Use HTTPS in production
- [ ] Enable CORS only for your frontend domain
- [ ] Set secure cookie flags
- [ ] Use environment variables for all secrets
- [ ] Enable rate limiting
- [ ] Add helmet.js for security headers
- [ ] Validate all user inputs
- [ ] Use MongoDB Atlas with IP whitelist
- [ ] Enable MongoDB authentication
- [ ] Regular security updates
- [ ] Implement logging and monitoring

## 📊 Database Setup

### MongoDB Atlas (Recommended)

1. Create account at mongodb.com/cloud/atlas
2. Create a cluster (free tier available)
3. Create database user
4. Whitelist IP addresses
5. Get connection string
6. Update MONGODB_URI in .env

### Local MongoDB

```bash
# Install MongoDB
# macOS
brew install mongodb-community

# Ubuntu
sudo apt-get install mongodb

# Start MongoDB
mongod --dbpath /path/to/data
```

## 🧪 Testing

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test
```

## 📈 Monitoring

### Recommended Tools

- **Backend**: PM2, New Relic, Datadog
- **Database**: MongoDB Atlas monitoring
- **Frontend**: Google Analytics, Sentry
- **Uptime**: UptimeRobot, Pingdom

### PM2 Monitoring

```bash
pm2 monit
pm2 logs scholarsync-api
```

## 🔄 CI/CD Pipeline

### GitHub Actions Example

```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Deploy Backend
        run: |
          # Your deployment commands
          
      - name: Deploy Frontend
        run: |
          # Your deployment commands
```

## 📱 Mobile App (Future)

The API is ready for mobile app integration:
- React Native
- Flutter
- Native iOS/Android

## 🎯 Performance Optimization

### Backend
- Enable gzip compression
- Use Redis for caching
- Implement pagination
- Add database indexes
- Use CDN for static assets

### Frontend
- Code splitting
- Lazy loading
- Image optimization
- Bundle size optimization
- Service workers for PWA

## 🆘 Troubleshooting

### Common Issues

**MongoDB Connection Error**
```bash
# Check MongoDB is running
mongod --version

# Check connection string format
mongodb://username:password@host:port/database
```

**Port Already in Use**
```bash
# Find process using port
lsof -i :5000

# Kill process
kill -9 <PID>
```

**CORS Error**
- Update CORS settings in backend/server.js
- Ensure frontend URL is whitelisted

## 📞 Support

For deployment issues:
1. Check logs: `pm2 logs` or `heroku logs --tail`
2. Verify environment variables
3. Check database connection
4. Review error messages

## 🎉 Post-Deployment

1. Test all features
2. Seed database with scholarships
3. Create admin user
4. Set up monitoring
5. Configure backups
6. Document API endpoints
7. Set up SSL certificate
8. Configure domain name
9. Enable analytics
10. Launch! 🚀

## 📝 Maintenance

- Regular database backups
- Security updates
- Performance monitoring
- User feedback collection
- Feature updates
- Bug fixes

---

**Congratulations!** Your ScholarSync platform is now deployed and ready to help students find scholarships! 🎓
