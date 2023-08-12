# Headless Debian/Xfce container with VNC/noVNC for `Node.js` development

## accetto/debian-vnc-xfce-nodejs-g3

[User Guide][this-user-guide] - [Docker Hub][this-docker] - [Dockerfile][this-dockerfile] - [Readme][this-readme] - [Changelog][this-changelog]

***

This GitHub project folder contains resources used by building Debian images available on Docker Hub in the repository [accetto/debian-vnc-xfce-nodejs-g3][this-docker].

This [User guide][this-user-guide] describes the images and how to use them.

### Building images

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

Refer to the main [README][this-readme] file for more information about the building subject.

### Remarks

This is a sibling project to the project [accetto/debian-vnc-xfce-g3][accetto-github-debian-vnc-xfce-g3].

There is also another sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] containing images based on [Ubuntu 22.04 LTS and 20.04 LTS][docker-ubuntu].

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

### Getting help

If you've found a problem or you just have a question, please check the [User guide][this-user-guide], [Issues][this-issues] and [sibling Wiki][sibling-wiki] first.
Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue.
The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can also use the [sibling Discussions][sibling-discussions].

### Diagrams

Diagram of the multi-staged Dockerfile used for building multiple images.

The actual content of a particular image build is controlled by the *feature variables*.

![Dockerfile.xfce.nodejs stages][this-diagram-dockerfile-stages-nodejs]

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-readme]: https://github.com/accetto/headless-coding-g3/blob/master/README.md

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md

[this-issues]: https://github.com/accetto/headless-coding-g3/issues

[accetto-github-debian-vnc-xfce-g3]: https://github.com/accetto/debian-vnc-xfce-g3

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-docker]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nodejs-g3/

[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.nodejs

[this-diagram-dockerfile-stages-nodejs]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/Dockerfile.xfce.nodejs.png

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
