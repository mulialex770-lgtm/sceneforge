#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required. Install Node.js 18+ and run this script again."
  exit 1
fi

if [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from .env.example."
  printf "Paste your Runway API key (input will be hidden): "
  read -r -s KEY
  echo
  if [ -n "$KEY" ]; then
    python3 - "$KEY" <<'PY'
from pathlib import Path
import sys
key=sys.argv[1]
p=Path('.env')
s=p.read_text()
s=s.replace('key_your_runway_api_key_here', key)
p.write_text(s)
PY
    echo "Runway API key saved to .env (server-side only)."
  else
    echo "No key entered. Edit .env before starting generation."
  fi
fi

npm install

echo
echo "SceneForge is ready. Start it with: npm start"
echo "Then open: http://localhost:8787"
