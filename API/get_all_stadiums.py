# get_all_stadiums.py
from get_db_connection import get_db_connection
import pymssql

def get_all_stadiums():
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT StadiumID, StadiumName, StadiumCityState, Capacity FROM Stadium ORDER BY StadiumName")
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "StadiumID": row["StadiumID"],
            "StadiumName": row["StadiumName"],
            "StadiumCityState": row["StadiumCityState"],
            "Capacity": row["Capacity"]
        }
        for row in rows
    ]

    return {"data": results}