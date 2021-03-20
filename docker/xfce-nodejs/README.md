# Headless Ubuntu/Xfce container with VNC/noVNC for `Node.js` development

## accetto/ubuntu-vnc-xfce-nodejs-g3

[Docker Hub][this-docker] - [Git Hub][this-github] - [Dockerfile][this-dockerfile] - [Docker Readme][this-readme-dockerhub] - [Changelog][this-changelog] - [Project Readme][this-readme-project] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment, [VNC][tigervnc]/[noVNC][novnc] servers for headless use, the JavaScript-based platform [Node.js][nodejs] with [npm][npm] and optionally other tools for programming (e.g. [Visual Studio Code][vscode]).

All images can also contain the current [Chromium][chromium] or [Firefox][firefox] web browsers.

Adding more tools like [TypeScript][typescript], [Angular][angular] or [Electron][electron] usually requires only a single or just a few commands. The instructions are in the provided README files and some simple test applications are also already included.

### TL;DR

The fastest way to build the images locally:

```shell
### PWD = project root
./docker/hooks/build dev nodejs-vnc
./docker/hooks/build dev nodejs-vnc-chromium
./docker/hooks/build dev nodejs-vnc-vscode
./docker/hooks/build dev nodejs-vnc-vscode-chromium
./docker/hooks/build dev nodejs-vnc-novnc
./docker/hooks/build dev nodejs-vnc-novnc-chromium
./docker/hooks/build dev nodejs-vnc-novnc-vscode-chromium
./docker/hooks/build dev nodejs-vnc-vscode-firefox
./docker/hooks/build dev nodejs-vnc-vscode-firefox-plus
./docker/hooks/build dev nodejs-current-vnc-vscode
### and so on ...
```

Find more in the hook script `env.rc` and in the [sibling Wiki][sibling-wiki].

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

### Table of contents

- [Headless Ubuntu/Xfce container with VNC/noVNC for `Node.js` development](#headless-ubuntuxfce-container-with-vncnovnc-for-nodejs-development)
  - [accetto/ubuntu-vnc-xfce-nodejs-g3](#accettoubuntu-vnc-xfce-nodejs-g3)
    - [TL;DR](#tldr)
    - [Table of contents](#table-of-contents)
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

This is the **third generation** (G3) of my headless images. They replace the **second generation** (G2) of similar images from the GitHub repository [accetto/xubuntu-vnc][accetto-github-xubuntu-vnc], which will be archived.

More information about the image generations can be found in the [sibling project README][sibling-readme-project] file and the [sibling Wiki][sibling-wiki].

**Remark:** The images can optionally contain the current `Chromium Browser` version from the `Ubuntu 18.04 LTS` distribution. This is because the version for `Ubuntu 20.04 LTS` depends on `snap`, which is not working correctly in Docker at this time. They can also optionally contain the latest version of the current [Firefox][firefox] browser for `Ubuntu 20.04 LTS`.

**Attention:** If you will build an image containing the [Chromium Browser][chromium], then the browser will run in the `--no-sandbox` mode. You should be aware of the implications. The image is intended for testing and development.

**Attention:** If you will build an image containing the [Firefox][firefox] browser, then the browser will run in the `multi-process` mode. Be aware, that this mode requires larger shared memory (`/dev/shm`). At least 256MB is recommended. Please check the **Firefox multi-process** page in [this Wiki][that-wiki-firefox-multiprocess] for more information and the instructions, how to set the shared memory size in different scenarios.

The main features and components of the images in the default configuration are:

- utilities **ping**, **wget**, **sudo**, **dconf-editor**, [curl][curl], [git][git] (Ubuntu distribution)
- utility **gdebi** for installing local `.deb` packages with automatic dependency resolution (Ubuntu distribution)
- current version of JSON processor [jq][jq]
- light-weight [Xfce][xfce] desktop environment (Ubuntu distribution)
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Ubuntu distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Ubuntu distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding both the container user account and its group
- support of **version sticker** (see below)
- optionally the current version of [Chromium Browser][chromium] open-source web browser (from the `Ubuntu 18.04 LTS` distribution)
- optionally the current version of [Firefox][firefox] web browser and optionally also some additional **plus** features described in the [sibling image README][sibling-readme-xfce-firefox]

All images include the `LTS` or the `current` version of [Node.js][nodejs] with [npm][npm] and optionally also the current version of the free open-source developer editor [Visual Studio Code][vscode].

The history of notable changes is documented in the [CHANGELOG][this-changelog].

![container-screenshot][this-screenshot-container]

### Image tags

The included resources allow building of almost any combination of the following selectable features:

- **VNC** server with optional **noVNC** access
- **LTS** or **current** version of **Node.js**
- optional **Visual Studio Code** editor
- optional **Chromium** or **Firefox** browser with optional **plus features** (described in the [sibling image README][sibling-readme-xfce-firefox])
- optional **screenshooting** and **thumbnailing** support

There are also other, more subtle, optional features.

You can build all possible variations of the images locally, but it would not be reasonable to do the same on Docker Hub.

Therefore only the following image tags will be regularly built and published on Docker Hub (with `Node.js LTS` by default):

- images with [Node.js LTS][nodejs]
  - base images
    - `latest` is identical to `vnc-novnc`
    - `vnc` implements only VNC
    - `vnc-novnc` implements VNC and noVNC
  - adding [Visual Studio Code][vscode]
    - `vnc-vscode`
    - `vnc-novnc-vscode`
  - adding [Visual Studio Code][vscode] and [Chromium Browser][chromium]
    - `vnc-vscode-chromium`
    - `vnc-novnc-vscode-chromium`
  - adding only [Chromium Browser][chromium]
    - `vnc-chromium`
    - `vnc-novnc-chromium`
- images with [Node.js Current][nodejs]
  - base images
    - `current-vnc-novnc`

The following image tags will not be built or published on Docker Hub, but they can be built any time locally from the same [source repository][this-github]:

- images with [Node.js LTS][nodejs]
  - adding [Firefox][firefox] with optional **plus features** (described in the [sibling image README][sibling-readme-xfce-firefox])
    - `vnc-novnc-firefox` and `vnc-novnc-firefox-plus`
  - adding [Visual Studio Code][vscode] and [Firefox][firefox] with optional **plus features**
    - `vnc-novnc-vscode-firefox` and `vnc-novnc-vscode-firefox-plus`
  - other images
    - various combinations of other, more subtle, features (see the hook script `env.rc`)
- images with [Node.js Current][nodejs]
  - the same spectrum of images as by the `LTS` version, only their tags would start with the prefix `current-`

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

The container's directory `/srv/projects` already contains the following simple testing applications:

- nodejs-test-app
- electron-test-app

Note that they will be copied locally only if the local directory, you have mounted, has been empty.

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

The default `NO_VNC_PORT` value is `6901`. The noVNC password is always identical to the VNC password.

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

***

<!-- GitHub project common -->

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-coding-g3/
[this-issues]: https://github.com/accetto/headless-coding-g3/issues
[this-readme-dockerhub]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3
[this-readme-project]: https://github.com/accetto/headless-coding-g3/blob/master/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme-project]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-readme-xfce]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce/README.md
[sibling-readme-xfce-firefox]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/docker/xfce-firefox/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Docker image specific -->

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3/
[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.nodejs

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/xfce-nodejs/ubuntu-vnc-xfce-nodejs.jpg

<!-- Previous generations -->

[accetto-github-xubuntu-vnc]: https://github.com/accetto/xubuntu-vnc/

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- External links -->

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

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
[tightvnc]: http://www.tightvnc.com
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
