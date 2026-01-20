#!/bin/bash

echo "🚀 AutoML Deployment Helper"
echo "================================"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: Run this script from the project root directory"
    exit 1
fi

# Function to check command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "📋 Pre-deployment Checklist:"
echo ""

# Check Node.js
if command_exists node; then
    echo "✅ Node.js $(node --version)"
else
    echo "❌ Node.js not found. Install from https://nodejs.org"
    exit 1
fi

# Check Python
if command_exists python3; then
    echo "✅ Python $(python3 --version)"
else
    echo "❌ Python not found. Install from https://python.org"
    exit 1
fi

# Check Git
if command_exists git; then
    echo "✅ Git $(git --version)"
else
    echo "❌ Git not found. Install from https://git-scm.com"
    exit 1
fi

echo ""
echo "🔧 Running pre-deployment checks..."
echo ""

# Install dependencies
echo "📦 Installing Node.js dependencies..."
npm install

# Build Next.js
echo "🏗️  Building Next.js application..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed. Fix errors before deploying."
    exit 1
fi

# Test Python backend
echo ""
echo "🐍 Testing Python backend..."
cd python_backend

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt -q

# Quick syntax check
echo "🔍 Checking Python syntax..."
python3 -m py_compile main.py

if [ $? -eq 0 ]; then
    echo "✅ Python backend code is valid"
else
    echo "❌ Python syntax errors found"
    exit 1
fi

cd ..

echo ""
echo "================================"
echo "✅ All checks passed!"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1️⃣  Deploy Frontend to Vercel:"
echo "   - Go to https://vercel.com"
echo "   - Click 'New Project'"
echo "   - Import your GitHub repository"
echo "   - Click 'Deploy'"
echo ""
echo "2️⃣  Deploy Python Backend to Render:"
echo "   - Go to https://render.com"
echo "   - Click 'New +' → 'Web Service'"
echo "   - Connect your GitHub repository"
echo "   - Root Directory: python_backend"
echo "   - Build Command: pip install -r requirements.txt"
echo "   - Start Command: uvicorn main:app --host 0.0.0.0 --port \$PORT"
echo "   - Click 'Create Web Service'"
echo ""
echo "3️⃣  Update Environment Variables:"
echo "   - Copy Python backend URL from Render"
echo "   - Add to Vercel: PYTHON_BACKEND_URL=<render-url>"
echo "   - Redeploy Vercel app"
echo ""
echo "📖 Full deployment guide: See DEPLOYMENT.md"
echo ""
