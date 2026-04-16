#!/bin/bash

# Move to the directory where this script lives
cd "$(dirname "$0")"

# Try to find the virtual env, if not found, install packages directly
if [ -d "antenv" ]; then
    source antenv/bin/activate
else
    python3 -m pip install -r requirements.txt
fi

export PYTHONPATH=$PYTHONPATH:$(pwd)

# Start API (Port 8000)
python3 -m gunicorn -w 2 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app --daemon

# Start UI (Port 8080)
python3 -m streamlit run UI/nfl_playoffs_ui.py --server.port 8080 --server.address 0.0.0.0