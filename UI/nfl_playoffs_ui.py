# nfl_playoffs_ui.py
import streamlit as st

from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
from get_team_for_specificed_fan import get_team_for_specified_fan_ui
from validate_user_ui import validate_user_ui

st.title("NFL Playoffs App")
st.write("Welcome to the NFL Playoffs App")

with st.sidebar:
    st.title("NFL Playoff Functionalities")

    api_endpoint = st.selectbox(
        "Select a functionality:",
        [
            "Get Teams by Conference and Division",
            "Get Teams in Same Conference and Division as Specified Team",
            "Get Teams for a Specified Fan",
            "Validate User"
        ]
    )

if api_endpoint == "Get Teams by Conference and Division":
    get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":
    get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Get Teams for a Specified Fan":
    get_team_for_specified_fan_ui()

elif api_endpoint == "Validate User":
    validate_user_ui()