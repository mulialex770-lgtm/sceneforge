@echo off
setlocal
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo Node.js is required. Install Node.js 18+ and run this script again.
  pause
  exit /b 1
)

if not exist .env (
  copy /Y .env.example .env >nul
  echo Created .env from .env.example.
  set /p "KEY=Paste your Runway API key: "
  if not "%KEY%"=="" powershell -NoProfile -Command "$p=Get-Content '.env' -Raw; $p=$p.Replace('key_your_runway_api_key_here',$env:KEY); Set-Content -Path '.env' -Value $p -NoNewline" 
  echo API key saved to .env (server-side only).
)

call npm install
if errorlevel 1 exit /b 1

echo.
echo SceneForge is ready. Start it with: npm start
echo Then open: http://localhost:8787
pause
