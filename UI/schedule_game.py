import streamlit as st
import requests
from fetch_data import fetch_data

FASTAPI_URL = "https://mist356-api-cooper-ekgmb7fucqfagbat.mexicocentral-01.azurewebsites.net"

def schedule_game_ui():

    st.header("Schedule a Game")

    home_team_id = st.number_input("Home Team ID", min_value=1, step=1)
    away_team_id = st.number_input("Away Team ID", min_value=1, step=1)

    game_round = st.selectbox("Game Round", ["Wild Card", "Divisional", "Conference Championship", "Super Bowl"])

    game_date = st.date_input("Game Date")

    game_start_time = st.time_input("Game Start Time")

    stadium_id = st.number_input("Stadium ID", min_value=1, step=1)

    nfl_admin_id = st.number_input("NFL Admin ID", min_value=1, step=1)

    if st.button("Schedule Game"):
        params = {
            "home_team_id": int(home_team_id),
            "away_team_id": int(away_team_id),
            "game_round": game_round,
            "game_date": str(game_date),
            "game_start_time": str(game_start_time),
            "stadium_id": int(stadium_id),
            "nfl_admin_id": int(nfl_admin_id)
        }

        response = requests.post(f"{FASTAPI_URL}/schedule_game/", params=params)

        if response.status_code == 200:
            st.success("Game scheduled successfully!")
        else:
            st.error(f"Error scheduling game: {response.status_code} - {response.text}")