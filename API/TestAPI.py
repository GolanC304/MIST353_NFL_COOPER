from fastapi import FastAPI
from get_db_connection import get_db_connection

app = FastAPI()

@app.get("/")
def root():
    return {"Hello, World!"}

@app.get("/test-db")
def test_db():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT 1")
    result = cursor.fetchone()
    conn.close()
    return {"result": result[0]}