# 🚀 Quick Deploy to Render

## One-Time Setup (5 minutes)

### 1. Create MongoDB Atlas Database
```
1. Go to https://www.mongodb.com/cloud/atlas
2. Create free cluster
3. Create database user
4. Whitelist IP: 0.0.0.0/0
5. Copy connection string
```

### 2. Create Render Web Service
```
1. Go to https://dashboard.render.com
2. Click "New +" → "Blueprint"
3. Connect your GitHub repo
4. Click "Apply"
```

### 3. Set Environment Variables in Render
```env
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/budgetbuddy
JWT_SECRET=your-random-secret-key-here
GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your-client-secret
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-gmail-app-password
CLIENT_URL=https://budgetbuddy-web.github.io
```

### 4. Update Frontend API URL

Edit `client/package.json`:
```json
"build": "cross-env REACT_APP_API_URL=https://YOUR-RENDER-URL.onrender.com/api react-scripts build"
```

Replace `YOUR-RENDER-URL` with your actual Render service URL.

### 5. Deploy Frontend

```bash
chmod +x deploy.sh
./deploy.sh
# Select option 2 (Frontend)
```

## ✅ Verify Deployment

Backend health check:
```bash
curl https://your-render-url.onrender.com/api/health
```

Frontend: Visit `https://budgetbuddy-web.github.io`

## 🔄 Update and Redeploy

**Backend** (automatic on git push):
```bash
git add .
git commit -m "Update backend"
git push origin main
```

**Frontend**:
```bash
./deploy.sh
# Select option 2
```

## 📋 Commands Reference

| Command | Description |
|---------|-------------|
| `./start.sh` | Local development setup |
| `./deploy.sh` | Interactive deployment |
| `npm run install-all` | Install all dependencies |
| `npm run server` | Start backend only |
| `npm run client` | Start frontend only |

## 🐛 Common Issues

**Cold Start (30s delay)**: Free tier spins down after 15 min
- **Solution**: Upgrade to paid plan or accept delay

**CORS Error**: Frontend can't reach backend
- **Solution**: Check CLIENT_URL in Render env vars

**Database Connection Error**: Can't connect to MongoDB
- **Solution**: Whitelist 0.0.0.0/0 in MongoDB Atlas

## 📚 Full Documentation

See `RENDER_DEPLOYMENT.md` for complete guide with troubleshooting.

---

**Quick Deploy Time**: ~5 minutes ⚡
