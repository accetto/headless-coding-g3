# Headless Debian/Xfce containers with VNC/noVNC for programming

## Project `accetto/headless-coding-g3`

Version: G3v6

***

[User Guide][this-user-guide] - [Docker Hub][this-docker] - [Changelog][this-changelog] - [sibling Wiki][sibling-wiki] - [sibling Discussions][sibling-discussions]

![badge-github-release][badge-github-release]
![badge-github-release-date][badge-github-release-date]
![badge-github-stars][badge-github-stars]
![badge-github-forks][badge-github-forks]
![badge-github-open-issues][badge-github-open-issues]
![badge-github-closed-issues][badge-github-closed-issues]
![badge-github-releases][badge-github-releases]
![badge-github-commits][badge-github-commits]
![badge-github-last-commit][badge-github-last-commit]

***

- [Headless Debian/Xfce containers with VNC/noVNC for programming](#headless-debianxfce-containers-with-vncnovnc-for-programming)
  - [Project `accetto/headless-coding-g3`](#project-accettoheadless-coding-g3)
    - [Introduction](#introduction)
    - [Building images](#building-images)
    - [Image generations](#image-generations)
    - [Project versions](#project-versions)
    - [Project goals](#project-goals)
    - [Project features](#project-features)
    - [Getting help](#getting-help)
    - [Credits](#credits)

### Introduction

This GitHub repository contains resources and tools for building Docker images for headless working.

The images are based on the current [Debian 12][docker-debian] and include [Xfce][xfce] desktop, [TigerVNC][tigervnc] server and [noVNC][novnc] client.
The popular web browsers [Chromium][chromium] and [Firefox][firefox] are also included.

This [User guide][this-user-guide] describes the images and how to use them.

The content of this GitHub project is intended for developers and image builders.

Ordinary users can simply use the images available in the following repositories on Docker Hub:

- [accetto/debian-vnc-xfce-nodejs-g3][accetto-docker-debian-vnc-xfce-nodejs-g3]
- [accetto/debian-vnc-xfce-nvm-g3][accetto-docker-debian-vnc-xfce-nvm-g3]
- [accetto/debian-vnc-xfce-postman-g3][accetto-docker-debian-vnc-xfce-postman-g3]
- [accetto/debian-vnc-xfce-python-g3][accetto-docker-debian-vnc-xfce-python-g3]
- [accetto/debian-vnc-xfce-vscode-g3][accetto-docker-debian-vnc-xfce-vscode-g3]

This is a sibling project to the project [accetto/debian-vnc-xfce-g3][accetto-github-debian-vnc-xfce-g3].

### Building images

You can execute the individual hook scripts in the folder [/docker/hooks/][this-folder-docker-hooks].
However, the provided utilities are more convenient.

The script [builder.sh][this-readme-builder] builds individual images.
The script [ci-builder.sh][this-readme-ci-builder] can build various groups of images or all of them at once.

Before building the images you have to prepare and source the file `secrets.rc` (see [example-secrets.rc][this-example-secrets-file]).

Features that are enabled by default can be explicitly disabled via environment variables.
This allows building even smaller images by excluding the individual features (e.g. noVNC).

The resources for building the individual images and their variations (tags) are in the subfolders of the [/docker/][this-folder-docker] folder.

The individual README files contain quick examples of building the images:

- [accetto/debian-vnc-xfce-nodejs-g3][this-readme-debian-vnc-xfce-nodejs-g3]
- [accetto/debian-vnc-xfce-nvm-g3][this-readme-debian-vnc-xfce-nvm-g3]
- [accetto/debian-vnc-xfce-postman-g3][this-readme-debian-vnc-xfce-postman-g3]
- [accetto/debian-vnc-xfce-python-g3][this-readme-debian-vnc-xfce-python-g3]
- [accetto/debian-vnc-xfce-vscode-g3][this-readme-debian-vnc-xfce-vscode-g3]

Each image also has a separate README file intended for Docker Hub.
The final files should be generated by the utility [util-readme.sh][this-readme-util-readme-examples] and then copied to Docker Hub manually.

The following resources describe the image building subject in details:

- [readme-local-building-example.md][this-readme-local-building-example]
- [readme-builder.md][this-readme-builder]
- [readme-ci-builder.md][this-readme-ci-builder]
- [readme-g3-cache.md][this-readme-g3-cache]
- [readme-util-readme-examples.md][this-readme-util-readme-examples]
- [sibling Wiki][sibling-wiki]

### Image generations

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

### Project versions

This file describes the **sixth version** (G3v6) of the project.

However, also this version keeps evolving.
Please check the [CHANGELOG][this-changelog] for more information about the changes.

The previous versions are still available in this **GitHub** repository as the branches named as `archived-generation-g3v{d}`.

*Remark*: The version number `G3v4` has been skipped, to align the numbering with the **sibling project** [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].

The main purpose of the version `G3v6` is to keep the project and the images uniform with the ones from the sibling `Ubuntu` projects.

The version `G3v5` has brought only one significant change comparing to the previous version `G3v3` and it also introduces the [portable Visual Studio Code][vscode-portable] installation.

- The updated script `set_user_permissions.sh`, which is part of Dockerfiles, skips the hidden files and directories now.
It generally should not have any unwanted side effects, but it may make a difference in some scenarios, hence the version increase.

The version `G3v3` has brought the following major changes comparing to the previous version `G3v2`:

- The updated startup scripts that support overriding the user ID (`id`) and group ID (`gid`) without needing the former build argument `ARG_FEATURES_USER_GROUP_OVERRIDE`, which has been removed.
- The user ID and the group ID can be overridden during the build time (`docker build`) and the run time (`docker run`).
- The `user name`, the `group name` and the `initial sudo password` can be overridden during the build time.
- The permissions of the files `/etc/passwd` and `/etc/groups` are set to the standard `644` after creating the user.
- The content of the home folder and the startup folder belongs to the created user.
- The created user gets permissions to use `sudo`.
The initial `sudo` password is configurable during the build time using the build argument `ARG_SUDO_INITIAL_PW`.
The password can be changed inside the container.
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
- The **local stage** is the default building stage now.
However, the new building pipeline has already been tested also with a local **GitLab** installation in a Docker container on a Linux machine.
- Automatic publishing of README files to the **Docker Hub** has been removed, because it was not working properly any more.
However, the README files for the **Docker Hub** can still be prepared with the provided utility `util-readme.sh` and then copy-and-pasted to the **Docker Hub** manually.

The changes affect only the building pipeline, not the Docker images themselves.
The `Dockerfile`, apart from using the new local `g3-cache`, stays conceptually unchanged.

Please refer to the [sibling project][accetto-github-ubuntu-vnc-xfce-g3_project-versions] to learn more about the older project versions.

### Project goals

Please refer to the [sibling project][accetto-github-ubuntu-vnc-xfce-g3_project-goals] to learn more about the project goals.

### Project features

Please refer to the [sibling project][accetto-github-ubuntu-vnc-xfce-g3_project-features] to learn more about the project features.

### Getting help

If you have found a problem or you just have a question, please check the [User guide][this-user-guide], [Issues][this-issues] and the [sibling Wiki][sibling-wiki] first.
Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue.
The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can use the [sibling Discussions][sibling-discussions].

### Credits

Credit goes to all the countless people and companies, who contribute to open source community and make so many dreamy things real.

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-docker]: https://hub.docker.com/u/accetto/

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md

[this-issues]: https://github.com/accetto/headless-coding-g3/issues

[this-folder-docker]: https://github.com/accetto/headless-coding-g3/tree/master/docker

[this-folder-docker-hooks]: https://github.com/accetto/headless-coding-g3/tree/master/docker/hooks

[this-example-secrets-file]: https://github.com/accetto/headless-coding-g3/blob/master/examples/example-secrets.rc

[this-readme-debian-vnc-xfce-nodejs-g3]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-nodejs/README.md

[this-readme-debian-vnc-xfce-nvm-g3]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-nvm/README.md

[this-readme-debian-vnc-xfce-postman-g3]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-postman/README.md

[this-readme-debian-vnc-xfce-python-g3]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-python/README.md

[this-readme-debian-vnc-xfce-vscode-g3]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-vscode/README.md

[this-readme-builder]: https://github.com/accetto/headless-coding-g3/blob/master/readme-builder.md

[this-readme-ci-builder]: https://github.com/accetto/headless-coding-g3/blob/master/readme-ci-builder.md

[this-readme-g3-cache]: https://github.com/accetto/headless-coding-g3/blob/master/readme-g3-cache.md

[this-readme-util-readme-examples]: https://github.com/accetto/headless-coding-g3/blob/master/utils/readme-util-readme-examples.md

[accetto-docker-debian-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nodejs-g3

[accetto-docker-debian-vnc-xfce-nvm-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nvm-g3

[accetto-docker-debian-vnc-xfce-postman-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-postman-g3

[accetto-docker-debian-vnc-xfce-python-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-python-g3

[accetto-docker-debian-vnc-xfce-vscode-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-vscode-g3

[this-readme-local-building-example]: https://github.com/accetto/headless-coding-g3/blob/master/readme-local-building-example.md

[accetto-github-debian-vnc-xfce-g3]: https://github.com/accetto/debian-vnc-xfce-g3

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3/

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[accetto-github-ubuntu-vnc-xfce-g3_project-versions]: https://github.com/accetto/ubuntu-vnc-xfce-g3#project-versions

[accetto-github-ubuntu-vnc-xfce-g3_project-goals]: https://github.com/accetto/ubuntu-vnc-xfce-g3#project-goals

[accetto-github-ubuntu-vnc-xfce-g3_project-features]: https://github.com/accetto/ubuntu-vnc-xfce-g3#changes-and-new-features

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-debian]: https://hub.docker.com/_/debian/

[chromium]: https://www.chromium.org/Home
[firefox]: https://www.mozilla.org
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[vscode-portable]: https://code.visualstudio.com/docs/editor/portable
[xfce]: http://www.xfce.org


[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-github-release-date]: https://img.shields.io/github/release-date/accetto/headless-coding-g3?logo=github

[badge-github-stars]: https://badgen.net/github/stars/accetto/headless-coding-g3?icon=github&label=stars

[badge-github-forks]: https://badgen.net/github/forks/accetto/headless-coding-g3?icon=github&label=forks

[badge-github-releases]: https://badgen.net/github/releases/accetto/headless-coding-g3?icon=github&label=releases

[badge-github-commits]: https://badgen.net/github/commits/accetto/headless-coding-g3?icon=github&label=commits

[badge-github-last-commit]: https://badgen.net/github/last-commit/accetto/headless-coding-g3?icon=github&label=last%20commit

[badge-github-closed-issues]: https://badgen.net/github/closed-issues/accetto/headless-coding-g3?icon=github&label=closed%20issues

[badge-github-open-issues]: https://badgen.net/github/open-issues/accetto/headless-coding-g3?icon=github&label=open%20issues
