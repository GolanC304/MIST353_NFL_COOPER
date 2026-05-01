import streamlit as st
from fetch_data import fetch_data, post_data
import datetime

def schedule_game_ui():
    st.header("Schedule a Game")

    # Check admin is logged in
    if "app_user_id" not in st.session_state or not st.session_state.app_user_id:
        st.warning("You must be logged in as an NFL Admin to schedule a game.")
        return

    nfl_admin_id = st.session_state.app_user_id
    admin_name = st.session_state.get("app_user_fullname", "Admin")
    st.info(f"Scheduling as: **{admin_name}** (Admin ID: {nfl_admin_id})")

    # Fetch teams for dropdowns
    teams_df = fetch_data("get_all_teams/", {})
    stadiums_df = fetch_data("get_all_stadiums/", {})

    if teams_df is None or teams_df.empty:
        st.error("Could not load teams. Please try again later.")
        return

    if stadiums_df is None or stadiums_df.empty:
        st.error("Could not load stadiums. Please try again later.")
        return

    # Build display options
    team_options = {
        f"{row['TeamName']} ({row['TeamCityState']})": row["TeamID"]
        for _, row in teams_df.iterrows()
    }
    stadium_options = {
        f"{row['StadiumName']} ({row['StadiumCityState']})": row["StadiumID"]
        for _, row in stadiums_df.iterrows()
    }

    # Form inputs
    home_team_label = st.selectbox("Home Team", list(team_options.keys()), key="home_team")
    away_team_label = st.selectbox("Away Team", list(team_options.keys()), key="away_team")

    game_round = st.selectbox(
        "Game Round",
        ["Wild Card", "Divisional", "Conference", "Super Bowl"]
    )

    game_date = st.date_input(
        "Game Date",
        value=datetime.date.today(),
        min_value=datetime.date.today()
    )

    game_start_time = st.time_input(
        "Game Start Time",
        value=datetime.time(13, 0)
    )

    stadium_label = st.selectbox("Stadium", list(stadium_options.keys()), key="stadium")

    # Validate teams are different
    home_team_id = team_options[home_team_label]
    away_team_id = team_options[away_team_label]

    if st.button("Schedule Game"):
        if home_team_id == away_team_id:
            st.error("Home and Away teams must be different.")
            return

        result = post_data(
            "schedule_game/",
            {
                "home_team_id": home_team_id,
                "away_team_id": away_team_id,
                "game_round": game_round,
                "game_date": str(game_date),
                "game_start_time": str(game_start_time),
                "stadium_id": stadium_options[stadium_label],
                "nfl_admin_id": nfl_admin_id
            },
            method="POST"
        )

        if result:
            msg = result.get("status_message", "")
            if "successfully" in msg.lower():
                st.success(msg)
            else:
                st.error(msg)