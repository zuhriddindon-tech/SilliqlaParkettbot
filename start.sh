#!/usr/bin/env bash
# start.sh — universal starter. Save as start.sh and make executable: chmod +x start.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}\")" && pwd)"
cd "$ROOT_DIR"

# Load .env if exists (safe parsing; will not export empty lines or comments)
if [ -f .env ]; then
  echo "Loading .env"
  set -o allexport
  # shellcheck disable=SC2016
  # Avoid exporting lines with spaces or commands
  grep -v '^\\s*#' .env | sed '/^\\s*$/d' | while IFS='=' read -r key value; do
    export "$key"="$value"
  done
  set +o allexport
fi

if [ -f package.json ]; then
  echo "Detected Node.js project."
  if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm not found. Install Node.js and npm." >&2
    exit 1
  fi
  echo "Installing dependencies (production)..."
  npm ci --only=production
  echo "Starting Node.js bot..."
  if npm run --silent start >/dev/null 2>&1; then
    npm start
  else
    if [ -f index.js ]; then
      node index.js
    elif [ -f bot.js ]; then
      node bot.js
    else
      echo "No start script or index.js/bot.js found. Update package.json scripts.start" >&2
      exit 1
    fi
  fi

elif [ -f requirements.txt ]; then
  echo "Detected Python project."
  if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 not found. Install Python 3.8+." >&2
    exit 1
  fi
  python3 -m venv venv
  # shellcheck disable=SC1091
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
  echo "Starting Python bot..."
  if [ -f bot.py ]; then
    python bot.py
  elif [ -f main.py ]; then
    python main.py
  else
    echo "No bot.py or main.py found. Check README for start command." >&2
    exit 1
  fi

else
  echo "No package.json or requirements.txt detected. Cannot determine project type." >&2
  exit 1
fi
