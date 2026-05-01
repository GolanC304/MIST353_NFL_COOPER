import streamlit as st
from fetch_data import fetch_data

def get_all_changes_made_by_specified_admin_ui():
    st.header("All Changes Made By Me")

    # Check admin is logged in
    if "app_user_id" not in st.session_state or not st.session_state.app_user_id:
        st.warning("You must be logged in as an NFL Admin to view changes.")
        return

    nfl_admin_id = st.session_state.app_user_id
    admin_name = st.session_state.get("app_user_fullname", "Admin")
    st.info(f"Showing changes made by: **{admin_name}** (Admin ID: {nfl_admin_id})")

    df = fetch_data("get_all_changes_made_by_specified_admin/", {"nfl_admin_id": nfl_admin_id})

    if df is not None and not df.empty:
        st.subheader(f"{len(df)} change(s) found:")

        # Rename columns for display
        df = df.rename(columns={
            "ChangeDateTime": "Date & Time",
            "ChangeType": "Type",
            "ChangeDescription": "Description",
            "GameRound": "Round",
            "GameDate": "Game Date",
            "GameStartTime": "Start Time",
            "HomeTeam": "Home Team",
            "AwayTeam": "Away Team",
            "StadiumName": "Stadium"
        })

        st.dataframe(df, use_container_width=True, hide_index=True)
    elif df is not None and df.empty:
        st.info("No changes found for this admin. Schedule a game first!")
    # else: fetch_data already showed an st.error