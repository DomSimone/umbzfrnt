# Vercel Frontend Deployment Guide

## Overview

This guide provides step-by-step instructions to resolve the "Invalid Version" error and successfully deploy the Umbuzo frontend to Vercel.

## Problem Resolution

### Issue: "Invalid Version" Error
The error occurred due to conflicts in the `package.json` file between different build tools and missing proper configuration for Vercel deployment.

### Solution Applied
1. **Fixed package.json**: Removed conflicting dependencies and scripts
2. **Added Vite configuration**: Proper build configuration for modern frontend
3. **Created Vercel config**: Specific deployment configuration
4. **Added build scripts**: Automated build process

## Files Modified/Created

### 1. `frontend/package.json` (Fixed)
- Removed conflicting `react-scripts` and `typescript` dependencies
- Updated scripts to use Vite instead of Create React App
- Added proper `engines` field for Node.js version
- Simplified dependency structure

### 2. `frontend/vite.config.js` (New)
- Vite configuration for optimized builds
- Production optimizations (minification, source map removal)
- Development and preview server configuration

### 3. `frontend/vercel.json` (New)
- Vercel-specific deployment configuration
- Static build configuration
- Route handling for SPA
- Function runtime specification

### 4. `frontend/build.sh` & `frontend/build.bat` (New)
- Cross-platform build scripts
- Dependency installation and build verification
- Error handling and feedback

## Deployment Steps

### Method 1: Direct Vercel Deployment (Recommended)

1. **Push to GitHub/GitLab**
   ```bash
   git add .
   git commit -m "Fix Vercel deployment - resolve invalid version error"
   git push origin main
   ```

2. **Connect to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Import your project from Git
   - Select the frontend directory as the root

3. **Configure Build Settings**
   - **Framework Preset**: `Other`
   - **Build Command**: `cd frontend && npm run build`
   - **Output Directory**: `frontend/dist` (or set in Project Settings → Build & Development Settings)
   - **Install Command**: `cd frontend && npm install`

   **Alternative: Set Output Directory in Project Settings**
   - Go to Project Settings → Build & Development Settings
   - Set "Output Directory" to: `frontend/dist`
   - This matches the `outputDirectory` field in `vercel.json`

4. **Environment Variables** (if needed)
   - Add any required environment variables
   - Configure API endpoints if different from default

### Method 2: Manual Deployment

1. **Build Locally**
   ```bash
   cd frontend
   npm install
   npm run build
   ```

2. **Deploy via Vercel CLI**
   ```bash
   npm install -g vercel
   vercel --prod
   ```

## Configuration Details

### Package.json Structure
```json
{
  "name": "umbuzo-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "axios": "^1.6.0"
  },
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^5.0.0",
    "@vitejs/plugin-react": "^4.0.0"
  },
  "engines": {
    "node": ">=18.0.0"
  }
}
```

### Vercel Configuration
```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ],
  "functions": {
    "api/**/*.js": {
      "runtime": "nodejs18.x"
    }
  }
}
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Ensure Node.js version >= 18.0.0
   - Check for missing dependencies in package.json
   - Verify build command in Vercel settings

2. **Missing Dependencies**
   - Run `npm install` locally to verify
   - Check Vercel build logs for specific errors
   - Ensure all required packages are in dependencies

3. **Route Issues**
   - Verify `vercel.json` routes configuration
   - Ensure SPA routing is handled correctly
   - Check for 404 errors on page refresh

4. **Environment Variables**
   - Add required env vars in Vercel dashboard
   - Use `NEXT_PUBLIC_` prefix for client-side variables
   - Verify API endpoints are correct

### Debug Commands

```bash
# Check Vercel logs
vercel logs

# Verify build locally
cd frontend
npm run build

# Test preview
npm run preview

# Check package.json validity
npm view umbuzo-frontend version
```

## Performance Optimization

### Build Optimizations
- **Minification**: Enabled in vite.config.js
- **Source Maps**: Disabled in production
- **Console Removal**: Automatic in build process

### Vercel Optimizations
- **Edge Network**: Automatic with Vercel
- **Caching**: Built-in static asset caching
- **Compression**: Automatic gzip/brotli

## Post-Deployment

### Verification Steps
1. Visit the deployed URL
2. Check console for errors
3. Test all major functionality
4. Verify API connections
5. Test on different devices/browsers

### Monitoring
- Use Vercel Analytics for performance monitoring
- Set up error tracking if needed
- Monitor build times and deployment frequency

## Support

For additional help:
- Check Vercel documentation: [vercel.com/docs](https://vercel.com/docs)
- Review build logs in Vercel dashboard
- Verify package.json syntax with online validators
- Test locally before deploying

## Next Steps

1. **Test Deployment**: Deploy to staging environment first
2. **Monitor Performance**: Check load times and user experience
3. **Set Up CI/CD**: Automate deployment on code changes
4. **Add Monitoring**: Implement error tracking and analytics
5. **Optimize Further**: Consider additional performance optimizations based on usage patterns