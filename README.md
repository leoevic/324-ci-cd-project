# Video Game Library

Starter application for Module 324 — DevOps Processes Project.

## Overview

This project contains a small frontend and backend application. The functional scope is intentionally limited. The goal is to improve the DevOps process: local setup, Git workflow, CI pipeline, reports, artifacts, load testing, deployment and logs.

The application supports basic CRUD operations and two theme-specific actions: Mark completed, Improve rating.

## Services

| Service | Description | URL |
|---|---|---|
| frontend | Static web interface | http://localhost:8080 |
| backend through proxy | API through Nginx proxy | http://localhost:8080/api/health |
| backend direct access | FastAPI backend | http://localhost:8000 |
| backend docs | OpenAPI documentation | http://localhost:8000/docs |

## Requirements

- Docker or Docker Desktop
- Docker Compose
- Git
- Just
- A code editor

## Start the project in dev mode

1. Download the dependencies via the instructions on their respective official websites.

2. Make sure the docker daemon is running by executing `systemctl start dockerd`, `rc-service docker start` or by running the Docker Desktop app.

3. In this project directory, run `just up` to build and start the containers.

4. If the docker command can't be found, make sure it's in the PATH variable

5. You can then verify that everything is running correctly by running `just open` to open the services website in your browser and using `docker compose ps`.

## Stop the project

```bash
just down
```

## Local configuration

Copy the example environment file if you need to customize ports or values:

```bash
cp .env.example .env
```

Do not commit real secrets.

## Other useful testing commands
Commands for testing, linting, running and more are defined in `justfile`
You can see an overview of existing commands by just running `just`:
```bash
❯ just
Available recipes:
    build         # Build all containers
    default
    down          # Stop all containers
    fresh         # Rebuild and restart all containers
    lint          # Lint backend with ruff
[crop]
```

## Main API endpoints

```text
GET    /health
GET    /items
POST   /items
PUT    /items/{item_id}
DELETE /items/{item_id}
POST   /items/{item_id}/actions/{action_id}
```

## Repository structure

```text
frontend/               # Frontend code
backend/                # Backend code
docs/                   # Documentation
evidence/               # Evidence for various tests
loadtest/               # Code for loadtesting
deployment/             # Deployment notes
Jenkinsfile             # CI/CD definition
justfile                # Definition of short-commands
docker-compose.yml      # Developement-env compose file
docker-compose.prod.yml # Production-env compose file
README.md               # This file :>
```


## Loadtest
[README.md](/loadtest/README.md)
