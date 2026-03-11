#!/bin/bash

# Build script for Vercel deployment
echo "🏗️  Building Umbuzo Frontend for Vercel..."

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build the application
echo "🔨 Building application..."
npm run build

# Verify build output
if [ -d "dist" ] && [ "$(ls -A dist)" ]; then
    echo "✅ Build successful! Output directory: dist/"
    ls -la dist/
else
    echo "❌ Build failed! No output in dist/ directory"
    exit 1
fi

echo "🎉 Frontend build complete!"