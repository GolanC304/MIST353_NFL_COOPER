# nfl_playoffs_api.py
from fastapi import FastAPI
from get_db_connection import get_db_connection

app = FastAPI(title="NFL Playoffs API")


@app.get("/teams/")
def get_teams(conference: str = None, division: str = None):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "EXEC procGetTeamsByConferenceDivision @ConferenceName=?, @DivisionName=?",
        conference, division
    )
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return [
        {
            "TeamName": row.TeamName,
            "TeamColors": row.TeamColors,
            "Conference": row.Conference,
            "Division": row.Division
        }
        for row in rows
    ]


@app.get("/teams/same_division/")
def get_teams_same_division(team_name: str):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "EXEC procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName=?",
        team_name
    )
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    return [
        {
            "TeamName": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division
        }
        for row in rows
    ]


@app.get("/")
def root():
    return {"message": "Hello, World!"}

@app.get("/teams/by_conference/")
def get_teams_by_conference(conference: str):
    """
    Returns all teams in the specified conference along with their divisions.
    """
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "EXEC GetTeamsByConference @conference=?",  # Your new stored procedure
        conference
    )
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    return [
        {
            "TeamName": row.TeamName,
            "Division": row.Division
        }
        for row in rows
    ]