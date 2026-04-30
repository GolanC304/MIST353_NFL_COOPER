from get_db_connection import get_db_connection

def get_teams_by_conference_division(
        conference: str = None, 
        division: str = None
    ):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    cursor.callproc("procGetTeamsByConferenceDivision", (conference, division)) #2 or more params, and no params, use callproc
    #cursor.execute("exec procGetTeamsByConferenceDivision @Conference=%s, @Division=%s", (conference, division))
    rows = cursor.fetchall()
    conn.close()

    #Convert pymssql.Row objects to dicts
    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"],
            "TeamColors": row["TeamColors"]
        }
        for row in rows
    ]

    return {"data": results}