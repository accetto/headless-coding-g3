# Readme `bottle-test-app`

This is a very simple web application for testing the `Bottle` web framework.

## Prerequisites

First install `Bottle`:

```shell
pip install bottle
```

**Hint**: It is recommended to use an image that includes also **Chromium** or **Firefox** web browser. Then you can test your web application all inside the container.

## Starting test application

The test application can be started by:

```shell
### PWD = /srv/samples/bottle-test-app
python app.py
```

Then navigate the local web browser (inside the container) to the URL http://localhost:8080/hello/world.

## What next

You can start by checking the [Bottle documentation](https://bottlepy.org/).
