# Deploy SceneForge on Render (phone-friendly HTTPS)

## 1. Put code on GitHub

1. Create a new empty repo on GitHub (no README needed).
2. From this folder:

```bash
git init
git add .
git commit -m "SceneForge v3"
git branch -M main
git remote add origin https://github.com/YOUR_USER/YOUR_REPO.git
git push -u origin main
```

## 2. Create the web service on Render

1. Go to https://dashboard.render.com and sign in (GitHub login is fine).
2. **New +** → **Web Service**.
3. Connect the GitHub repo you just pushed.
4. Settings:
   - **Name:** sceneforge
   - **Runtime:** Node
   - **Build Command:** `npm install --omit=dev`
   - **Start Command:** `npm start`
   - **Instance type:** Free (or Starter)
5. **Environment variables** (Environment tab):
   - `RUNWAYML_API_SECRET` = your Runway key (secret) — e.g. `key_...`
   - `RUNWAY_VIDEO_MODEL` = `wan3`
   - `NODE_VERSION` = `20`
6. Click **Create Web Service** / **Deploy**.

## 3. Open on your phone

When deploy finishes, Render shows a URL like:

`https://sceneforge-xxxx.onrender.com`

Open that **HTTPS** link on your phone. Do **not** use localhost.

## Notes

- Free tier spins down after idle sleep; first open can take ~30–60s to wake.
- One Generate = 5 Runway jobs; needs Runway credits.
- Never commit `.env` or put the API key in HTML.
