import requests

BASE_URL = "http://127.0.0.1:8000"

def test_root():
    response = requests.get(f"{BASE_URL}/")
    print("GET / →", response.status_code, response.json())

def test_db():
    response = requests.get(f"{BASE_URL}/test-db")
    print("GET /test-db →", response.status_code, response.json())

if __name__ == "__main__":
    print("Testing FastAPI endpoints...")
    test_root()
    test_db()