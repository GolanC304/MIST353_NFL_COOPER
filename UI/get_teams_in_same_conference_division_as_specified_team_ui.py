import streamlit as st
import requests

BASE_URL = "https://mist353-api-cooper-hkgrehdvebhqaye2.mexicocentral-01.azurewebsites.net"

def get_teams_in_same_conference_division_as_specified_team_ui():
    st.header("Teams in Same Division")

    team_name = st.text_input("Enter Team Name")

    if st.button("Find Teams"):
        response = requests.get(
            f"{BASE_URL}/teams/same_division",
            params={"team_name": team_name}
        )

        if response.status_code == 200:
            st.json(response.json())
        else:
            st.error("Error fetching data")