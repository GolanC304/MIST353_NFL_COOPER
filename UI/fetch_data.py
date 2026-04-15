# fetch_data.py
import requests
import pandas as pd
 
BASE_URL = "http://127.0.0.1:8000"
 
 
from typing import Optional

def fetch_data(endpoint: str, params: dict = None) -> Optional[pd.DataFrame]:    
    try:
        url = f"{BASE_URL}/{endpoint.lstrip('/')}"
        response = requests.get(url, params=params, timeout=10)
        response.raise_for_status()
        data = response.json()
 
        if isinstance(data, list):
            return pd.DataFrame(data)
        elif isinstance(data, dict):
            return pd.DataFrame([data])
        else:
            return None
 
    except requests.exceptions.HTTPError as e:
        print(f"HTTP error for {endpoint}: {e.response.status_code} - {e.response.text}")
        return None
    except requests.exceptions.ConnectionError:
        print(f"Could not connect to API at {BASE_URL}. Is the server running?")
        return None
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None