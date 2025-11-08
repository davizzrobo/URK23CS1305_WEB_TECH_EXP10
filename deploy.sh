#!/bin/bash

# BudgetBuddy Deployment Script
# Deploys backend to Render and frontend to GitHub Pages

echo "🚀 Starting deployment process..."
echo ""

# Check deployment target
echo "Select deployment target:"
echo "1) Backend (Render)"
echo "2) Frontend (GitHub Pages)"
echo "3) Both"
read -p "Enter choice (1-3): " choice

deploy_backend() {
  echo ""
  echo "📦 Deploying Backend to Render..."
  echo "⚠️  Make sure you have:"
  echo "   - Created a Web Service on Render"
  echo "   - Connected your GitHub repository"
  echo "   - Set environment variables in Render dashboard"
  echo ""
  echo "🔄 Pushing changes to trigger Render deployment..."
  git add -A
  git commit -m "Deploy: Backend update - $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "✅ Backend deployment triggered!"
  echo "🌐 Check your Render dashboard for deployment status"
}

deploy_frontend() {
  echo ""
  echo "📦 Building Frontend for GitHub Pages..."
  
  # Navigate to client directory
  cd client
  
  # Build production version
  npm run build
  
  if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
  fi
  
  echo "✅ Build completed successfully!"
  
  # Copy build to root for GitHub Pages deployment
  echo "📋 Copying build files..."
  cd ..
  
  # Remove old build files from root (if any)
  rm -rf *.html *.js *.css static/ akari_vts/
  
  # Copy new build files
  cp -r client/build/* .
  
  echo "✅ Files copied!"
  
  # Git operations
  echo "📝 Committing changes..."
  git add -A
  git commit -m "Deploy: Frontend update - $(date '+%Y-%m-%d %H:%M:%S')"
  
  echo "⬆️ Pushing to GitHub..."
  git push origin main
  
  echo "🎉 Frontend deployment complete!"
  echo "🌐 Your site will be live at: https://budgetbuddy-web.github.io"
  echo "⏳ GitHub Pages may take a few minutes to update"
}

case $choice in
  1)
    deploy_backend
    ;;
  2)
    deploy_frontend
    ;;
  3)
    deploy_backend
    deploy_frontend
    ;;
  *)
    echo "❌ Invalid choice!"
    exit 1
    ;;
esac

echo ""
echo "🎉 Deployment process complete!"
