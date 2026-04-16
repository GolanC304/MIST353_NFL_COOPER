#!/bin/bash
# Find the environment regardless of version number
source /home/site/wwwroot/antenv/bin/activate

export PYTHONPATH=$PYTHONPATH:/home/site/wwwroot

# Start the apps
python3 -m gunicorn -w 2 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app --daemon
python3 -m streamlit run UI/nfl_playoffs_ui.py --server.port 8080 --server.address 0.0.0.0