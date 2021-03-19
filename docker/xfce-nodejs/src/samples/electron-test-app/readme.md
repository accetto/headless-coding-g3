# Readme `electron-test-app`

## Prerequisites

Please make sure that you are using an image that includes also **Chromium** web browser. Pick one of the images that includes the word `chromium` in its tag.

## Installing `electron`

First install `electron` locally:

```shell
cd /usr/src/electron-test-app/
npm install --save-dev electron
```

## Starting test application

The test application can be started by:

```shell
npm start
```

Note that all `electron` applications inside the container must be started with the option `--no-sandbox`.

The sample application `electron-test-app` is already prepared for that, as it can be seen in its `package.json` file:

```json
"scripts": {
      "start": "electron --no-sandbox .",
      "test": "echo \"Error: no test specified\" && exit 1"
    },
```

If you also want to package applications inside the container, then check the file `readme-electron.md` in the home directory first.
