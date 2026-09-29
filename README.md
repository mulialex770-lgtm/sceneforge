# SceneForge v3 — Real AI 5-Shot Video App

Turn a short idea into a **30-second cinematic MP4** made of five real AI-generated 6-second shots (Runway), automatically planned with a knowledge engine and stitched on the server.

## What it does

1. You enter a video idea (and optionally pick knowledge domains).
2. SceneForge builds five scene prompts (Establishing → Subject → Action → Detail → Payoff).
3. The server calls Runway for each shot.
4. Clips are downloaded and stitched into one MP4 with ffmpeg.
5. You watch and download the result in the browser.

**API keys never leave the server.**

## Improvements in v3

| Area | Change |
|------|--------|
| **Source completeness** | Full `server/` + `public/` included (previous zip was docs-only) |
| **UI** | Modern dark cinematic UI, mobile-friendly, domain chips, scene preview, progress steps |
| **Knowledge engine** | 14 domains with keyword detection + manual override |
| **API** | `/api/health`, `/api/domains`, `/api/plan`, `/api/generate` |
| **Resilience** | ffmpeg stream-copy + re-encode fallback, clearer errors |
| **Deploy** | Binds `0.0.0.0`, reads `PORT`, Docker + Render ready |

## Stack

- **Node.js 18+** · Express 5 · `@runwayml/sdk` · `ffmpeg-static` · dotenv · cors
- Frontend: single-page `public/index.html` (no build step)

## Quick start

```bash
# 1. Install
npm install

# 2. Configure
cp .env.example .env
# Edit .env → set RUNWAYML_API_SECRET=key_...

# 3. Run
npm start
# → http://localhost:8787
```

Or use the helpers:

- **Windows:** `setup.bat` then `start.bat`
- **macOS / Linux / Termux:** `./setup.sh` then `./start.sh`

### Environment

```env
RUNWAYML_API_SECRET=key_your_real_key_here
RUNWAY_VIDEO_MODEL=wan3          # or gen4.5, veo3.1, seedance2, …
RUNWAY_RATIO=1280:720
SHOT_DURATION=6
PORT=8787
```

## Knowledge domains

Auto-detected from your idea (or pick chips in the UI):

Superheroes · Aliens/sci-fi · Humans · Money/business · Vehicles · Environment · Climate · Mythology · Science · Space · History · Geography · Animals · Cinematic

See `KNOWLEDGE.md` and `server/knowledge.js`.

## Cost note

Each **Generate** runs **five** Runway text-to-video jobs (one per shot). Credits depend on model and resolution — check [Runway Dev pricing](https://docs.dev.runwayml.com/).

## Deploy (public HTTPS for phones)

1. Push this folder to GitHub.
2. Render: **New → Web Service**, use `render.yaml` or:
   - Build: `npm install --omit=dev`
   - Start: `npm start`
3. Set secret `RUNWAYML_API_SECRET`.
4. Open the `onrender.com` HTTPS URL on any phone — no localhost needed.

Docker:

```bash
docker build -t sceneforge .
docker run -p 8787:8787 -e RUNWAYML_API_SECRET=key_... sceneforge
```

## Project layout

```
├── public/index.html      # UI
├── server/
│   ├── index.js           # Express API + static
│   ├── knowledge.js       # Domain detection + 5-shot planner
│   ├── runway.js          # Runway SDK generate + download
│   └── stitch.js          # ffmpeg concat
├── output/                # Generated MP4s (gitignored)
├── package.json
├── Dockerfile
├── render.yaml
└── .env.example
```

## License

Private / your use. Runway API terms apply to generations.
