import os
import pymssql 
from dotenv import load_dotenv

load_dotenv()

def get_db_connection():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_LOGIN")
    password = os.getenv("DB_PASSWORD")

    conn_str = (
        f"SERVER={server};"
        f"DATABASE={database};"
        f"UID={username};"
        f"PWD={password};"
        f"port=1433;"
        f"TrustServerCertificate=yes;"
        f"Connection Timeout=60;" # Increased to 60 for Canada Central latency
    )

    # Adding a timeout parameter directly to the connect function as a backup
    return pymssql.connect(conn_str)