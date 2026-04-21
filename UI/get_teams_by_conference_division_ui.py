import streamlit as st
import requests

BASE_URL = "https://mist353-api-cooper-hkgrehdvebhqaye2.mexicocentral-01.azurewebsites.net"

def get_teams_by_conference_division_ui():
    st.header("Get Teams by Conference and Division")

    conference = st.selectbox("Conference", ["AFC", "NFC"])
    division = st.selectbox("Division", ["North", "South", "East", "West"])

    if st.button("Get Teams"):
        response = requests.get(
            f"{BASE_URL}/teams",
            params={"conference": conference, "division": division}
        )

        if response.status_code == 200:
            st.json(response.json())
        else:
            st.error("Error fetching data")