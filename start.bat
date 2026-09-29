@echo off
cd /d "%~dp0"
if not exist node_modules (
  echo Installing SceneForge dependencies...
  npm install
)
npm start
