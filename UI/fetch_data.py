# fetch_data.py
import streamlit as st
import requests
import pandas as pd

# The URL you defined
BASE_URL = "https://mist353-api-cooper-hkgrehdvebhqaye2.mexicocentral-01.azurewebsites.net"

# Added 'def' and fixed the variable name inside the f-string
def fetch_data(endpoint: str, input_params: dict, method: str = "GET"):
    if method == "GET":
        # Changed FASTAPI_URL to BASE_URL to match your definition above
        response = requests.get(f"{BASE_URL}/{endpoint}", params=input_params)

        if response.status_code == 200:
            payload = response.json()
            # Good use of .get() to avoid KeyErrors
            rows = payload.get("data", [])
            df = pd.DataFrame(rows)
            return df
        else:
            st.error(f"Error fetching data: {response.status_code}")
            return None