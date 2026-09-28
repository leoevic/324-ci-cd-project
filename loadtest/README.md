# Load test

Use the JMeter test plan as a starting point. Do not exceed 10 simultaneous users.
Store exported results and screenshots in `loadtest/results`.

## Video Game load test

`video-game-load-test.jmx` tests the backend directly on `http://localhost:8000`:

- Thread group 1: 10 users, 1 s ramp-up, 2 loops → `GET /health`, `/meta`, `/summary`, `/items` and `POST /items`
- Thread group 2 (runs afterwards): deletes the created items (IDs 4–23) again

Run it headless with `just loadtest` (needs `jmeter` on the `PATH`). The backend is restarted first, so the IDs of the created items start at 4. The HTML report is written to `loadtest/results/report/index.html`.
