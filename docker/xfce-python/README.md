# Headless Ubuntu/Xfce container with VNC/noVNC for `Python` development

## accetto/ubuntu-vnc-xfce-python-g3

[Docker Hub][this-docker] - [Git Hub][this-github] - [Dockerfile][this-dockerfile] - [Docker Readme][this-readme-dockerhub] - [Changelog][this-changelog] - [Project Readme][this-readme-project]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]

***

- [Headless Ubuntu/Xfce container with VNC/noVNC for `Python` development](#headless-ubuntuxfce-container-with-vncnovnc-for-python-development)
  - [accetto/ubuntu-vnc-xfce-python-g3](#accettoubuntu-vnc-xfce-python-g3)
    - [Introduction](#introduction)
    - [TL;DR](#tldr)
      - [Installing packages](#installing-packages)
      - [Shared memory size](#shared-memory-size)
      - [Extending images](#extending-images)
      - [Building images](#building-images)
      - [Sharing devices](#sharing-devices)
      - [Other examples](#other-examples)
    - [Description](#description)
    - [Image tags](#image-tags)
    - [Ports](#ports)
    - [Volumes](#volumes)
    - [Version sticker](#version-sticker)
  - [Using headless containers](#using-headless-containers)
    - [Overriding VNC/noVNC parameters](#overriding-vncnovnc-parameters)
    - [Running containers in background or foreground](#running-containers-in-background-or-foreground)
    - [Startup options and help](#startup-options-and-help)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)
  - [Diagrams](#diagrams)
    - [Dockerfile.xfce.python](#dockerfilexfcepython)
    - [Dockerfile.xfce.python (bonus branch)](#dockerfilexfcepython-bonus-branch)

***

### Introduction

This repository contains resources for building Docker images based on [Debian 11][docker-debian] with [Xfce][xfce] desktop environment, [VNC][tigervnc]/[noVNC][novnc] servers for headless use, [Python][python] programming language with its package installer [pip][pip] and optionally other tools for programming (e.g. [Visual Studio Code][vscode]).

All images can optionally include also the [Chromium][chromium] or [Firefox][firefox] web browsers.

Adding more tools like, for example, the web frameworks [Flask][flask] and [Bottle][bottle] or the most popular Python GUI frameworks [TKinter][tkinter], [PyQt5][pyqt5], [PyQT for Python][pyside] (`PySide2` or `PySide6`), [wxPython][wxpython] or [Kivy][kivy] usually requires only a single or just a few commands. The instructions are in the [provided README file](https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-python/src/home/) and some simple test applications are also already included.

This is a sibling project to the project [accetto/debian-vnc-xfce-g3][accetto-github-debian-vnc-xfce-g3].

There is also the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] containing similar images based on [Ubuntu 22.04 LTS and 20.04 LTS][docker-ubuntu].

### TL;DR

#### Installing packages

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Debian Packages Search][debian-packages-search] page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```

#### Shared memory size

Note that some applications require larger shared memory than the default 64MB. Using 256MB usually solves crashes or strange behavior.

You can check the current shared memory size by executing the following command inside the container:

```shell
df -h /dev/shm
```

The older sibling Wiki page [Firefox multi-process][that-wiki-firefox-multiprocess] describes several ways, how to increase the shared memory size.

#### Extending images

The provided example file `Dockerfile.extend` shows how to use the images as the base for your own images.

Your concrete `Dockerfile` may need more statements, but the concept should be clear.

The compose file `example.yml` shows how to switch to another non-root user and how to set the VNC password and resolution.

#### Building images

The fastest way to build the images:

```shell
### PWD = project root
### prepare and source the 'secrets.rc' file first (see 'example-secrets.rc')

### examples of building and publishing the individual images 
./builder.sh python all
./builder.sh python-chromium all
./builder.sh python-vscode all
./builder.sh python-vscode-chromium all
./builder.sh python-vscode-firefox all

### just building the image, skipping the publishing and the version sticker update
./builder.sh python build

### examples of building and publishing the images as a group
./ci-builder.sh all group python python-chromium python-vscode-chromium

### or all the images featuring Python
./ci-builder.sh all group complete-python
```

You can still execute the individual hook scripts as before (see the folder `/docker/hooks/`). However, the provided utilities `builder.sh` and `ci-builder.sh` are more convenient. Before pushing the images to the **Docker Hub** you have to prepare and source the file `secrets.rc` (see `example-secrets.rc`). The script `builder.sh` builds the individual images. The script `ci-builder.sh` can build various groups of images or all of them at once. Check the files `local-builder-readme.md`, `local-building-example.md` and the [sibling Wiki][sibling-wiki] for more information.

Note that selected features that are enabled by default can be explicitly disabled via environment variables. This allows to build even smaller images by excluding, for example, `noVNC`. See [readme-local-building-example.md][this-readme-local-building-example] for more information.

#### Sharing devices

Sharing the audio device for video with sound works only with `Chromium` and only on Linux:

```shell
docker run -it -P --rm \
  --device /dev/snd:/dev/snd:rw \
  --group-add audio \
accetto/debian-vnc-xfce-python-g3:chromium
```

Sharing the display with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/debian-vnc-xfce-python-g3:latest --skip-vnc

xhost -local:$(whoami)
```

Sharing the X11 socket with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/debian-vnc-xfce-python-g3:latest

xhost -local:$(whoami)
```

#### Other examples

The [python-readme][this-readme-python] describes how to install additional Python modules and GUI frameworks. The simple test applications are in `/srv/samples/`.

Making [Visual Studio Code][vscode] settings and extensions persistent:

```shell
### bind these container folders to external volumes
/home/headless/.config/Code
/home/headless/.vscode/

### Tip: Keep keyboard shortcuts consistent by setting the keyboard layout
### before starting the Visual Studio Code.
```

### Description

This is the **third generation** (G3) of my headless images. The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc]. The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

**Attention:** If you will build an image containing the [Chromium Browser][chromium], then the browser will run in the `--no-sandbox` mode. You should be aware of the implications. The image is intended for testing and development.

**Attention:** If you will build an image containing the [Firefox][firefox] browser, then the browser will run in the `multi-process` mode. Be aware, that this mode requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the **Firefox multi-process** page in this older [sibling Wiki][that-wiki-firefox-multiprocess] for more information and the instructions, how to set the shared memory size in different scenarios.

The main features and components of the images in the default configuration are:

- utilities **ping**, **wget**, **sudo**, [curl][curl], [git][git] (Debian distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (Debian distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Debian distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Debian distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding both the container user account and its group
- support of **version sticker** (see below)
- optionally the current version of [Chromium Browser][chromium] open-source web browser (Debian distribution)
- optionally the current version of [Firefox ESR (Extended Support Release)][firefox] web browser and optionally also some additional **plus features** described in the [sibling project README][sibling-readme-xfce-firefox]

All images include [Python][python] with [pip][pip] package installer (Debian distribution) and optionally also the current version of the free open-source developer editor [Visual Studio Code][vscode].

The history of notable changes is documented in the [CHANGELOG][this-changelog].

![container-screenshot][this-screenshot-container]

### Image tags

The included resources allow building of almost any combination of the following selectable features:

- **VNC** server with optional **noVNC** access
- **Python** with **pip** package installer
- optional **Visual Studio Code** editor
- optional **Chromium** or **Firefox** browser with optional **plus features** (described in the [sibling project README][sibling-readme-xfce-firefox])
- optional **screenshooting** and **thumbnailing** support

There are also other, more subtle, optional features. Check the hook script `env.rc` if you are interested about them.

You can build all possible variations of the images locally, but it would not be reasonable to publish all of them on the **Docker Hub**.

Therefore only the following image tags will be regularly built and published on the **Docker Hub**:

- `latest` implements VNC and noVNC
- `chromium` adds [Chromium Browser][chromium]
- `vscode` adds [Visual Studio Code][vscode]
- `vscode-chromium` adds [Visual Studio Code][vscode] and [Chromium Browser][chromium]
- `vscode-firefox` adds [Visual Studio Code][vscode] and [Firefox][firefox] with **plus features**

The [source repository][this-github] contains also the branch `bonus-images-python-gui-frameworks`, which allows building images already including the most popular Python GUI frameworks (see above). Those images could be occasionally pushed to Docker Hub, but there will be no effort to do it regularly. However, you can built them locally any time.

Clicking on the version sticker badge in the [README on Docker Hub][this-readme-dockerhub] reveals more information about the actual configuration of the image.

### Ports

Following **TCP** ports are exposed by default:

- **5901** is used for access over **VNC**
- **6901** is used for access over [noVNC][novnc]

The VNC/noVNC default ports and also some other parameters can be overridden several ways as it is described in the [sibling image README file][sibling-readme-xfce].

### Volumes

The containers do not create or use any external volumes by default.

Both **named volumes** and **bind mounts** can be used. More about volumes can be found in [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

However, the container's mounting point `/srv/projects/` is intended for sharing the projects between the container and the host computer:

```shell
docker run -v /my_local_projects:/srv/projects ...

### or using the newer syntax
docker run --mount source=/my_local_projects,target=/srv/projects ...
```

The container's directory `/srv/samples` already contains the following simple testing applications:

- loguru-test-app
- typer-cli-test-app
- tkinter-test-app
- wx-test-app
- pyqt-test-app
- pyside-test-app
- kivy-test-app

Note that they will be copied locally only if the local directory, you have mounted, has been empty.

**Tip** If you use an image containing [Visual Studio Code][vscode] and you want to make your settings and extensions persistent, then bind the following container folder to external volumes:

```shell
/home/headless/.config/Code
/home/headless/.vscode/
```

To keep the keyboard shortcuts consistent, change the keyboard layout to your preferred one before starting the [Visual Studio Code][vscode].

### Version sticker

Version sticker serves multiple purposes that are closer described in the [sibling Wiki][sibling-wiki]. Note that the usage of the version sticker has changed between the generations of images.

The **short version sticker value** describes the version of the image and it is persisted in its **label** during the build-time. It is also shown as its **badge** in the README file.

The **verbose version sticker value** is used by the CI builder to decide if the image needs to be refreshed. It describes the actual configuration of the essential components of the image. It can be revealed by clicking on the version sticker badge in the README file.

The version sticker values are generated by the script `version_sticker.sh`, which is deployed into the startup directory `/dockerstartup`. The script will show a short help if executed with the argument `-h`. There is also a convenient `Version Sticker` launcher on the container desktop.

## Using headless containers

There are two ways, how to use the containers created from this image.

All containers are accessible by a VNC viewer (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The default `VNC_PORT` value is `5901`. The default `DISPLAY` value is `:1`. The default VNC password (`VNC_PW`) is `headless`.

The containers that are created from the images built with the **noVNC feature** can be also accessed over [noVNC][noVNC] by any web browser supporting HTML5.

The default `NOVNC_PORT` value is `6901`. The noVNC password is always identical to the VNC password.

There are several ways of connecting to headless containers and the possibilities also differ between the Linux and Windows environments, but usually it is done by mapping the VNC/noVNC ports exposed by the container to some free TCP ports on its host system.

For example, the following command would map the VNC/noVNC ports `5901/6901` of the container to the TCP ports `25901/26901` on the host:

```shell
docker run -p 25901:5901 -p 26901:6901 ...
```

If the container would run on the local computer, then it would be accessible over **VNC** as `localhost:25901` and over **noVNC** as `http://localhost:26901`.

If it would run on the remote server  `mynas`, then it would be accessible over **VNC** as `mynas:25901` and over **noVNC** as `http://mynas:26901`.

The image offers two [noVNC][novnc] clients - **lite client** and **full client**. Because the connection URL differs slightly in both cases, the container provides a **simple startup page**.

The startup page offers two hyperlinks for both noVNC clients:

- **noVNC Lite Client** (`http://mynas:26901/vnc_lite.html`)
- **noVNC Full Client** (`http://mynas:26901/vnc.html`)

It is also possible to provide the password through the links:

- `http://mynas:26901/vnc_lite.html?password=headless`
- `http://mynas:26901/vnc.html?password=headless`

### Overriding VNC/noVNC parameters

This image supports several ways of overriding the VNC/noVNV parameters. The [sibling image README file][sibling-readme-xfce] describes how to do it.

### Running containers in background or foreground

The [sibling image README file][sibling-readme-xfce] describes how to run the containers in the background (detached) of foreground (interactively).

### Startup options and help

The startup options and help are also described in the [sibling image README file][sibling-readme-xfce].

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

## Diagrams

### Dockerfile.xfce.python

![Dockerfile.xfce.python stages][this-diagram-dockerfile-stages-python]

### Dockerfile.xfce.python (bonus branch)

![Dockerfile.xfce.python (bonus) stages][this-diagram-dockerfile-stages-python-bonus]

***

<!-- this project -->

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-coding-g3/
[this-issues]: https://github.com/accetto/headless-coding-g3/issues
[this-readme-dockerhub]: https://hub.docker.com/r/accetto/debian-vnc-xfce-python-g3
[this-readme-project]: https://github.com/accetto/headless-coding-g3/blob/master/README.md
[this-readme-python]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-python/src/home/readme-python.md

[this-readme-local-building-example]: https://github.com/accetto/headless-coding-g3/blob/master/readme-local-building-example.md

<!-- Sibling project -->

[accetto-github-debian-vnc-xfce-g3]: https://github.com/accetto/debian-vnc-xfce-g3
[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme-xfce]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce/README.md
[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Docker image specific -->

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-python-g3/
[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.python

[this-diagram-dockerfile-stages-python]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.python.png
[this-diagram-dockerfile-stages-python-bonus]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.python-bonus.png

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/ubuntu-vnc-xfce-python.jpg

<!-- Previous generations -->

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/
[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- External links -->

[docker-debian]: https://hub.docker.com/_/debian/
[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[debian-packages-search]: https://packages.debian.org/index

[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[bottle]: https://bottlepy.org/
[chromium]: https://www.chromium.org/Home
[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
[firefox]: https://www.mozilla.org
[flask]: https://palletsprojects.com/p/flask/
[git]: https://git-scm.com/
[jq]: https://stedolan.github.io/jq/
[kivy]: https://kivy.org/#home
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[pip]: https://pip.pypa.io/en/stable/
[pyqt5]: https://www.riverbankcomputing.com/software/pyqt/
[pyside]: https://doc.qt.io/qtforpython/
[python]: https://www.python.org/
[tigervnc]: http://tigervnc.org
[tightvnc]: http://www.tightvnc.com
[tini]: https://github.com/krallin/tini
[tkinter]: https://wiki.python.org/moin/TkInter
[vscode]: https://code.visualstudio.com/
[wxpython]: https://wxpython.org/
[xfce]: http://www.xfce.org

<!-- github badges common -->

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-coding-g3?logo=github

<!-- docker badges specific -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-python-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-python-g3?icon=docker&label=stars
