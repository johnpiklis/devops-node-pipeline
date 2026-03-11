import requests

BASE_URL = "http://localhost:3000"

def test_health():
    r = requests.get(f"{BASE_URL}/health")
    print("Health:", r.reason, r.text)

def test_status():
    r = requests.get(f"{BASE_URL}/status")
    print("Status:", r.reason, r.text)

def test_process():
    r = requests.post(f"{BASE_URL}/process", json={"task": "devops"})
    print("Process:", r.reason, r.text)

if __name__ == "__main__":
    test_health()
    test_status()
    test_process()