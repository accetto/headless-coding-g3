# Headless Debian/Xfce container with VNC/noVNC for `Python` development

## accetto/debian-vnc-xfce-python-g3

[User Guide][this-user-guide] - [GitHub][this-github] - [Dockerfile][this-dockerfile] - [Readme][this-readme-full] - [Changelog][this-changelog]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]

***

This Docker Hub repository contains Docker images for headless working with the popular programming language [Python][python] and its package installer [pip][pip].

The images are based on the current [Debian 12][docker-debian] and include [Xfce][xfce] desktop, [TigerVNC][tigervnc] server and [noVNC][novnc] client.

The free open-source programming editor [Visual Studio Code][vscode] in [portable installation][vscode-portable] and the popular web browsers [Chromium][chromium] or [Firefox][firefox] are also included.

Adding more tools like, for example, the most popular Python GUI frameworks [TKinter][tkinter], [PyQt5][pyqt5], [PyQT for Python][pyside] (`PySide2` or `PySide6`), [wxPython][wxpython] or [Kivy][kivy] usually requires only a single or just a few commands.
The instructions are in the provided README files and some simple test applications are also already included.

This [User guide][this-user-guide] describes the images and how to use them.

The related [GitHub project][this-github] contains image generators that image users generally don’t need, unless they want to build the images themselves.

### Tags

The following image tags are regularly built and published on Docker Hub:

<!-- markdownlint-disable MD052 -->

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `chromium` adds only [Chromium Browser][chromium]

    ![badge_chromium_created][badge_chromium_created]
    [![badge_chromium_version-sticker][badge_chromium_version-sticker]][link_chromium_version-sticker-verbose]

- `vscode` adds [portable][vscode-portable] [Visual Studio Code][vscode]

    ![badge_vscode_created][badge_vscode_created]
    [![badge_vscode_version-sticker][badge_vscode_version-sticker]][link_vscode_version-sticker-verbose]

- `vscode-chromium` adds [portable][vscode-portable] [Visual Studio Code][vscode] and [Chromium Browser][chromium]

    ![badge_vscode-chromium_created][badge_vscode-chromium_created]
    [![badge_vscode-chromium_version-sticker][badge_vscode-chromium_version-sticker]][link_vscode-chromium_version-sticker-verbose]

- `vscode-firefox` adds [portable][vscode-portable] [Visual Studio Code][vscode] and [Firefox][firefox]

    ![badge_vscode-firefox_created][badge_vscode-firefox_created]
    [![badge_vscode-firefox_version-sticker][badge_vscode-firefox_version-sticker]][link_vscode-firefox_version-sticker-verbose]

**Hint:** Clicking the version sticker badge reveals more information about the particular build.

### Features

The main features and components of the images in the default configuration are:

- lightweight [Xfce][xfce] desktop environment (Debian distribution)
- [sudo][sudo] support
- utilities [curl][curl] and [git][git] (Debian distribution)
- current version of JSON processor [jq][jq]
- current version of high-performance [TigerVNC][tigervnc] server and client
- current version of [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [nano][nano] (Debian distribution)
- lite but advanced graphical editor [mousepad][mousepad] (Debian distribution)
- current version of [tini][tini] as the entry-point initial process (PID 1)
- support for overriding environment variables, VNC parameters, user and group (see [User guide][this-user-guide-using-containers])
- support of **version sticker** (see [User guide][this-user-guide-version-sticker])
- current version of [Chromium Browser][chromium] open-source web browser (Debian distribution)
- current version of [Firefox ESR (Extended Support Release)][firefox] web browser and also the additional **Firefox plus** feature (see [User guide][this-user-guide-firefox-plus])
- programming language [Python][python] with [pip][pip] package installer (Debian distribution)
- current version of free open-source programming editor [Visual Studio Code][vscode] in [portable installation][vscode-portable]

The following **TCP** ports are exposed by default:

- **5901** for access over **VNC** (using VNC viewer)
- **6901** for access over [noVNC][novnc] (using web browser)

![container-screenshot][this-screenshot-container]

### Remarks

The related [GitHub project][this-github] contains also the branch `bonus-images-python-gui-frameworks`, which allows building images already including the most popular Python GUI frameworks (see above).
Those images could be occasionally pushed to Docker Hub, but there will be no effort to do it regularly.
However, you can built them yourself.

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

Note that the portable `Visual Studio Code` does not support automatic updates.
However, manual updating is really easy.
Visit the official [Portable Mode][vscode-portable] page for more information.

Alternatively you can pull or build an updated `accetto` image containing the new `Visual Studio Code` version.

### Getting help

If you've found a problem or you just have a question, please check the [User guide][this-user-guide], [Issues][this-issues] and [sibling Wiki][sibling-wiki] first.
Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue.
The better you describe the problem, the bigger the chance it'll be solved soon.

If you have a question or an idea and you don't want to open an issue, you can also use the [sibling Discussions][sibling-discussions].

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-user-guide-version-sticker]: https://accetto.github.io/user-guide-g3/version-sticker/

[this-user-guide-using-containers]: https://accetto.github.io/user-guide-g3/using-containers/

[this-user-guide-firefox-plus]: https://accetto.github.io/user-guide-g3/firefox-plus/

[this-changelog]: https://github.com/accetto/headless-coding-g3/blob/master/CHANGELOG.md

[this-github]: https://github.com/accetto/headless-coding-g3/

[this-issues]: https://github.com/accetto/headless-coding-g3/issues

[this-readme-full]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-python/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.python

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/animation-headless-coding-python-live.gif

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/
[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-debian]: https://hub.docker.com/_/debian/

[chromium]: https://www.chromium.org/Home
[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
[firefox]: https://www.mozilla.org
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
[sudo]: https://www.sudo.ws/
[tigervnc]: http://tigervnc.org
[tini]: https://github.com/krallin/tini
[tkinter]: https://wiki.python.org/moin/TkInter
[vscode]: https://code.visualstudio.com/
[vscode-portable]: https://code.visualstudio.com/docs/editor/portable
[wxpython]: https://wxpython.org/
[xfce]: http://www.xfce.org

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/debian-vnc-xfce-python-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/debian-vnc-xfce-python-g3?icon=docker&label=stars

<!-- Appendix will be added by util-readme.sh -->
