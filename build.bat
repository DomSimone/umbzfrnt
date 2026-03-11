@echo off
REM Build script for Vercel deployment (Windows)
echo 🏗️  Building Umbuzo Frontend for Vercel...

REM Install dependencies
echo 📦 Installing dependencies...
npm install

REM Build the application
echo 🔨 Building application...
npm run build

REM Verify build output
if exist "dist" (
    echo ✅ Build successful! Output directory: dist/
    dir dist
) else (
    echo ❌ Build failed! No output in dist/ directory
    exit /b 1
)

echo 🎉 Frontend build complete!