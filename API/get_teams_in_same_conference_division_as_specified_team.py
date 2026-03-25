from get_db_connection import get_db_connection

def get_teams_same_division(team_name):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        EXEC usp_GetTeamsInSameDivisionAsTeam @TeamName = ?
    """, team_name)
    rows = cursor.fetchall()
    conn.close()
    return rows


if __name__ == "__main__":
    teams = get_teams_same_division('New England Patriots')
    for t in teams:
        print(t)