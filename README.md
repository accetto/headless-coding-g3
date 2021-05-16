# Headless Ubuntu/Xfce containers with VNC/noVNC for programming

## Project `accetto/headless-coding-g3`

### Branch: `bonus-images-python-gui-frameworks`

***

[Docker Hub][this-docker] - [Changelog][this-changelog] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]
![badge-github-stars][badge-github-stars]
![badge-github-forks][badge-github-forks]
![badge-github-open-issues][badge-github-open-issues]
![badge-github-closed-issues][badge-github-closed-issues]
![badge-github-releases][badge-github-releases]
![badge-github-commits][badge-github-commits]
![badge-github-last-commit][badge-github-last-commit]

![badge-github-workflow-dockerhub-autobuild][badge-github-workflow-dockerhub-autobuild]
![badge-github-workflow-dockerhub-post-push][badge-github-workflow-dockerhub-post-push]

***
**Attention:** This README file has been modified for the branch `bonus-images-python-gui-frameworks`.
***

This repository contains resources for building Docker images based on [Ubuntu 20.04 LTS][docker-ubuntu] with [Xfce][xfce] desktop environment and [VNC][tigervnc]/[noVNC][novnc] servers for headless use and selected applications for programming. Adding more tools requires usually only a single or just a few commands. The instructions are in the provided README files and some simple test applications are also already included.

All images can optionally include also the web browsers [Chromium][chromium] or [Firefox][firefox].

The resources for the individual images and their variations (tags) are stored in the subfolders of the **master** branch. Each image has its own README file describing its features and usage.

This is a sibling project to the project [accetto/ubuntu-vnc-xfce-g3][sibling-github], which contains the detailed description of the third generation (G3) of my Docker images. Please check the [sibling project README][sibling-readme] and the [sibling Wiki][sibling-wiki] for common information.

## TL;DR

The fastest way to build the images locally:

```shell
### PWD = project root
./docker/hooks/build dev python-vnc
./docker/hooks/build dev python-vnc-chromium
./docker/hooks/build dev python-vnc-vscode
./docker/hooks/build dev python-vnc-vscode-chromium
./docker/hooks/build dev python-vnc-novnc
./docker/hooks/build dev python-vnc-novnc-chromium
./docker/hooks/build dev python-vnc-novnc-vscode-chromium
./docker/hooks/build dev python-vnc-vscode-firefox
./docker/hooks/build dev python-vnc-vscode-firefox-plus
### and so on ...

### from the branch 'bonus-images-python-gui-frameworks'
./docker/hooks/build dev python-vnc-tkinter
./docker/hooks/build dev python-vnc-wxpython
./docker/hooks/build dev python-vnc-pyqt5
./docker/hooks/build dev python-vnc-pyside2
./docker/hooks/build dev python-vnc-pyside6
./docker/hooks/build dev python-vnc-kivy
./docker/hooks/build dev python-vnc-tkinter-vscode
./docker/hooks/build dev python-vnc-tkinter-vscode-chromium
./docker/hooks/build dev python-vnc-novnc-tkinter
### and so on ...
```

Find more in the hook script `env.rc` and in the [sibling Wiki][sibling-wiki].

## Bonus Python images

This branch contains resources for building the images that already include the popular `Python` GUI frameworks (see above).

## Issues, Wiki and Discussions

If you have found a problem or you just have a question, please check the [Issues][this-issues], the [sibling Issues][sibling-issues] and the [sibling Wiki][sibling-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

## Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

[this-docker]: https://hub.docker.com/u/accetto/

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md
[this-github]: https://github.com/accetto/headless-coding-g3/
[this-issues]: https://github.com/accetto/headless-coding-g3/issues

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions
[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
[sibling-issues]: https://github.com/accetto/ubuntu-vnc-xfce-g3/issues
[sibling-readme]: https://github.com/accetto/ubuntu-vnc-xfce-g3/blob/master/README.md
[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[accetto-docker-ubuntu-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[xfce]: http://www.xfce.org

<!-- github badges -->

[badge-github-workflow-dockerhub-autobuild]: https://github.com/accetto/headless-coding-g3/workflows/dockerhub-autobuild/badge.svg

[badge-github-workflow-dockerhub-post-push]: https://github.com/accetto/headless-coding-g3/workflows/dockerhub-post-push/badge.svg

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-coding-g3?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/headless-coding-g3?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/headless-coding-g3?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/headless-coding-g3?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/headless-coding-g3?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/headless-coding-g3?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/headless-coding-g3?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/headless-coding-g3?icon=github&label=open%20issues

<!-- Appendix -->
