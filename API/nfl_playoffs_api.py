# nfl_playoffs_api.py
from fastapi import FastAPI, HTTPException
from API.get_db_connection import get_db_connection
app = FastAPI(title="NFL Playoffs API")

from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="NFL Playoffs API")

# Add this block
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # In production, you can replace "*" with your Azure URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def root():
    return {"message": "Hello, World!"}


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


@app.get("/teams/by_conference/")
def get_teams_by_conference(conference: str):
    """
    Returns all teams in the specified conference along with their divisions.
    """
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "EXEC GetTeamsByConference @conference=?",
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


@app.get("/fans/teams/")
def get_teams_for_fan(fan_id: int = None, email: str = None):
    """
    Returns all teams associated with a fan.
    Look up by fan_id, email, or both.
    """
    if fan_id is None and email is None:
        raise HTTPException(
            status_code=400,
            detail="Provide at least one of: fan_id or email"
        )

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "EXEC procGetTeamsForSpecifiedFan @NFLFanID=?, @Email=?",
        fan_id, email
    )
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="No fan or teams found for the given input.")

    return [
        {
            "Firstname": row.Firstname,
            "Lastname": row.Lastname,
            "Email": row.Email,
            "TeamName": row.TeamName,
            "TeamColors": row.TeamColors,
            "Conference": row.Conference,
            "Division": row.Division,
            "PrimaryTeam": bool(row.PrimaryTeam)
        }
        for row in rows
    ]


@app.get("/validate_user/")
def validate_user(email: str, password: str):
    """
    Validates a user by email and password hash check.
    Returns basic user info if valid.
    """
    import hashlib

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "SELECT AppUserID, Firstname, Lastname, Email, PasswordHash, UserRole FROM AppUser WHERE Email = ?",
        email
    )
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if row is None:
        raise HTTPException(status_code=404, detail="User not found.")

    # Hash the incoming password the same way it was stored
    password_hash = hashlib.sha256(password.encode()).digest()

    if bytes(row.PasswordHash) != password_hash:
        raise HTTPException(status_code=401, detail="Invalid password.")

    return {
        "AppUserID": row.AppUserID,
        "Firstname": row.Firstname,
        "Lastname": row.Lastname,
        "Email": row.Email,
        "UserRole": row.UserRole
    }
## test123