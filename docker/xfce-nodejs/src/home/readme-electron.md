# Readme `electron`

This Docker image **does not** come with any pre-installed `electron` version by intention. That allows you to choose the version and the way of installation that suite you best.

Everything else you need is already included. There is also a simple application in the folder `/srv/samples/electron-test-app/`. You can test it including the packaging and installing the result package, all inside the container.

You can start by following the [Electron Quick Start Guide](https://www.electronjs.org/docs/tutorial/quick-start).

## Prerequisites

Please make sure that you are using an image that includes also **Chromium** web browser. Pick one of the images that includes the word `chromium` in its tag.

Updating `npm` is not required, because the image usually already includes the up-to-date version, but you may decide to do so:

```shell
npm install -g npm
```

## Installing `electron`

You can install `electron` globally or locally for a particular project. Local installation is usually the better choice.

Example of installing `electron` in the project `electron-test-app`:

```shell
cd /srv/samples/electron-test-app/
npm install --save-dev electron
```

Example of installing `electron` globally:

```shell
npm install -g electron
```

## Starting `electron` applications

Note that all `electron` applications inside the container must be started with the option `--no-sandbox`.

The sample application `electron-test-app` is already prepared for that, as it can be seen in its `package.json` file:

```json
"scripts": {
      "start": "electron --no-sandbox .",
      "test": "echo \"Error: no test specified\" && exit 1"
    },
```

The sample application can be then started by:

```shell
npm start
```

You also need to add `--no-sandbox` to the desktop launchers. For example:

```shell
### Edit Launcher / Command
electron-test-app --no-sandbox %U
```

## Packaging `electron` applications

If you want to package your application inside the container, 
you should install `electron` locally inside the project directory.

You also need to install some additional utilities, that are not included by default, to keep the image slimmer:

```shell
sudo apt-get update
sudo apt-get -y install fakeroot rpm
```

There are several ways of creating application packages, but if you follow the example from [Electron Quick Start Guide](https://www.electronjs.org/docs/tutorial/quick-start), you need to install `Electron Forge`:

```shell
npx @electron-forge/cli import
```

Then you can package the application:

```shell
npm run make
```

The result `deb` and `rpm` packages will be stored into the sub-folders of the `/srv/samples/electron-test-app/out/make/` directory.

## Installing `electron` packages

Before installing the application packages inside the container you have to update the `apt-get` cache:

```shell
sudo apt-get update
```

Then you can install the `deb` package using `gdebi`:

```shell
cd /srv/samples/electron-test-app/out/make/deb/x64/
sudo apt-get install -y ./electron-test-app_1.0.0_amd64.deb
```

The application launcher **electron-test-app** will be created in the `Accessories` group. Drag-and-drop it onto the desktop. Then right click it, choose `Edit Launcher` and add the `--no-sandbox` option to the launcher command. After saving it you can start the application with the launcher.
