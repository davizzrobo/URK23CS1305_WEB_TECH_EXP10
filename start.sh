#!/bin/bash

# BudgetBuddy Quick Start Script
# This script will help you set up and run the application locally

echo "🎯 BudgetBuddy - Local Development Setup"
echo "========================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v16 or higher."
    exit 1
fi

echo "✅ Node.js version: $(node -v)"
echo ""

# Check if this is for local development or Render setup
echo "Select setup mode:"
echo "1) Local Development (requires MongoDB)"
echo "2) Render Deployment Guide"
read -p "Enter choice (1-2): " mode

if [ "$mode" == "2" ]; then
    echo ""
    echo "🚀 Render Deployment Guide"
    echo "=========================="
    echo ""
    echo "📋 Prerequisites:"
    echo "   1. Create a Render account at https://render.com"
    echo "   2. Create a MongoDB Atlas database"
    echo "   3. Push your code to GitHub"
    echo ""
    echo "🔧 Steps to Deploy:"
    echo ""
    echo "   1. Create a New Web Service on Render"
    echo "      - Connect your GitHub repository"
    echo "      - Render will detect render.yaml automatically"
    echo ""
    echo "   2. Set Environment Variables in Render Dashboard:"
    echo "      - NODE_ENV=production"
    echo "      - PORT=5000 (or leave default)"
    echo "      - MONGODB_URI=<your-mongodb-atlas-uri>"
    echo "      - JWT_SECRET=<your-secret-key>"
    echo "      - GOOGLE_CLIENT_ID=<your-google-client-id>"
    echo "      - GOOGLE_CLIENT_SECRET=<your-google-client-secret>"
    echo "      - EMAIL_USER=<your-email>"
    echo "      - EMAIL_PASS=<your-email-app-password>"
    echo "      - CLIENT_URL=https://budgetbuddy-web.github.io"
    echo ""
    echo "   3. Deploy Frontend to GitHub Pages:"
    echo "      - Run: ./deploy.sh"
    echo "      - Select option 2 (Frontend)"
    echo ""
    echo "   4. Update client API URL:"
    echo "      - Edit client/package.json build script"
    echo "      - Set REACT_APP_API_URL to your Render backend URL"
    echo ""
    echo "📚 For more details, check EXPLAIN.md"
    echo ""
    exit 0
fi

# Local development setup
echo "📦 Setting up local development environment..."
echo ""

# Check if MongoDB is running
if ! pgrep -x "mongod" > /dev/null; then
    echo "⚠️  MongoDB is not running. Please start MongoDB first."
    echo "   Run: mongod"
    echo ""
    read -p "Press Enter when MongoDB is running..."
fi

echo "📦 Installing dependencies..."
echo ""

# Install server dependencies
echo "Installing server dependencies..."
cd server
npm install
if [ ! -f .env ]; then
    echo "PORT=5000" > .env
    echo "MONGODB_URI=mongodb://localhost:27017/budgetbuddy" >> .env
    echo "JWT_SECRET=your-secret-key-change-in-production" >> .env
    echo "NODE_ENV=development" >> .env
    echo "CLIENT_URL=http://localhost:3000" >> .env
    echo "✅ Created server/.env file with defaults"
    echo "⚠️  Please edit server/.env with your configurations"
fi
cd ..

# Install client dependencies
echo "Installing client dependencies..."
cd client
npm install
cd ..

echo ""
echo "✅ Installation complete!"
echo ""

# Ask if user wants to seed demo data
read -p "Do you want to seed demo data? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🌱 Seeding demo data..."
    cd server
    node utils/seed.js
    cd ..
fi

echo ""
echo "🚀 Starting the application..."
echo ""
echo "Backend will run on: http://localhost:5000"
echo "Frontend will run on: http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop the servers"
echo ""

# Start both servers using a process manager or in separate terminals
echo "To start the servers, run these commands in separate terminals:"
echo ""
echo "Terminal 1 (Backend):"
echo "  cd server && npm start"
echo ""
echo "Terminal 2 (Frontend):"
echo "  cd client && npm start"
echo ""
