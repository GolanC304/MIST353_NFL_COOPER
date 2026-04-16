#!/bin/bash

# Use the absolute path for the site root
export PYTHONPATH=$PYTHONPATH:/home/site/wwwroot

# Start the FastAPI backend on port 8000
# -D runs gunicorn in 'daemon' mode (true background)
gunicorn -w 2 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app --daemon

# Start the Streamlit frontend
# If $PORT is empty, it will default to 8080
streamlit run UI/nfl_playoffs_ui.py --server.port ${PORT:-8080} --server.address 0.0.0.0