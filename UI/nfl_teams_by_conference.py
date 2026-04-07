import streamlit as st
import requests

st.title("NFL Teams by Conference")

conference = st.selectbox("Select a Conference", ["AFC", "NFC"])

if st.button("Get Teams"):
    response = requests.get(
        f"http://127.0.0.1:8000/teams/by_conference/?conference={conference}"
    )
    if response.status_code == 200:
        teams = response.json()
        st.write(f"Teams in {conference}:")
        for team in teams:
            st.write(f"- {team['TeamName']} ({team['Division']})")
    else:
        st.error("Failed to fetch data from API")