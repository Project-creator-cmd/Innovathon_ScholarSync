@echo off
echo ========================================
echo ScholarSync Setup Diagnostic Tool
echo ========================================
echo.

echo [Checking Node.js]
node --version >nul 2>&1
if %errorlevel% equ 0 (
    node --version
    echo ✓ Node.js is installed
) else (
    echo ✗ Node.js is NOT installed
    echo Please install from: https://nodejs.org/
)
echo.

echo [Checking npm]
npm --version >nul 2>&1
if %errorlevel% equ 0 (
    npm --version
    echo ✓ npm is installed
) else (
    echo ✗ npm is NOT installed
)
echo.

echo [Checking MongoDB]
mongod --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ MongoDB is installed
    mongod --version | findstr "version"
) else (
    echo ✗ MongoDB is NOT installed or not in PATH
    echo Install from: https://www.mongodb.com/try/download/community
)
echo.

echo [Checking MongoDB Service]
net start | findstr -i "MongoDB" >nul
if %errorlevel% equ 0 (
    echo ✓ MongoDB service is running
) else (
    echo ✗ MongoDB service is NOT running
)
echo.

echo [Checking Port 5000]
netstat -ano | findstr :5000 >nul
if %errorlevel% equ 0 (
    echo ✗ Port 5000 is IN USE
    echo Run: cd backend ^&^& npm run kill-port
) else (
    echo ✓ Port 5000 is available
)
echo.

echo [Checking Port 3000]
netstat -ano | findstr :3000 >nul
if %errorlevel% equ 0 (
    echo ✗ Port 3000 is IN USE
) else (
    echo ✓ Port 3000 is available
)
echo.

echo [Checking Backend Dependencies]
if exist "backend\node_modules" (
    echo ✓ Backend node_modules exists
) else (
    echo ✗ Backend dependencies NOT installed
    echo Run: cd backend ^&^& npm install
)
echo.

echo [Checking Frontend Dependencies]
if exist "frontend\node_modules" (
    echo ✓ Frontend node_modules exists
) else (
    echo ✗ Frontend dependencies NOT installed
    echo Run: cd frontend ^&^& npm install
)
echo.

echo [Checking Backend .env]
if exist "backend\.env" (
    echo ✓ Backend .env file exists
) else (
    echo ✗ Backend .env file NOT found
)
echo.

echo [Checking Vite Config]
if exist "frontend\vite.config.js" (
    echo ✓ Vite config exists
) else (
    echo ✗ Vite config NOT found
)
echo.

echo ========================================
echo Diagnostic Complete
echo ========================================
echo.
echo Next Steps:
echo 1. Install any missing software
echo 2. Run: start-dev.bat to start servers
echo 3. Or manually start:
echo    - Backend: cd backend ^&^& npm run dev
echo    - Frontend: cd frontend ^&^& npm run dev
echo.
pause
