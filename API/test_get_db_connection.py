from get_db_connection import get_db_connection

def test_get_db_connection():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT 1")
    result = cursor.fetchone()
    conn.close()
    print("✅ Connection successful, result:", result[0])

if __name__ == "__main__":
    test_get_db_connection()