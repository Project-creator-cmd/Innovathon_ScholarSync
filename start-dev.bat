@echo off
echo ========================================
echo ScholarSync Development Startup Script
echo ========================================
echo.

REM Check if MongoDB is running
echo [1/6] Checking MongoDB status...
net start | findstr -i "MongoDB" >nul
if %errorlevel% equ 0 (
    echo ✓ MongoDB is running
) else (
    echo ✗ MongoDB is not running
    echo.
    echo Attempting to start MongoDB service...
    net start MongoDB 2>nul
    if %errorlevel% equ 0 (
        echo ✓ MongoDB started successfully
    ) else (
        echo ✗ Could not start MongoDB service
        echo.
        echo Please install MongoDB or start it manually:
        echo 1. Install from: https://www.mongodb.com/try/download/community
        echo 2. Or use MongoDB Atlas (cloud): https://www.mongodb.com/cloud/atlas
        echo 3. Or start manually: mongod --dbpath C:\data\db
        echo.
        pause
        exit /b 1
    )
)
echo.

REM Check if node_modules exist in backend
echo [2/6] Checking backend dependencies...
if not exist "backend\node_modules" (
    echo Installing backend dependencies...
    cd backend
    call npm install
    cd ..
    echo ✓ Backend dependencies installed
) else (
    echo ✓ Backend dependencies already installed
)
echo.

REM Check if node_modules exist in frontend
echo [3/6] Checking frontend dependencies...
if not exist "frontend\node_modules" (
    echo Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
    echo ✓ Frontend dependencies installed
) else (
    echo ✓ Frontend dependencies already installed
)
echo.

REM Check if port 5000 is in use
echo [4/6] Checking if port 5000 is available...
netstat -ano | findstr :5000 >nul
if %errorlevel% equ 0 (
    echo ✗ Port 5000 is in use
    echo Attempting to free port 5000...
    cd backend
    call npm run kill-port
    cd ..
    timeout /t 2 /nobreak >nul
    echo ✓ Port 5000 freed
) else (
    echo ✓ Port 5000 is available
)
echo.

echo [5/6] Starting Backend Server...
echo Opening new terminal for backend...
start "ScholarSync Backend" cmd /k "cd backend && npm run dev"
timeout /t 3 /nobreak >nul
echo ✓ Backend server starting on http://localhost:5000
echo.

echo [6/6] Starting Frontend Dev Server...
echo Opening new terminal for frontend...
start "ScholarSync Frontend" cmd /k "cd frontend && npm run dev"
timeout /t 3 /nobreak >nul
echo ✓ Frontend dev server starting on http://localhost:3000
echo.

echo ========================================
echo ✓ ScholarSync is starting up!
echo ========================================
echo.
echo Backend:  http://localhost:5000
echo Frontend: http://localhost:3000
echo.
echo Two new terminal windows have opened:
echo 1. Backend Server (port 5000)
echo 2. Frontend Dev Server (port 3000)
echo.
echo Wait a few seconds for servers to fully start,
echo then open your browser to: http://localhost:3000
echo.
echo Press any key to close this window...
pause >nul
