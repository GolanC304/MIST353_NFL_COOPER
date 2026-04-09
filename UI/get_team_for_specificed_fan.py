# get_team_for_specificed_fan.py
import streamlit as st
from fetch_data import fetch_data


def get_team_for_specified_fan_ui():
    st.header("Get Teams for a Specified Fan")

    st.write("Look up a fan's teams by Fan ID, Email, or both.")

    col1, col2 = st.columns(2)

    with col1:
        fan_id_input = st.text_input("Fan ID (optional)")

    with col2:
        email_input = st.text_input("Email (optional)")

    if st.button("Find Fan's Teams"):
        # Validate at least one field provided
        if not fan_id_input.strip() and not email_input.strip():
            st.warning("Please enter at least a Fan ID or an Email.")
            return

        params = {}
        if fan_id_input.strip():
            if not fan_id_input.strip().isdigit():
                st.error("Fan ID must be a number.")
                return
            params["fan_id"] = int(fan_id_input.strip())
        if email_input.strip():
            params["email"] = email_input.strip()

        df = fetch_data("fans/teams/", params)

        if df is not None and not df.empty:
            fan_name = f"{df.iloc[0]['Firstname']} {df.iloc[0]['Lastname']}"
            st.subheader(f"Teams for {fan_name}:")

            # Highlight primary team
            display_df = df[["TeamName", "TeamColors", "Conference", "Division", "PrimaryTeam"]].copy()
            display_df["PrimaryTeam"] = display_df["PrimaryTeam"].apply(
                lambda x: "⭐ Yes" if x else "No"
            )
            display_df = display_df.rename(columns={"PrimaryTeam": "Primary Team"})

            st.dataframe(display_df, use_container_width=True, hide_index=True)
        else:
            st.info("No teams found for the given fan. Please check the inputs and try again.")