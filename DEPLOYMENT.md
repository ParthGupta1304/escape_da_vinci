# Deploying AutoML Intelligence System

## Architecture

This application consists of two parts:

1. **Next.js Frontend + API** (Deploy to Vercel)
2. **Python FastAPI Backend** (Deploy to Render/Railway/Cloud Run)

---

## Part 1: Deploy Next.js to Vercel (5 minutes)

### Prerequisites

- Vercel account (free)
- GitHub repository

### Steps

1. **Push your code to GitHub** (if not already done)

   ```bash
   git add .
   git commit -m "Ready for deployment"
   git push origin main
   ```

2. **Deploy to Vercel**

   - Go to https://vercel.com
   - Click "New Project"
   - Import your GitHub repository
   - Vercel auto-detects Next.js
   - Click "Deploy"

3. **Configure Environment Variables** (Do this after Python backend is deployed)
   - Go to Project Settings → Environment Variables
   - Add:
     ```
     PYTHON_BACKEND_URL=https://your-python-backend-url.com
     ```
   - Redeploy

**Your Next.js app is now live!** 🎉

---

## Part 2: Deploy Python Backend

### Recommended: Render.com (Free Tier)

#### Steps

1. **Update Python Backend for Production**

   Already done! The `python_backend/main.py` is production-ready with CORS configured.

2. **Create Render Account**

   - Go to https://render.com
   - Sign up with GitHub

3. **Create New Web Service**

   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     ```
     Name: automl-python-backend
     Region: Oregon (US West)
     Branch: main
     Root Directory: python_backend
     Runtime: Python 3
     Build Command: pip install -r requirements.txt
     Start Command: uvicorn main:app --host 0.0.0.0 --port $PORT
     ```

4. **Add Environment Variables**

   - Go to Environment tab
   - Add:
     ```
     PYTHON_VERSION=3.11.0
     ```

5. **Deploy**

   - Click "Create Web Service"
   - Wait 3-5 minutes for deployment

6. **Get Backend URL**

   - Copy the URL (e.g., `https://automl-python-backend.onrender.com`)

7. **Update Vercel**
   - Go to Vercel dashboard → Your project → Settings → Environment Variables
   - Update `PYTHON_BACKEND_URL` with your Render URL
   - Redeploy Vercel app

**Done!** 🚀

---

## Alternative: Railway.app (Fastest)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy Python backend
cd python_backend
railway init
railway up

# Get URL
railway domain

# Add domain to Vercel environment variables
```

---

## Alternative: Docker Deployment

If you prefer Docker:

```bash
# Build Docker image
cd python_backend
docker build -t automl-python .

# Test locally
docker run -p 8000:8000 automl-python

# Deploy to any cloud provider that supports Docker
# - AWS ECS
# - Google Cloud Run
# - Azure Container Instances
# - DigitalOcean
# - Fly.io
```

---

## Verification

### Test Next.js Frontend

```bash
curl https://your-vercel-app.vercel.app/
```

### Test Python Backend

```bash
# Health check
curl https://your-python-backend.onrender.com/

# Test API
curl -X POST https://your-python-backend.onrender.com/api/python/column-types \
  -H "Content-Type: application/json" \
  -d '{"data": [{"age": 25, "name": "John"}]}'
```

### Test Integration

1. Open your Vercel URL
2. Upload a CSV file
3. Check browser console - should see "Using Python backend for column classification"

---

## Cost Estimates

### Free Tier (Both Deployed Free)

- **Vercel**: Unlimited for personal projects
- **Render**: 750 hours/month free (enough for 1 service 24/7)
- **Total**: $0/month

### Production Tier

- **Vercel Pro**: $20/month (better performance, analytics)
- **Render Starter**: $7/month (always-on, faster cold starts)
- **Total**: ~$27/month

### Enterprise Tier

- **Vercel Enterprise**: Custom pricing
- **Google Cloud Run**: Pay per request (~$0.40 per million requests)
- **AWS/Azure**: $50-200/month depending on usage

---

## Post-Deployment Checklist

- [ ] Both services deployed and accessible
- [ ] Environment variables configured
- [ ] Python backend URL added to Vercel
- [ ] Vercel app redeployed after env var update
- [ ] Upload test: CSV file processes successfully
- [ ] Python integration working (check "Using Python backend" in console)
- [ ] All 6 analytical tiers working
- [ ] Model export functioning
- [ ] Custom domain configured (optional)

---

## Troubleshooting

### Python Backend Not Responding

- Check Render logs for errors
- Verify all dependencies in `requirements.txt`
- Ensure `PORT` environment variable is set correctly

### CORS Errors

- Verify Python backend CORS settings allow your Vercel domain
- Update `allow_origins` in `main.py` if needed

### TypeScript Fallback Always Used

- Check `PYTHON_BACKEND_URL` in Vercel
- Test Python backend URL directly
- Check browser console for connection errors

### Slow Cold Starts (Render Free Tier)

- Free tier spins down after 15 minutes of inactivity
- First request after idle takes 30-60 seconds
- Solution: Upgrade to paid tier ($7/month) for always-on

---

## Monitoring

### Vercel Analytics

- Built-in web analytics
- Real User Monitoring (RUM)
- Core Web Vitals tracking

### Render Monitoring

- Resource usage graphs
- Request metrics
- Error logs
- Auto-restart on crashes

---

## Scaling

### When to Scale

**Vercel**: Auto-scales automatically, no action needed

**Python Backend**:

- Free tier: Good for 100-500 requests/day
- Paid tier: Good for 10,000+ requests/day
- Need more? Consider:
  - Multiple instances on Render
  - Google Cloud Run (serverless, auto-scales)
  - AWS Lambda with API Gateway

---

## Support

- **Vercel**: https://vercel.com/support
- **Render**: https://render.com/docs
- **Railway**: https://docs.railway.app/
