set dotenv-load := true

backend_port := env_var_or_default("BACKEND_PORT", "8000")
frontend_port := env_var_or_default("FRONTEND_PORT", "8080")
jenkins_port := env_var_or_default("JENKINS_PORT", "9000")

[linux]
open-cmd := "xdg-open"

[macos]
open-cmd := "open"

[windows]
open-cmd := "cmd /c start"

default:
    @just --list

# Run backend tests
test:
    docker compose cp backend/tests/test_api.py backend:/app
    docker compose exec backend python -m pytest test_api.py

# Lint backend with ruff
lint:
    ruff check backend

# Build all containers
build:
    docker compose build

# Start backend + frontend + jenkins
up:
    docker compose up -d --build

# Stop all containers
down:
    docker compose down

# Rebuild and restart all containers
fresh:
    docker compose down
    docker compose up -d --build

# Build prod containers
prod-build:
    docker compose -f docker-compose.prod.yml build

# Start prod containers (backend + frontend)
prod-up:
    docker compose -f docker-compose.prod.yml up -d --build

# Stop prod containers
prod-down:
    docker compose -f docker-compose.prod.yml down

# Tail prod backend logs
prod-logs:
    docker compose -f docker-compose.prod.yml logs -f backend

# Tail backend logs
logs:
    docker compose logs -f backend

# Open all service URLs in the browser
open:
    {{open-cmd}} http://127.0.0.1:{{backend_port}}
    {{open-cmd}} http://127.0.0.1:{{frontend_port}}
    {{open-cmd}} http://127.0.0.1:{{jenkins_port}}

# Open backend in the browser
open-backend:
    {{open-cmd}} http://127.0.0.1:{{backend_port}}

# Open frontend in the browser
open-frontend:
    {{open-cmd}} http://127.0.0.1:{{frontend_port}}

# Open jenkins in the browser
open-jenkins:
    {{open-cmd}} http://127.0.0.1:{{jenkins_port}}

# Show container URLs
urls:
    @echo "backend:  http://127.0.0.1:{{backend_port}}"
    @echo "frontend: http://127.0.0.1:{{frontend_port}}"
    @echo "jenkins:  http://127.0.0.1:{{jenkins_port}}"
