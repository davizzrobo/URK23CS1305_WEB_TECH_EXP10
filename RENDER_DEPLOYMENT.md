# 🚀 Render Deployment Guide for BudgetBuddy

This guide will walk you through deploying your BudgetBuddy application to Render.

## 📋 Prerequisites

1. **Render Account**: Sign up at [https://render.com](https://render.com)
2. **MongoDB Atlas**: Create a free cluster at [https://www.mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
3. **GitHub Repository**: Your code should be pushed to GitHub
4. **Google OAuth Credentials**: Get from [Google Cloud Console](https://console.cloud.google.com)

## 🔧 Step 1: Prepare MongoDB Atlas

1. Create a free MongoDB Atlas cluster
2. Create a database user with password
3. Whitelist all IP addresses (0.0.0.0/0) for Render access
4. Copy your connection string (looks like: `mongodb+srv://username:password@cluster.mongodb.net/budgetbuddy`)

## 🌐 Step 2: Deploy Backend to Render

### Option A: Using render.yaml (Blueprint - Recommended)

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repository
4. Render will automatically detect `render.yaml`
5. Click **"Apply"**

### Option B: Manual Setup

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Name**: `budget-buddy-backend`
   - **Runtime**: Node
   - **Build Command**: `npm install --prefix server`
   - **Start Command**: `npm start --prefix server`
   - **Plan**: Free

## 🔐 Step 3: Set Environment Variables

In your Render service dashboard, add these environment variables:

```bash
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/budgetbuddy
JWT_SECRET=your-super-secret-jwt-key-change-this-to-random-string
GOOGLE_CLIENT_ID=your-google-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your-google-client-secret
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-gmail-app-password
CLIENT_URL=https://budgetbuddy-web.github.io
```

### 🔑 Important Notes:

- **JWT_SECRET**: Generate a random string (use: `openssl rand -base64 32`)
- **EMAIL_PASS**: Use Gmail App Password (not your regular password)
  - Enable 2FA on Gmail
  - Go to Google Account → Security → App Passwords
  - Generate new app password
- **MONGODB_URI**: Replace username, password, and cluster details

## 📱 Step 4: Update Frontend Configuration

1. Get your Render backend URL (e.g., `https://budget-buddy-backend.onrender.com`)

2. Update `client/package.json` build script:

```json
"build": "cross-env REACT_APP_API_URL=https://budget-buddy-backend.onrender.com/api react-scripts build"
```

3. Update Google OAuth redirect URIs:
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Select your project → APIs & Services → Credentials
   - Add authorized origins:
     - `https://budgetbuddy-web.github.io`
     - `http://localhost:3000` (for local dev)
   - Add authorized redirect URIs:
     - `https://budgetbuddy-web.github.io`
     - `http://localhost:3000`

## 🎨 Step 5: Deploy Frontend to GitHub Pages

1. Run the deployment script:

```bash
chmod +x deploy.sh
./deploy.sh
```

2. Select option `2` (Frontend) or `3` (Both)

3. The script will:
   - Build the React app with production API URL
   - Copy files to root directory
   - Commit and push to GitHub
   - GitHub Pages will automatically deploy

## ✅ Step 6: Verify Deployment

1. **Backend Health Check**:
   ```bash
   curl https://your-render-url.onrender.com/api/health
   ```
   Should return: `{"status":"OK","message":"BudgetBuddy API is running"}`

2. **Frontend**: Visit `https://budgetbuddy-web.github.io`

3. **Test Registration/Login**: Try creating an account

## 🐛 Troubleshooting

### Backend Issues

**Problem**: Service won't start
- Check Render logs in dashboard
- Verify all environment variables are set
- Ensure MongoDB URI is correct and IP is whitelisted

**Problem**: CORS errors
- Verify `CLIENT_URL` in environment variables
- Check `server/server.js` CORS configuration includes your frontend URL

**Problem**: Database connection fails
- Check MongoDB Atlas network access (whitelist 0.0.0.0/0)
- Verify database user has correct permissions
- Test connection string format

### Frontend Issues

**Problem**: API calls fail
- Check `REACT_APP_API_URL` in build command
- Verify backend is deployed and health check passes
- Check browser console for CORS errors

**Problem**: Google OAuth doesn't work
- Verify redirect URIs in Google Cloud Console
- Check Google Client ID in environment variables
- Ensure authorized origins include your frontend URL

## 🔄 Continuous Deployment

Render automatically deploys when you push to GitHub:

```bash
git add .
git commit -m "Update backend"
git push origin main
```

For frontend updates:

```bash
./deploy.sh
# Select option 2 (Frontend)
```

## 💰 Free Tier Limitations

Render Free Tier:
- Services spin down after 15 minutes of inactivity
- First request after inactivity takes ~30 seconds (cold start)
- 750 hours/month free (enough for 1 service running 24/7)

MongoDB Atlas Free Tier:
- 512 MB storage
- Shared RAM
- No backups

## 📊 Monitoring

1. **Render Dashboard**: View logs, metrics, and deployment history
2. **MongoDB Atlas**: Monitor database performance and storage
3. **GitHub Actions**: Consider adding CI/CD for automated testing

## 🚀 Going to Production

When ready for production:

1. Upgrade Render plan for:
   - No cold starts
   - Better performance
   - Custom domains

2. Upgrade MongoDB Atlas for:
   - More storage
   - Automated backups
   - Better performance

3. Add:
   - Custom domain
   - SSL certificate (Render provides free)
   - Monitoring and alerts
   - Database backups

## 📚 Additional Resources

- [Render Documentation](https://render.com/docs)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
- [React Deployment Guide](https://create-react-app.dev/docs/deployment/)

## 🆘 Need Help?

Check these files for more information:
- `EXPLAIN.md` - Project architecture and features
- `REQUIREMENTS.md` - Project requirements
- `README.md` - General project information
- `PROBLEM_OVERCOME.md` - Common issues and solutions

---

**Happy Deploying! 🎉**
