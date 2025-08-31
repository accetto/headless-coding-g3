# Headless Debian/Xfce container with VNC/noVNC and Postman desktop app

## accetto/debian-vnc-xfce-postman-g3

[User Guide][this-user-guide] - [GitHub][this-github] - [Dockerfile][this-dockerfile] - [Readme][this-readme-full] - [Changelog][this-changelog]

<!-- markdownlint-disable MD038 MD052 -->
![badge-github-release][badge-github-release]` `
![badge-docker-pulls][badge-docker-pulls]` `
![badge-docker-stars][badge-docker-stars]

***

This Docker Hub repository contains Docker images for headless working with the [Postman][postman] desktop application.

The images are based on the current [Debian 13][docker-debian] and include [Xfce][xfce] desktop, [TigerVNC][tigervnc] server and [noVNC][novnc] client.

The popular web browsers [Brave][brave], [Chromium][chromium] or [Firefox][firefox] are also included.

Adding more tools like, for example, [Newman][newman] usually requires only a single or just a few commands. The instructions are in the [provided README file][this-readme-postman-newman].

This [User guide][this-user-guide] describes the images and how to use them.

The related [GitHub project][this-github] contains image generators that image users generally don’t need, unless they want to build the images themselves.

### Remarks

The Postman company has decided to remove the `Scratch Pad` from the `Postman App` as of May 15, 2023.

Therefore will these images always contain the `Postman App` version `10.13.6`, which is the last version still including the `Scratch Pad` and supporting off-line usage.

Note that you would need to block the `Postman App` from updating itself.

You can do it by blocking the auto-updater downloads by adding the following part to your compose configuration:

```yaml
extra_hosts:
    - "dl.pstmn.io=127.0.0.1"
```

Alternatively you can add the following line to the file `/etc/hosts` in the container:

```text
127.0.0.1   dl.pstmn.io
```

### Tags

The following image tags are regularly built and published on Docker Hub:
<!-- markdownlint-disable MD052 -->

- `latest` implements VNC and noVNC

    ![badge_latest_created][badge_latest_created]` `
    [![badge_latest_version-sticker][badge_latest_version-sticker]][link_latest_version-sticker-verbose]

- `brave` adds [Brave Browser][brave]

    ![badge_brave_created][badge_brave_created]` `
    [![badge_brave_version-sticker][badge_brave_version-sticker]][link_brave_version-sticker-verbose]

- `chromium` adds [Chromium Browser][chromium]

    ![badge_chromium_created][badge_chromium_created]` `
    [![badge_chromium_version-sticker][badge_chromium_version-sticker]][link_chromium_version-sticker-verbose]

- `firefox` adds [Firefox][firefox]

    ![badge_firefox_created][badge_firefox_created]` `
    [![badge_firefox_version-sticker][badge_firefox_version-sticker]][link_firefox_version-sticker-verbose]

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
- current version of [Brave Browser][brave] open-source web browser (official Brave distribution)
- current version of [Chromium Browser][chromium] open-source web browser (Debian distribution)
- current version of [Firefox ESR (Extended Support Release)][firefox] web browser and also the additional **Firefox plus** feature (see [User guide][this-user-guide-firefox-plus])
- [Postman App][postman] desktop application (version `10.13.6`, the last one still including `Scratch Pad`)

The following **TCP** ports are exposed by default:

- **5901** for access over **VNC** (using VNC viewer)
- **6901** for access over [noVNC][novnc] (using web browser)

![container-screenshot][this-screenshot-container]

This is the **third generation** (G3) of my headless images.
The **second generation** (G2) contains the GitHub repository [accetto/xubuntu-vnc-novnc][accetto-github-xubuntu-vnc-novnc].
The **first generation** (G1) contains the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

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

[this-readme-full]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-postman/README.md

[this-readme-postman-newman]: https://github.com/accetto/headless-coding-g3/blob/master/docker/xfce-postman/src/home/readme-postman-newman.md

[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki

[this-dockerfile]: https://github.com/accetto/headless-coding-g3/blob/master/docker/Dockerfile.xfce.postman

[this-screenshot-container]: https://raw.githubusercontent.com/accetto/headless-coding-g3/master/docker/doc/images/animation-headless-coding-postman-live.gif

[accetto-github-xubuntu-vnc-novnc]: https://github.com/accetto/xubuntu-vnc-novnc/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce

[docker-debian]: https://hub.docker.com/_/debian/

[brave]: https://www.brave.com/
[chromium]: https://www.chromium.org/Home
[curl]: http://manpages.ubuntu.com/manpages/bionic/man1/curl.1.html
[firefox]: https://www.mozilla.org
[git]: https://git-scm.com/
[jq]: https://stedolan.github.io/jq/
[mousepad]: https://github.com/codebrainz/mousepad
[nano]: https://www.nano-editor.org/
[newman]: https://github.com/postmanlabs/newman
[novnc]: https://github.com/kanaka/noVNC
[postman]: https://www.postman.com/downloads/
[sudo]: https://www.sudo.ws/
[tigervnc]: http://tigervnc.org
[tini]: https://github.com/krallin/tini
[xfce]: http://www.xfce.org

[badge-github-release]: https://img.shields.io/github/v/release/accetto/headless-coding-g3

[badge-docker-pulls]: https://img.shields.io/docker/pulls/accetto/debian-vnc-xfce-postman-g3

[badge-docker-stars]: https://img.shields.io/docker/stars/accetto/debian-vnc-xfce-postman-g3

<!-- Appendix will be added by util-readme.sh -->
