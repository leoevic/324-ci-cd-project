# Load test

Use the JMeter test plan as a starting point. Do not exceed 10 simultaneous users.
Store exported results and screenshots in `loadtest/results`.

## Video Game load test

`video-game-load-test.jmx` tests the backend directly on `http://localhost:8000`:

- Thread group 1: 10 users, 1 s ramp-up, 2 loops → `GET /health`, `/meta`, `/summary`, `/items` and `POST /items`
- Thread group 2 (runs afterwards): deletes the created items (IDs 4–23) again

Run it headless with `just loadtest` (needs `jmeter` on the `PATH`). The backend is restarted first, so the IDs of the created items start at 4. The HTML report is written to `loadtest/results/report/index.html`.


## JMeter Load Test
To run the load test, you must have Docker Desktop installed and running. Additionally, you need to have JMeter installed [download link](https://jmeter.apache.org/download_jmeter.cgi). Download the ZIP file:<i>apache-jmeter-5.6.3.zip</i>

Now, go to the VSCode terminal and open folder <span style="color:#b494ea">321-ci-cd-project</span> and type:
```bash
docker compose up --build -d
```
Once Docker has started, open <b>JMeter</b>. Go to 'File -> Open' and select this path.
```
324-ci-cd-project/loadtest/video-game-load-test.jmx
```
Finally, click the green arrow in JMeter and wait...

To reset the 'Summary Report', go to 'Run' and then select 'Clear All'.
