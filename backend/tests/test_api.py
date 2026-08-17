from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health_endpoint_returns_ok():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_list_items_returns_seed_data():
    response = client.get("/items")

    assert response.status_code == 200
    assert len(response.json()) >= 1
    assert response.json()[0]["title"] == "Skyforge Arena"


def test_create_item_requires_mandatory_fields():
    response = client.post("/items", json={})

    assert response.status_code == 422


def test_create_update_and_delete_item():
    create_response = client.post("/items", json={"title": "New game", "genre": "Action RPG", "platform": "PC", "release_year": 2022, "status": "Playing", "rating": 8})

    assert create_response.status_code == 201
    item_id = create_response.json()["id"]

    update_payload = create_response.json()
    update_payload["title"] = "Updated item"
    update_payload.pop("id")

    update_response = client.put(f"/items/{item_id}", json=update_payload)
    assert update_response.status_code == 200
    assert update_response.json()["title"] == "Updated item"

    delete_response = client.delete(f"/items/{item_id}")
    assert delete_response.status_code == 204
