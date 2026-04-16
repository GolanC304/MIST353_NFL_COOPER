#!/bin/bash

# Move to the app directory
cd /home/site/wwwroot

# Install missing modules if they aren't in the virtual env
pip install gunicorn uvicorn streamlit pyodbc fastapi

# Start the API in the background
gunicorn -w 2 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app &

# Start Streamlit
streamlit run UI/nfl_playoffs_ui.py --server.port 8080 --server.address 0.0.0.0