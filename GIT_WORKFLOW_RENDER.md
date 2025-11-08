# 🔄 Git Workflow for Render Deployment

## ✅ Initial Setup (One-Time)

### 1. Push Code to GitHub
```bash
cd /home/david/HTML/WEB_TECH_EXP/WEB_TECH_EXP_10

# Check status
git status

# If changes exist
git add .
git commit -m "Configure for Render deployment"
git push origin main
```

### 2. Connect Render to GitHub

**Dashboard Steps:**
1. Go to: https://dashboard.render.com
2. Click: **"New +"** → **"Blueprint"**
3. Click: **"Connect GitHub"** (authorize if first time)
4. Select: **Repository** - `davizzrobo/URK23CS1305_WEB_TECH_EXP10`
5. Render detects: `render.yaml` ✅
6. Click: **"Apply"**

### 3. Set Environment Variables

In Render Dashboard → Your Service → **"Environment"** tab:

```env
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/budgetbuddy
JWT_SECRET=generate-random-32-char-string
GOOGLE_CLIENT_ID=your-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your-secret
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-gmail-app-password
CLIENT_URL=https://budgetbuddy-web.github.io
```

**Generate JWT Secret:**
```bash
openssl rand -base64 32
```

### 4. Get Your Backend URL

After deployment completes:
- Render shows: `https://your-service-name.onrender.com`
- Copy this URL!

### 5. Update Frontend & Deploy

```bash
# Update client/package.json
nano client/package.json
# Change build script to:
# "build": "cross-env REACT_APP_API_URL=https://your-service-name.onrender.com/api react-scripts build"

# Deploy frontend
./deploy.sh
# Select: 2 (Frontend)
```

---

## 🔄 Daily Development Workflow

### Making Changes and Deploying

```bash
# 1. Make your code changes in VS Code/editor

# 2. Check what changed
git status

# 3. Stage all changes
git add .

# 4. Commit with descriptive message
git commit -m "Add feature X" 
# Or: "Fix bug Y"
# Or: "Update configuration"

# 5. Push to GitHub
git push origin main

# 6. Render automatically deploys! ✅
```

### Check Deployment Status

```bash
# Watch Render dashboard logs
# Or check health endpoint:
curl https://your-service-name.onrender.com/api/health
```

---

## 📋 Common Git Commands

### Check Status
```bash
git status                 # See what changed
git log --oneline -5       # See last 5 commits
git remote -v              # See remote repositories
```

### Undo Changes
```bash
git diff                   # See unstaged changes
git checkout -- file.txt   # Discard changes in file
git reset HEAD file.txt    # Unstage file
git reset --soft HEAD~1    # Undo last commit (keep changes)
```

### Branch Management (Optional)
```bash
git branch feature-x       # Create new branch
git checkout feature-x     # Switch to branch
git checkout -b feature-y  # Create and switch
git merge feature-x        # Merge branch to current
```

### Working with Render
```bash
# Typical workflow:
git checkout -b feature-new-dashboard
# ... make changes ...
git add .
git commit -m "Add new dashboard feature"
git checkout main
git merge feature-new-dashboard
git push origin main      # Triggers Render deployment
```

---

## 🚀 Quick Deploy Commands

### Backend Only (Automatic via Git)
```bash
git add .
git commit -m "Update backend"
git push origin main
# Render deploys automatically ✅
```

### Frontend Only
```bash
./deploy.sh
# Select: 2 (Frontend)
```

### Both Backend & Frontend
```bash
# Backend
git add .
git commit -m "Update app"
git push origin main

# Frontend
./deploy.sh
# Select: 2 (Frontend)
```

---

## ⚡ Fast Workflow (Most Common)

```bash
# Edit code → Save → Deploy

git add . && git commit -m "Update" && git push origin main
```

**That's it!** Render sees the push and auto-deploys.

---

## 🔍 Troubleshooting

### Problem: "Nothing to commit"
```bash
git status
# Make sure you saved your files!
```

### Problem: "Push rejected"
```bash
git pull origin main --rebase
git push origin main
```

### Problem: "Deployment failed on Render"
```bash
# Check Render dashboard logs
# Common issues:
# - Missing environment variables
# - Syntax error in code
# - Wrong build/start commands
```

### Problem: "Changes not deploying"
```bash
# Check if push succeeded
git log origin/main --oneline -1

# Check Render dashboard
# - Click "Events" tab
# - See deployment status
```

---

## 📊 Deployment Timeline

1. **Git push**: ~2 seconds
2. **Render detects**: ~5 seconds
3. **Build starts**: Immediately
4. **npm install**: ~30-60 seconds
5. **Service starts**: ~5-10 seconds
6. **Health check**: ~5 seconds

**Total**: ~1-2 minutes for full deployment

---

## 🎯 Best Practices

### Commit Messages
```bash
# Good ✅
git commit -m "Add user authentication endpoint"
git commit -m "Fix CORS issue for production"
git commit -m "Update MongoDB connection string"

# Bad ❌
git commit -m "changes"
git commit -m "fix"
git commit -m "update"
```

### Deployment Strategy
```bash
# For major changes: Test locally first
npm run server    # Test backend
npm run client    # Test frontend

# Then deploy
git add . && git commit -m "Feature X" && git push origin main
```

### Environment Variables
- **Never commit** `.env` files
- **Always set** in Render dashboard
- **Test locally** before deploying

---

## 📚 Resources

- **Git Basics**: https://git-scm.com/book/en/v2
- **Render Docs**: https://render.com/docs
- **Your Repo**: https://github.com/davizzrobo/URK23CS1305_WEB_TECH_EXP10

---

## ✅ Checklist for First Deployment

- [ ] Code pushed to GitHub
- [ ] Render connected to repository
- [ ] Environment variables set in Render
- [ ] Backend deployed successfully
- [ ] Health check passes: `curl https://your-url.onrender.com/api/health`
- [ ] Frontend updated with backend URL
- [ ] Frontend deployed to GitHub Pages
- [ ] Test login/registration works

---

**You're all set! Push code and let Render handle deployment automatically.** 🚀
