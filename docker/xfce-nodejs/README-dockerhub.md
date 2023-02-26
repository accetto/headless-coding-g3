# Headless Debian/Xfce container with VNC/noVNC for `Node.js` development

## accetto/debian-vnc-xfce-nodejs-g3

[Docker Hub][this-docker] - [Git Hub][this-github] - [Dockerfile][this-dockerfile] - [Full Readme][this-readme-full] - [Changelog][this-changelog] - [Project Readme][this-readme-project]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]

![badge_latest_created][badge_latest_created]
[![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

***

- [Headless Debian/Xfce container with VNC/noVNC for `Node.js` development](#headless-debianxfce-container-with-vncnovnc-for-nodejs-development)
  - [accetto/debian-vnc-xfce-nodejs-g3](#accettodebian-vnc-xfce-nodejs-g3)
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
  - [Using headless containers](#using-headless-containers)
    - [Overriding VNC/noVNC parameters](#overriding-vncnovnc-parameters)
    - [Startup options and help](#startup-options-and-help)
    - [More information](#more-information)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)

***

### Introduction

This repository contains resources for building Docker images based on [Debian 11][docker-debian] with [Xfce][xfce] desktop environment, [VNC][tigervnc]/[noVNC][novnc] servers for headless use, the JavaScript-based platform [Node.js][nodejs] with [npm][npm] and optionally other tools for programming (e.g. [Visual Studio Code][vscode]).

All images can optionally include also the [Chromium][chromium] or [Firefox][firefox] web browsers.

Adding more tools like [TypeScript][typescript], [Angular][angular] or [Electron][electron] usually requires only a single or just a few commands. The instructions are in the provided README files and some simple test applications are also already included.

This is the **short README** version for the **Docker Hub**. There is also the [full-length README][this-readme-full] on the **GitHub**.

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
./builder.sh nodejs all
./builder.sh nodejs-chromium all
./builder.sh nodejs-vscode all
./builder.sh nodejs-vscode-chromium all
./builder.sh nodejs-vscode-firefox all
./builder.sh nodejs-current all

### just building the image, skipping the publishing and the version sticker update
./builder.sh nodejs build

### examples of building and publishing the images as a group
./ci-builder.sh all group nodejs nodejs-current nodejs-vscode-chromium

### or all the images featuring Node.js
./ci-builder.sh all group complete-nodejs
```

You can still execute the individual hook scripts as before (see the folder `/docker/hooks/`). However, the provided utilities `builder.sh` and `ci-builder.sh` are more convenient. Before pushing the images to the **Docker Hub** you have to prepare and source the file `secrets.rc` (see `example-secrets.rc`). The script `builder.sh` builds the individual images. The script `ci-builder.sh` can build various groups of images or all of them at once. Check the files `local-builder-readme.md`, `local-building-example.md` and the sibling [Wiki][sibling-wiki] for more information.

Note that selected features that are enabled by default can be explicitly disabled via environment variables. This allows to build even smaller images by excluding, for example, `noVNC`. See [readme-local-building-example.md][this-readme-local-building-example] for more information.

#### Sharing devices

Sharing the audio device for video with sound works only with `Chromium` and only on Linux:

```shell
docker run -it -P --rm \
  --device /dev/snd:/dev/snd:rw \
  --group-add audio \
accetto/debian-vnc-xfce-nodejs-g3:chromium
```

Sharing the display with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    -e DISPLAY=${DISPLAY} \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/debian-vnc-xfce-nodejs-g3:latest --skip-vnc

xhost -local:$(whoami)
```

Sharing the X11 socket with the host works only on Linux:

```shell
xhost +local:$(whoami)

docker run -it -P --rm \
    --device /dev/dri/card0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    accetto/debian-vnc-xfce-nodejs-g3:latest

xhost -local:$(whoami)
```

#### Other examples

Making [Visual Studio Code][vscode] settings and extensions persistent:

```shell
### bind these container folders to external volumes
/home/headless/.config/Code
/home/headless/.vscode/

### Tip: Keep keyboard shortcuts consistent by setting the keyboard layout
### before starting the Visual Studio Code.
```

Updating [npm][npm]:

```shell
### globally
npm install -g npm

### checking the versions
node -v
npm -v
npx -v
```

Installing [TypeScript][typescript]:

```shell
### globally
npm install -g typescript

### checking the version
tsc --version
```

Installing [Angular][angular]:

```shell
### globally
npm install -g @angular/cli

### checking the version
ng --version
```

Installing [Electron][electron]:

```shell
### local installation inside a project works usually better
npm install --save-dev electron

### apps need to be started with '--no-sandbox' option
electron-test-app --no-sandbox %U
```

### Description

This is the **third generation** (G3) of my headless images. The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc]. The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

More information about the image generations can be found in the [sibling project README][sibling-readme-project] file and the [sibling Wiki][sibling-wiki].

**Attention:** If you will build an image containing the [Chromium Browser][chromium], then the browser will run in the `--no-sandbox` mode. You should be aware of the implications. The image is intended for testing and development.

**Attention:** If you will build an image containing the [Firefox][firefox] browser, then the browser will run in the `multi-process` mode. Be aware, that this mode requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the **Firefox multi-process** page in this older [sibling Wiki][that-wiki-firefox-multiprocess] for more information and the instructions, how to set the shared memory size in different scenarios.

The main features and components of the images in the default configuration are:

- utilities **ping**, **wget**, **sudo** [curl][curl], [git][git] (Debian distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (DEbian distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Debian distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Debian distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding both the container user account and its group
- support of **version sticker** (see the [full-length README][this-readme-full] on the **GitHub**)
- optionally the current version of [Chromium Browser][chromium] open-source web browser (Debian distribution)
- optionally the current version of [Firefox ESR (Extended Support Release)][firefox] web browser and optionally also some additional **plus features** described in the [sibling project README][sibling-readme-xfce-firefox]

All images include the `LTS` or the `current` version of [Node.js][nodejs] with [npm][npm] and optionally also the current version of the free open-source developer editor [Visual Studio Code][vscode].

The history of notable changes is documented in the [CHANGELOG][this-changelog].

![container-screenshot][this-screenshot-container]

### Image tags

The included resources allow building of almost any combination of the following selectable features:

- **VNC** server with optional **noVNC** access
- **LTS** or **current** version of **Node.js**
- optional **Visual Studio Code** editor
- optional **Chromium** or **Firefox** browser with optional **plus features** (described in the [sibling project README][sibling-readme-xfce-firefox])
- optional **screenshooting** and **thumbnailing** support

There are also other, more subtle, optional features. Check the hook script `env.rc` if you are interested about them.

You can build all possible variations of the images locally, but it would not be reasonable to publish all of them on the **Docker Hub**.

Therefore only the following image tags will be regularly built and published on the **Docker Hub** (with [Node.js][nodejs] `LTS` by default):

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `chromium` adds [Chromium Browser][chromium]

    ![badge_chromium_created][badge_chromium_created]
    [![badge_chromium_version-sticker][badge_chromium_version-sticker]][link_chromium_version-sticker-verbose]

- `vscode` adds [Visual Studio Code][vscode]

    ![badge_vscode_created][badge_vscode_created]
    [![badge_vscode_version-sticker][badge_vscode_version-sticker]][link_vscode_version-sticker-verbose]

- `vscode-chromium` adds [Visual Studio Code][vscode] and [Chromium Browser][chromium]

    ![badge_vscode-chromium_created][badge_vscode-chromium_created]
    [![badge_vscode-chromium_version-sticker][badge_vscode-chromium_version-sticker]][link_vscode-chromium_version-sticker-verbose]

- `vscode-firefox` adds [Visual Studio Code][vscode] and [Firefox][firefox] with **plus features**

    ![badge_vscode-firefox_created][badge_vscode-firefox_created]
    [![badge_vscode-firefox_version-sticker][badge_vscode-firefox_version-sticker]][link_vscode-firefox_version-sticker-verbose]

- `current` with [Node.js][nodejs] `Current`, implements VNC and noVNC

    ![badge_current_created][badge_current_created]
    [![badge_current_version-sticker][badge_current_version-sticker]][link_current_version-sticker-verbose]

Clicking on the version sticker badge in the [README on Docker Hub][this-readme-dockerhub] reveals more information about the actual configuration of the image.

### Ports

Following **TCP** ports are exposed by default:

- **5901** is used for access over **VNC**
- **6901** is used for access over [noVNC][novnc]
- **3000** is used by the [Node.js][nodejs] server

The VNC/noVNC default ports and also some other parameters can be overridden several ways as it is described in the [sibling image README file][sibling-readme-xfce].

The [Node.js][nodejs] server default port can be overridden at the **image build-time** by the build argument `ARG_NODEJS_PORT` or at the **container startup-time** by the environment variable `NODEJS_PORT`.

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

- nodejs-test-app
- electron-test-app

Note that they will be copied locally only if the local directory, you have mounted, has been empty.

**Tip** If you use an image containing [Visual Studio Code][vscode] and you want to make your settings and extensions persistent, then bind the following container folder to external volumes:

```shell
/home/headless/.config/Code
/home/headless/.vscode/
```

To keep the keyboard shortcuts consistent, change the keyboard layout to your preferred one before starting the [Visual Studio Code][vscode].

## Using headless containers

More information about using headless containers can be found in the [full-length README][this-readme-full] file on GitHub.

### Overriding VNC/noVNC parameters

This image supports several ways of overriding the VNC/noVNV parameters. The [sibling image README file][sibling-readme-xfce] describes how to do it.

### Startup options and help

The startup options and help are also described in the [sibling image README file][sibling-readme-xfce].

### More information

More information about these images can be found in the [full-length README][this-readme-full] file on GitHub.

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

<!-- GitHub project common -->

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-coding-g3/
[this-issues]: https://github.com/accetto/headless-coding-g3/issues
[this-readme-dockerhub]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nodejs-g3
[this-readme-full]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-nodejs/README.md
[this-readme-project]: https://github.com/accetto/headless-coding-g3/blob/master/README.md

[this-readme-local-building-example]: https://github.com/accetto/headless-coding-g3/blob/master/readme-local-building-example.md

<!-- Sibling projects -->

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme-project]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-readme-xfce]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce/README.md
[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Docker image specific -->

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3/
[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.nodejs

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/ubuntu-vnc-xfce-nodejs.jpg

<!-- Previous generations -->

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/
[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- External links -->

[docker-debian]: https://hub.docker.com/_/debian/

[debian-packages-search]: https://packages.debian.org/index

[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[angular]: https://angular.io/
[chromium]: https://www.chromium.org/Home
[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
[electron]: https://www.electronjs.org/
[firefox]: https://www.mozilla.org
[git]: https://git-scm.com/
[nodejs]: https://www.nodejs.org/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[novnc]: https://github.com/kanaka/noVNC
[npm]: https://www.npmjs.com/
[tigervnc]: http://tigervnc.org
[tini]: https://github.com/krallin/tini
[typescript]: https://www.typescriptlang.org/
[vscode]: https://code.visualstudio.com/
[xfce]: http://www.xfce.org

<!-- github badges common -->

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-coding-g3?logo=github

<!-- docker badges specific -->

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/ubuntu-vnc-xfce-nodejs-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/ubuntu-vnc-xfce-nodejs-g3?icon=docker&label=stars

<!-- Appendix -->
