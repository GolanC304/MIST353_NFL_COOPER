from get_db_connection import get_db_connection

def get_teams_by_conference_division(conference=None, division=None):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        EXEC usp_GetTeamsByDivision @Division = ?
    """, division)
    rows = cursor.fetchall()
    conn.close()
    return rows


if __name__ == "__main__":
    teams = get_teams_by_conference_division('North')
    for t in teams:
        print(t)