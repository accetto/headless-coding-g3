# Headless Debian/Xfce containers with VNC/noVNC for programming

## Project `accetto/headless-coding-g3`

Version: G3v3

***

[Docker Hub][this-docker] - [Changelog][this-changelog] - [sibling Wiki][sibling-wiki] - [sibling Discussions][sibling-discussions]

![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]
![badge-github-stars][badge-github-stars]
![badge-github-forks][badge-github-forks]
![badge-github-open-issues][badge-github-open-issues]
![badge-github-closed-issues][badge-github-closed-issues]
![badge-github-releases][badge-github-releases]
![badge-github-commits][badge-github-commits]
![badge-github-last-commit][badge-github-last-commit]

<!-- ![badge-github-workflow-dockerhub-autobuild][badge-github-workflow-dockerhub-autobuild] -->
<!-- ![badge-github-workflow-dockerhub-post-push][badge-github-workflow-dockerhub-post-push] -->

***

- [Headless Debian/Xfce containers with VNC/noVNC for programming](#headless-debianxfce-containers-with-vncnovnc-for-programming)
  - [Project `accetto/headless-coding-g3`](#project-accettoheadless-coding-g3)
  - [Introduction](#introduction)
  - [TL;DR](#tldr)
    - [Installing packages](#installing-packages)
    - [Shared memory size](#shared-memory-size)
    - [Extending images](#extending-images)
    - [Building images](#building-images)
    - [Sharing devices](#sharing-devices)
  - [Project versions](#project-versions)
  - [Issues, Wiki and Discussions](#issues-wiki-and-discussions)
  - [Credits](#credits)

## Introduction

This repository contains resources for building Docker images based on [Debian 11][docker-debian] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use and selected applications for programming. Adding more tools requires usually only a single or just a few commands. The instructions are in the provided README files and some simple test applications are also already included.

**Remark**: The resources for the previous versions of the images (based on [Ubuntu 20.04 LTS][docker-ubuntu] till G3v2) are still available in this repository as the branches `archived-generation-g3v2-ubuntu` and `archived-generation-g3v1`.

All images can optionally include also the [Chromium][chromium] or [Firefox][firefox] web browsers.

The resources for the individual images and their variations (tags) are stored in the subfolders of the **master** branch. Each image has its own README file describing its features and usage.

This is a sibling project to the project [accetto/debian-vnc-xfce-g3][accetto-github-debian-vnc-xfce-g3].

Another sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] contains the detailed description of the third generation (G3) of my Docker images. Please check the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki] for common information.

## TL;DR

There are currently resources for the following Docker images:

- [accetto/debian-vnc-xfce-nodejs-g3][accetto-docker-debian-vnc-xfce-nodejs-g3]
  - [full Readme][this-readme-image-nodejs]
  - [Dockerfile][this-dockerfile-nodejs]
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-nodejs]
- [accetto/debian-vnc-xfce-postman-g3][accetto-docker-debian-vnc-xfce-postman-g3]
  - [full Readme][this-readme-image-postman]
  - [Dockerfile][this-dockerfile-postman]
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-postman]
- [accetto/debian-vnc-xfce-python-g3][accetto-docker-debian-vnc-xfce-python-g3]
  - [full Readme][this-readme-image-python]
  - [Dockerfile][this-dockerfile-python]
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-python]
  - [Dockerfile][this-dockerfile-python-bonus-gui-frameworks] for bonus images with GUI frameworks (bonus branch)
  - [Dockerfile stages diagram][this-diagram-dockerfile-stages-python-bonus] (bonus branch)

### Installing packages

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Debian Packages Search][debian-packages-search] page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```

### Shared memory size

Note that some applications require larger shared memory than the default 64MB. Using 256MB usually solves crashes or strange behavior.

You can check the current shared memory size by executing the following command inside the container:

```shell
df -h /dev/shm
```

The older sibling Wiki page [Firefox multi-process][that-wiki-firefox-multiprocess] describes several ways, how to increase the shared memory size.

### Extending images

The provided example file `Dockerfile.extend` shows how to use the images as the base for your own images.

Your concrete `Dockerfile` may need more statements, but the concept should be clear.

The compose file `example.yml` shows how to switch to another non-root user and how to set the VNC password and resolution.

### Building images

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
./builder.sh postman all
./builder.sh postman-chromium all
./builder.sh postman-firefox all
./builder.sh python all
./builder.sh python-chromium all
./builder.sh python-vscode all
./builder.sh python-vscode-chromium all
./builder.sh python-vscode-firefox all

### or skipping the publishing to the Docker Hub
./builder.sh nodejs all-no-push

### example of building and publishing a group of images
./ci-builder.sh all group nodejs-vscode-chromium postman-firefox python-vscode-chromium

### or all the images at once
./ci-builder.sh all group complete

### or skipping the publishing to the Docker Hub
./ci-builder.sh all-no-push group complete

### or all images featuring Chromium or Firefox
./ci-builder.sh all group complete-chromium
./ci-builder.sh all group complete-firefox

### or, for example, complete 'nodejs' or 'python' group
./ci-builder.sh all group complete-nodejs
./ci-builder.sh all group complete-python

### and so on
```

You can still execute the individual hook scripts as before (see the folder `/docker/hooks/`). However, the provided utilities `builder.sh` and `ci-builder.sh` are more convenient. Before pushing the images to the **Docker Hub** you have to prepare and source the file `secrets.rc` (see `example-secrets.rc`). The script `builder.sh` builds the individual images. The script `ci-builder.sh` can build various groups of images or all of them at once. Check the [builder-utility-readme][this-builder-readme], [local-building-example][this-readme-local-building-example] and [sibling Wiki][sibling-wiki] for more information.

### Sharing devices

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

## Project versions

This file describes the **third version** (G3v3) of the project, which however corresponds to the **fourth version** (G3v4) of the **sibling project** [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].

The **second version** (G3v2) and the **first version** (G3v1, or simply G3) will still be available in this GitHub repository as the branches `archived-generation-g3v2-ubuntu` and `archived-generation-g3v1`.

The version `G3v3` brings the following major changes comparing to the previous version `G3v2`:

- The updated startup scripts that support overriding the user ID (`id`) and group ID (`gid`) without needing the former build argument `ARG_FEATURES_USER_GROUP_OVERRIDE`, which has been removed.
- The user ID and the group ID can be overridden during the build time (`docker build`) and the run time (`docker run`).
- The `user name`, the `group name` and the `initial sudo password` can be overridden during the build time.
- The permissions of the files `/etc/passwd` and `/etc/groups` are set to the standard `644` after creating the user.
- The content of the home folder and the startup folder belongs to the created user.
- The created user gets permissions to use `sudo`. The initial `sudo` password is configurable during the build time using the build argument `ARG_SUDO_INITIAL_PW`. The password can be changed inside the container.
- The default `id:gid` has been changed from `1001:0` to `1000:1000`.
- Features `NOVNC` and `FIREFOX_PLUS`, that are enabled by default, can be disabled via environment variables.
- If `FEATURES_NOVNC="0"`, then
  - image will not include `noVNC`
  - image tag will get the `-vnc` suffix (e.g. `latest-vnc`, `20.04-firefox-vnc` etc.)
- If `FEATURES_FIREFOX_PLUS="0"` and `FEATURES_FIREFOX="1"`, then
  - image with Firefox will not include the *Firefox Plus features*
  - image tag will get the `-default` suffix (e.g. `latest-firefox-default` or also `latest-firefox-default-vnc` etc.)
- The images are based on `Debian 11` (formerly on `Ubuntu 20.04 LTS`).

The version `G3v2` has brought the following major changes comparing to the previous version `G3v1`:

- Significantly improved building performance by introducing a local cache (`g3-cache`).
- Auto-building on the **Docker Hub** and using of the **GitHub Actions** have been abandoned.
- The enhanced building pipeline moves towards building the images outside the **Docker Hub** and aims to support also stages with CI/CD capabilities (e.g. the **GitLab**).
- The **local stage** is the default building stage now. However, the new building pipeline has already been tested also with a local **GitLab** installation in a Docker container on a Linux machine.
- Automatic publishing of README files to the **Docker Hub** has been removed, because it was not working properly any more. However, the README files for the **Docker Hub** can still be prepared with the provided utility `util-readme.sh` and then copy-and-pasted to the **Docker Hub** manually.

The changes affect only the building pipeline, not the Docker images themselves. The `Dockerfile`, apart from using the new local `g3-cache`, stays conceptually unchanged.

You can learn more about the project generations in the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki].

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

<!-- this project -->

[this-docker]: https://hub.docker.com/u/accetto/

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md
[this-issues]: https://github.com/accetto/headless-coding-g3/issues

[this-dockerfile-nodejs]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.nodejs
[this-readme-image-nodejs]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-nodejs/README.md

[this-dockerfile-postman]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.postman
[this-readme-image-postman]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-postman/README.md

[this-dockerfile-python]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.python
[this-dockerfile-python-bonus-gui-frameworks]: https://github.com/accetto/headless-coding-g3/blob/bonus-images-python-gui-frameworks/docker/Dockerfile.xfce.python
[this-readme-image-python]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-python/README.md

[accetto-docker-debian-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nodejs-g3
[accetto-docker-debian-vnc-xfce-postman-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-postman-g3
[accetto-docker-debian-vnc-xfce-python-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-python-g3

[this-builder-readme]: https://github.com/accetto/headless-coding-g3/blob/master/readme-builder.md
[this-readme-local-building-example]: https://github.com/accetto/headless-coding-g3/blob/master/readme-local-building-example.md

<!-- diagrams -->

<!-- [this-diagram-dockerfile-stages-xfce]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.png -->
[this-diagram-dockerfile-stages-nodejs]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.nodejs.png
[this-diagram-dockerfile-stages-python]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.python.png
[this-diagram-dockerfile-stages-python-bonus]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.python-bonus.png
[this-diagram-dockerfile-stages-postman]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.postman.png

<!-- sibling project -->

[accetto-github-debian-vnc-xfce-g3]: https://github.com/accetto/debian-vnc-xfce-g3

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3/

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

<!-- Previous generations -->

[that-wiki-firefox-multiprocess]: https://github.com/accetto/xubuntu-vnc/wiki/Firefox-multiprocess

<!-- external links -->

[docker-debian]: https://hub.docker.com/_/debian/
[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
[debian-packages-search]: https://packages.debian.org/index

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[xfce]: http://www.xfce.org

<!-- github badges -->

<!-- [badge-github-workflow-dockerhub-autobuild]: https://github.com/accetto/headless-coding-g3/workflows/dockerhub-autobuild/badge.svg -->

<!-- [badge-github-workflow-dockerhub-post-push]: https://github.com/accetto/headless-coding-g3/workflows/dockerhub-post-push/badge.svg -->

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-coding-g3?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/headless-coding-g3?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/headless-coding-g3?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/headless-coding-g3?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/headless-coding-g3?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/headless-coding-g3?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/headless-coding-g3?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/headless-coding-g3?icon=github&label=open%20issues
