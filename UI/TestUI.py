import streamlit as st
import requests

BASE_URL = "http://127.0.0.1:8000"

st.title("NFL Teams UI")

st.header("Get Teams by Conference and Division")

conference = st.selectbox("Select Conference", ["AFC", "NFC"])
division = st.selectbox("Select Division", ["North", "South", "East", "West"])

if st.button("Get Teams"):
    response = requests.get(
        f"{BASE_URL}/teams",
        params={"conference": conference, "division": division}
    )
    if response.status_code == 200:
        st.json(response.json())
    else:
        st.error("Error fetching teams")



st.header("Get Teams in Same Division")

team_name = st.text_input("Enter Team Name")

if st.button("Find Teams"):
    response = requests.get(
        f"{BASE_URL}/teams/same_division",
        params={"team_name": team_name}
    )
    if response.status_code == 200:
        st.json(response.json())
    else:
        st.error("Error fetching teams")