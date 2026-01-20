# Python Backend Deployment

## Option 1: Render.com (Recommended - Free Tier Available)

### Prerequisites

- Render.com account
- GitHub repository

### Steps

1. **Create `render.yaml` in project root** (already created)

2. **Push to GitHub**

   ```bash
   git add .
   git commit -m "Add deployment configs"
   git push
   ```

3. **Deploy on Render**

   - Go to https://render.com
   - Click "New +" → "Blueprint"
   - Connect your GitHub repository
   - Render will auto-detect the `render.yaml` file
   - Click "Apply"

4. **Get Python Backend URL**

   - After deployment, copy the URL (e.g., `https://escape-da-vinci-python.onrender.com`)

5. **Update Vercel Environment Variable**
   - Go to Vercel dashboard → Your project → Settings → Environment Variables
   - Add: `PYTHON_BACKEND_URL` = `<your-render-url>`

---

## Option 2: Railway.app (Easy, Free $5 Credit)

### Steps

1. **Install Railway CLI**

   ```bash
   npm install -g @railway/cli
   ```

2. **Login and Deploy**

   ```bash
   cd python_backend
   railway login
   railway init
   railway up
   ```

3. **Get URL**

   ```bash
   railway domain
   ```

4. **Update Vercel**
   - Add `PYTHON_BACKEND_URL` to Vercel environment variables

---

## Option 3: Google Cloud Run (Scalable, Pay-per-use)

### Prerequisites

- Google Cloud account
- gcloud CLI installed

### Steps

1. **Build and Deploy**

   ```bash
   cd python_backend
   gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/automl-python
   gcloud run deploy automl-python \
     --image gcr.io/YOUR_PROJECT_ID/automl-python \
     --platform managed \
     --region us-central1 \
     --allow-unauthenticated
   ```

2. **Get URL and update Vercel**

---

## Option 4: Docker + Any Cloud Provider

Use the provided `Dockerfile` to deploy to:

- AWS ECS
- Azure Container Instances
- DigitalOcean App Platform
- Fly.io

```bash
docker build -t automl-python ./python_backend
docker run -p 8000:8000 automl-python
```

---

## Testing Deployment

After deploying Python backend:

```bash
# Test root endpoint
curl https://your-python-backend-url.com/

# Test column classification
curl -X POST https://your-python-backend-url.com/api/python/column-types \
  -H "Content-Type: application/json" \
  -d '{"data": [{"age": 25, "name": "John"}]}'
```

---

## Monitoring

### Render.com

- Built-in logs and metrics dashboard
- Auto-restart on crashes
- Health checks included

### Railway.app

- Real-time logs in dashboard
- Automatic HTTPS
- Custom domains supported

### Google Cloud Run

- Cloud Logging integration
- Auto-scaling
- Pay only for requests
