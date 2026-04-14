#!/bin/bash

# Ensure the root directory is in the Python Path
export PYTHONPATH=$PYTHONPATH:$(pwd)

# Start the FastAPI backend on port 8000
gunicorn -w 4 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app &

# Start the Streamlit frontend on the port Azure assigns
# Note: Streamlit usually uses 8501 locally, but Azure needs $PORT
streamlit run UI/nfl_ui.py --server.port $PORT --server.address 0.0.0.0