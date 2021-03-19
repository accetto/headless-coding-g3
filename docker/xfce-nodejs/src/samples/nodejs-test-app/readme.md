# Readme `nodejs-test-app`

First start the application from terminal:

```shell
node app.js

### output
Server running at http://0.0.0.0:3000/
```

Navigate to the application from a web browser inside the container:

```text
localhost:3000
```

The application can be stopped by entering `^c` (CTRL-C) in the terminal window.

For using the application from outside the container you have to:

- Ensure that the container exposes the TCP port `3000` (`Dockerfile` must contain `EXPOSE 3000`)

- Bind a free TCP port on the host to the container's port `3000` (use `-P` with `docker run`)
