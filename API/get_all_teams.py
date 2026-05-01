# get_all_teams.py
from get_db_connection import get_db_connection
import pymssql

def get_all_teams():
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT TeamID, TeamName FROM Team ORDER BY TeamName")
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamID": row["TeamID"],
            "TeamName": row["TeamName"]
        }
        for row in rows
    ]

    return {"data": results}