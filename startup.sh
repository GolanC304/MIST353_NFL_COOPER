#!/bin/bash
# Force Azure to use its own virtual environment
source /home/site/wwwroot/antenv/bin/activate

export PYTHONPATH=$PYTHONPATH:/home/site/wwwroot

# Start API
gunicorn -w 2 -k uvicorn.workers.UvicornWorker --bind=0.0.0.0:8000 API.nfl_playoffs_api:app &

# Start UI
streamlit run UI/nfl_playoffs_ui.py --server.port 8080 --server.address 0.0.0.0