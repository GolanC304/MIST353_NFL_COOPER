#!/bin/bash

# 1. Clear ports to avoid "Address already in use" errors
# Squelch errors and kill silently
lsof -ti:8000,8080 | xargs kill -9 2>/dev/null || true

# 2. Start FastAPI (the Back-end) on Port 8000
# We use --daemon to keep it running in the background
gunicorn -w 2 -k uvicorn.workers.UvicornWorker --chdir API --bind=0.0.0.0:8000 nfl_playoffs_api:app --daemon

# 3. Start Streamlit (the Front-end) on Port 8080
# Streamlit remains in the foreground to keep the container alive
python -m streamlit run UI/nfl_playoffs_ui.py --server.port 8080 --server.address 0.0.0.0
