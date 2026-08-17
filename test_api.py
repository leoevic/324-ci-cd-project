import requests
import pytest
import json

BASE_URL = "http://localhost:8000/"


def test_health():

    response = requests.get(
        url = f"{BASE_URL}health"
    )

    assert response.status_code == 200


def test_meta():
    response = requests.get(
        url=f"{BASE_URL}meta"
    )

    assert response.status_code == 200


def test_summary():
    response = requests.get(
            url=f"{BASE_URL}summary"
    )
    
    assert response.status_code == 200

def test_items():
    response = requests.get(
            url=f"{BASE_URL}items"
    )
    
    assert response.status_code == 200


def test_item():
    item_id = 1

    response = requests.get(
            url=f"{BASE_URL}items/{item_id}"
    )
    
    assert response.status_code == 200


def test_create_item():
    item_json= {
        "title": "Test",
        "genre": "Test",
        "platform": "PC",
        "release_year": 2023,
        "status": "Finished"
    }

    response = requests.post(
        url=f"items",
        json=item_json
    )

    assert response.status_code == 200