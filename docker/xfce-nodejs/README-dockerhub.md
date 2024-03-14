# Headless Debian/Xfce container with VNC/noVNC for `Node.js` development

## accetto/debian-vnc-xfce-nodejs-g3

[User Guide][this-user-guide] - [GitHub][this-github] - [Dockerfile][this-dockerfile] - [Readme][this-readme-full] - [Changelog][this-changelog]

![badge-docker-pulls][badge-docker-pulls]
![badge-docker-stars][badge-docker-stars]
![badge-github-release][badge-github-release]

***

This Docker Hub repository contains Docker images for headless working with the free open-source JavaScript runtime environment [Node.js][nodejs] and its package installer [npm][npm].

The images are based on the current [Debian 12][docker-debian] and include [Xfce][xfce] desktop, [TigerVNC][tigervnc] server and [noVNC][novnc] client.

The free open-source programming editor [Visual Studio Code][vscode] in [portable installation][vscode-portable] and the popular web browsers [Chromium][chromium] or [Firefox][firefox] are also included.

Adding more tools like [TypeScript][typescript], [Angular][angular] or [Electron][electron] usually requires only a single or just a few commands.
The instructions are in the provided README files and some simple test applications are also already included.

This [User guide][this-user-guide] describes the images and how to use them.

The related [GitHub project][this-github] contains image generators that image users generally don’t need, unless they want to build the images themselves.

### Sharing Visual Studio Code profiles

You can share *portable* `Visual Studio Code` profiles using *volumes* if you build your `compose` file similar to this:

```yaml
volumes:
  ### The volume should be prepared beforehand, otherwise
  ### it would be removed with the service.
  some-shared-vscode-profile-volume:
    external: true

services:
  some-vscode-service:
    ....
    volumes:
      - type: volume
        source: some-shared-vscode-profile-volume:
        target: /home/headless/.vscode-portable/code/data/user-data/User
      - type: volume
        source: some-shared-vscode-profile-volume:
        target: /home/headless/.vscode-portable/code/data/extensions
```

Be aware, that if you don't prepare the volume beforehand, it will be removed with the service.
Read more about [Docker volumes][doc-docker-volumes] and [Compose volumes][doc-compose-volumes] in the official documentation.

### Tags

The following image tags are regularly built and published on Docker Hub:

<!-- markdownlint-disable MD052 -->

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `chromium` adds [Chromium Browser][chromium]

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

- `current` with [Node.js][nodejs] `Current`, implements VNC and noVNC

    ![badge_current_created][badge_current_created]
    [![badge_current_version-sticker][badge_current_version-sticker]][link_current_version-sticker-verbose]

<!-- markdownlint-enable MD052 -->

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
- current version of free open-source JavaScript runtime environment [Node.js][nodejs] with [npm][npm] (`LTS` or `current`)
- current version of free open-source programming editor [Visual Studio Code][vscode] in [portable installation][vscode-portable]

The following **TCP** ports are exposed by default:

- **5901** for access over **VNC** (using VNC viewer)
- **6901** for access over [noVNC][novnc] (using web browser)

![container-screenshot][this-screenshot-container]

### Remarks

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

[this-readme-full]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-nodejs/README.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.nodejs

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/animation-headless-coding-nodejs-live.gif

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-debian]: https://hub.docker.com/_/debian/

[doc-docker-volumes]: https://docs.docker.com/storage/volumes/
[doc-compose-volumes]: https://docs.docker.com/compose/compose-file/07-volumes/

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
[sudo]: https://www.sudo.ws/
[tigervnc]: http://tigervnc.org
[tini]: https://github.com/krallin/tini
[typescript]: https://www.typescriptlang.org/
[vscode]: https://code.visualstudio.com/
[vscode-portable]: https://code.visualstudio.com/docs/editor/portable
[xfce]: http://www.xfce.org

[badge-github-release]: https://badgen.net/github/release/accetto/headless-coding-g3?icon=github&label=release

[badge-docker-pulls]: https://badgen.net/docker/pulls/accetto/debian-vnc-xfce-nodejs-g3?icon=docker&label=pulls

[badge-docker-stars]: https://badgen.net/docker/stars/accetto/debian-vnc-xfce-nodejs-g3?icon=docker&label=stars

<!-- Appendix will be added by util-readme.sh -->
