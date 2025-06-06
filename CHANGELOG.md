# CHANGELOG

## Project `accetto/headless-coding-g3`

[User Guide][this-user-guide] - [Docker Hub][this-docker] - [Git Hub][this-github] - [sibling Wiki][sibling-wiki] - [sibling Discussions][sibling-discussions]

***

### Release 25.05.1

This is a maintenance release.

- Fixed a bug in the `cache` hook script.

Updated versions:

- `TigerVNC` to version **1.15.0**
  - avoid using an empty VNC password (environment variable `VNC_PW`) with this version

### Release 25.05 (G3v8)

This is the first `G3v8` release.
It fixes the badge service problem and brings some improvements in the building pipeline and utilities.
There are also updates and fixes of several [sibling Wiki][sibling-wiki] pages.

The service **Badgen.net**, which was unreachable for some time already, has been replaced by the service [Shields.io][service-shields-io].

Consequently, all README files of all `accetto` [Generation 3][dashboard-dockerhub] repositories on the **Docker Hub**  had to be updated.

This is what you need to do in such case:

- Update all project files named `readme-append.template`
  - Replace the string `https://badgen.net/https/gist.` by the string `https://img.shields.io/endpoint?url=https://gist.`
  
- Use the utility script `util-readme.sh` from the project folder `/util` to generate the files `scrap-readme.md` for each repository.
The file `readme-util-readme-examples.md` describes the utility.

- Copy the content of the `scrap-readme.md` to the description page of the related repository on the **Docker Hub**.

  Note that you have to process the repositories one-by-one, because the same output file `scrap-readme.md` is overwritten each time the utility script is executed.

#### Changes in the building pipeline and utilities

- The updated hook script `post_push`, which updates the `deployment gists` on the **GitHub**, now extracts the badge values ad-hoc from the locally available images. Those can be just built locally or also pulled from the **Docker Hub**. There is no need to re-build them and to go through the `pre_build` phase just for updating the deployment gists. This change allows refreshing the gists using the "historical" data extracted from the previously published images.

- The actual gist update is implemented in the supporting hook script `util.rc`. The addition of up to 3 automatic retries has made the updating more reliable.

*Just a reminder:* Deployment gists are publicly accessible files on the **GitHub**, that contain values used for generating the badges for the README files, that are published on the **Docker Hub**.

The new functionality is available through the updated utility scripts `ci-builder.sh`, which has got the following new commands:

- `list`
- `pull`
- `update-gists`
- `helper-help`

The added hook script `helper` supports the new commands.

The updated utility `ci-builder.sh`can now accept also the Debian version numbers as the blend values. For example, `12` instead of `latest` or `bookworm`, `11` instead of `bullseye`.

Please check the file `readme-ci-builder.md` for more description.

The updated hook script `cache` checks if the shared `g3-cache` directory, which is defined by the environment variable `SHARED_G3_CACHE_PATH`, is reachable and writable.
The shared `g3-cache` update will be skipped otherwise.

#### Fixes

The hook script `pre_build` removes the helper images if there will be no `build` script call.
It's then, when the helper temporary file `scrap-demand-stop-building` is present.

### Release 25.04

Availability checking of the `wget` utility has been added.
The utility is used by the `cache` hook script for downloading of selected packages into the `g3-cache` folders.
It's generally not available on Windows environments by default.
You can install it or to build on an environment, where the utility is available (e.g. WSL or Linux).

The checking can be skipped by setting the environment variable `IGNORE_MISSING_WGET=1`.

The selected packages still will be downloaded into a temporary image layer, but not into the project's
`.g3-cache` folder nor the shared one, defined by the variable `SHARED_G3_CACHE_PATH`.

Other changes:

- The `ci-builder.sh` script's command `log get errors` now lists building errors and also warnings.

Updated components:

- `noVNC` to version **1.6.0**
- `websockify` to version **0.13.0**

### Release 25.03 (G3v7)

This is the first `G3v7` release, bringing an improved building pipeline.

The helper script `ci-builder.sh` can build final images significantly faster, because the temporary helper images are used as external caches.

Internally, the helper image is built by the `pre_build` hook script and then used by the `build` hook script.

The helper image is now deleted by the `build` hook script and not the `pre_build` hook script as before.

The `Dockerfiles` got a new metadata label `any.accetto.built-by="docker"`.

#### Remarks

If you would build a final image without building also the helper image (e.g. by executing `builder.sh latest build`), then there could be an error message about trying to remove the non-existing helper image.
You can safely ignore the message.

For example:

```shell
### The next line would build the helper image, but it was not executed.
#./build.sh latest pre_build

./build.sh latest build

### then somewhere near the end of the log
Removing helper image
Error response from daemon: No such image: accetto/devops-headless-coding-g3_nvm-helper:latest
```

### Release 25.01

This is a maintenance release.

Updated components:

- `noVNC` to version **1.5.0**
- `websockify` to version **0.12.0**

#### Remarks about `xfce4-about`

The version of the currently running `Xfce4` can be checked by the utility `xfce4-about`.
It can be executed from the terminal window or by the start menu item `Applications/About Xfce`.

However, the utility requires the module `libGL.so.1`, which is excluded from some images, to keep them smaller.

The module can be added in running containers as follows:

```shell
sudo apt-get update
sudo install libgl1
```

### Release 24.09.1

This is a fix release, finishing the changes announced in the previous release.

Changes:

- Default user `headless:headless (1000:1000)` has been changed to `headless:headless (1001:1001)`.
  - This change has been only done to keep the containers uniform with the ones from the sibling `Ubuntu` projects.

### Release 24.09 (G3v6)

This is the first `G3v6` release.
However, it's a maintenance release and the version number has been increased just to keep it synchronized with the **sibling project** [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].
The previous version `G3v5` will still be available in this repository as the branch `archived-generation-g3v5`.

Changes:

- **[Sorry, this one change actually comes in the next release.]** - Default user `headless:headless (1000:1000)` has been changed to `headless:headless (1001:1001)`.
  - This change has been only done to keep the containers uniform with the ones from the sibling `Ubuntu` projects.
- The directive `syntax=docker/dockerfile:experimental` has been removed from all Dockerfiles.
- The `noVNC` starting page has been updated in all images.
  - If no `noVNC Client` is selected, then the `Full Client` will start automatically in 10 seconds.
- The hook script `release_of` has been updated with the intention to report more helpful building errors.

### Release 24.03.1

This is a fix release, correcting an unfortunate copy-and-paste error in the files `Dockerfile.xfce.nodejs`, `Dockerfile.xfce.nvm` and `Dockerfile.xfce.python`.

Other changes:

- Readme files for Docker Hub have got a new section `Sharing Visual Studio Code profiles`

### Release 24.03 (G3v5)

This is the first `G3v5` release.
It also introduces the [portable Visual Studio Code][vscode-portable] installation.

*Remark*: The version number `G3v4` has been skipped, to align the numbering with the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].

The updated script `set_user_permissions.sh`, which is part of Dockerfiles, skips the hidden files and directories now.
It generally should not have any unwanted side effects, but it may make a difference in some scenarios, hence the version increase.

The default `Visual Studio Code` installation path is `$HOME/.vscode-portable/code` and it can be changed by setting the build argument `ARG_VSCODE_PATH`.

By setting the build argument `ARG_VSCODE_VERSION` it's possible to install a particular `Visual Studio Code` version.

The complete `Visual Studio Code` profile is by default in the folder `$HOME/.vscode-portable/code/data`.

Note that the portable `Visual Studio Code` does not support automatic updates.
However, manual updating is really easy.
Visit the official [Portable Mode][vscode-portable] page for more information.

Alternatively you can pull or build an updated `accetto` image containing the new `Visual Studio Code` version.

### Release 23.12

This release brings new images containing the free open-source utility `NVM` (Node Version Manager), which allows installing and using multiple `Node.js` versions concurrently. No `Node.js` version is installed by default.

They can be pulled from the repository [accetto/debian-vnc-xfce-nvm-g3][accetto-debian-vnc-xfce-nvm-g3] on Docker Hub.

The images are meant as a more flexible alternative to the ones from the repository [accetto/debian-vnc-xfce-nodejs-g3][accetto-debian-vnc-xfce-nodejs-g3], that contain particular `Node.js` versions.
Publishing those images will be phased out, but you can always build them yourself using the GitHub project.

Changes:

- resources for building the new `NVM` images have been added
- new `NVM` related blends have been added
  - `nvm`, `nvm-chromium`, `nvm-vscode`, `nvm-vscode-chromium`, `nvm-vscode-firefox`
- new Dockerfile `Dockerfile.xfce.nvm` has been added
- hook scripts in the folder `docker/hooks/` have been updated
- version discovery in the hook script `release_of` has been improved
  - `nvm` key has been added
  - processing of keys `nodejs-lts` and `nodejs-current` has been improved (fixed)
- scripts `version_of.sh` and `version_sticker.sh` have been updated
- embedded help in builder scripts `builder.sh` and `ci-builder.sh` has been updated
- building groups in the script `ci-builder.sh` have been updated
  - `NVM` related blends have been added
  - `Node.js` and `Postman` related blends have been removed from the named groups `pivotal`, `complete`, `complete-chromium`, `complete-firefox` and `complete-vscode`
    - `Node.js` and `Postman` blends should be build/published explicitly
- building related README files have been updated
- stage diagram `Dockerfile.xfce.nvm.png` has been added

Other changes:

- Updated all Dockerfiles
  - file `.bashrc` is created earlier (stage `merge_stage_vnc`)
- Updated file `example-secrets.rc`
  - removed the initialization of the variables `FORCE_BUILDING` and `FORCE_PUBLISHING_BUILDER_REPO` (unset means `0`)
  - the variables are still used as before, but now they can be set individually for each building/publishing run

### Release 23.11.1

Added more 'die-fast' error handling into the building and publishing scripts.
They exit immediately if the image building or pushing commands fail.

### Release 23.11

Improved `Node.js` images:

- global `npm` modules are installed into the folder `$HOME/$NPM_GLOBAL_MODULES`
- default folder name is `.node_modules_global`
- the folder is owned by the container user

Other changes:

- file `$HOME/.bashrc` added to all images
  - it contains examples of custom aliases
    - `ll` - just `ls -l`
    - `cls` - clears the terminal window
    - `ps1` - sets the command prompt text

### Release 23.09

This is a maintenance release fixing the  `nodejs-current` publishing problem.

### Release 23.08.1 (Milestone)

This release brings new images based on the current **Debian 12**.

Main changes:

- hook scripts `env.rc`, `push` and `post_push` have been updated
- handling of multiple deployment tags per image has been improved and it covers also publishing into the builder repository now
  - also less image pollution by publishing
- file `readme-local-building-example.md` got a new section `Tips and examples`, containing
  - `How to deploy all images into one repository`
- script `ci-builder.sh` has been updated
  - `postman` has been removed from the `pivotal` group
  - group `complete` has been re-ordered

Main updated components:

- `Debian` to version **12.1**
- `Xfce` desktop to version **4.18**
- `Mousepad` to version **0.5.10**
- `nano` to version **7.2**
- `Python` to version **3.11.2**

Images with `Postman` still include the version **10.13.6**, because it's the last version containing `Scratch Pad`.
You can update `Postman` to the latest version in the running container, if you don't mind loosing the `Scratch Pad.`

### Release 23.08

This release brings updated and significantly shortened README files, because most of the content has been moved into the new [User guide][this-user-guide].

### Release 23.07.1

This release brings some enhancements in the Dockerfiles and the script `user_generator.rc` with the aim to better support extending the images.

### Release 23.07

This release introduces a new feature `FEATURES_OVERRIDING_ENVV`, which controls the overriding or adding of environment variables at the container startup-time.
Meaning, after the container has already been created.

The feature is enabled by default.
It can be disabled by setting the variable `FEATURES_OVERRIDING_ENVV` to zero when the container is created or the image is built.
Be aware that any other value than zero, even if unset or empty, enables the feature.

If `FEATURES_OVERRIDING_ENVV=1`, then the container startup script will look for the file `$HOME/.override/.override_envv.rc` and source all the lines that begin with the string 'export ' at the first position and contain the '=' character.

The overriding file can be provided from outside the container using *bind mounts* or *volumes*.

The lines that have been actually sourced can be reported into the container's log if the startup parameter `--verbose` or `--debug` is provided.

This feature is an enhanced implementation of the previously available functionality known as **Overriding VNC/noVNC parameters at the container startup-time**.

Therefore this is a **breaking change** for the users that already use the VNC/noVNC overriding.
They need to move the content from the previous file `$HOME"/.vnc_override.rc` into the new file `$HOME/.override/.override_envv.rc`.

Other changes:

- Script `ci-builder.sh`
  - group `complete-vscode` has been split into two groups
    - `complete-vscode-all` is the same as the former `complete-vscode` group and it includes all images that contain Visual Studio Code
    - `complete-vscode` includes only the `accetto/debian-vnc-xfce-vscode-g3` images

### Release 23.06 (Milestone)

The Postman company has decided to remove `Scratch Pad` from `Postman App` as of May 15, 2023. Therefore will `Postman` images from now on always include the version `10.13.6`, the last one that still contains `Scratch Pad`.

**Important for builders**: Downloading `Postman` is prohibited. The file `postman-10.13.6-linux-x64.tar.gz` must be put into `g3-cache`.

Fixes:

- `Node.js`: Failing building because the version detection code needed adjustments.

Main changes:

- `hooks/release_of`: Node.js version detection code has been adjusted
- `hooks/cache`, `Dockerfile.xfce.postman`: Postman downloading is prohibited, `g3-cache` must be used.
- Postman image README files updated

### Release 23.04

Added a new image [accetto/debian-vnc-xfce-vscode-g3][accetto-debian-vnc-xfce-vscode-g3].

### Release 23.03.2

This release mitigates the problems with the edge use case, when users bind the whole `$HOME` directory to an external folder on the host computer.

Please note that I recommend to avoid doing that. If you really want to, then your best bet is using the Docker volumes. That is the only option I've found, which works across the environments. In the sibling discussion thread [#39](https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions/39) I've described the way, how to initialize a bound `$HOME` folder, if you really want to give it a try.

Main changes:

- file `.initial_sudo_password` has been moved from the `$HOME` to the `$STARTUPDIR` folder
- file `.initial_sudo_password` is not deleted, but cleared after the container user is created
- startup scripts have been adjusted and improved
- readme files have been updated

### Release 23.03.1

This is a maintenance release aiming to improve the scripts and documentation.

### Release 23.03

- updated with `TigerVNC 1.13.1` bugfix release
- also some updates in readme files

### Release 23.02 (G3v3)

This is the first `G3v3` release, switching the images from `Ubuntu 20.04 LTS` to `Debian 11` and introducing the updated startup scripts. The previous version `G3v2` will still be available in this repository as the branch `archived-generation-g3v2-ubuntu`.

This release corresponds to the version `G3v4` of the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] (as of the release `23.02.1`).

The updated startup scripts that support overriding the user ID (`id`) and group ID (`gid`) without needing the former build argument `ARG_FEATURES_USER_GROUP_OVERRIDE`, which has been removed.

- The user ID and the group ID can be overridden during the build time (`docker build`) and the run time (`docker run`).
- The `user name`, the `group name` and the `initial sudo password` can be overridden during the build time.
- The permissions of the files `/etc/passwd` and `/etc/groups` are set to the standard `644` after creating the user.
- The content of the home folder and the startup folder belongs to the created user.
- The created user gets permissions to use `sudo`. The initial `sudo` password is configurable during the build time using the build argument `ARG_SUDO_INITIAL_PW`. The password can be changed inside the container.
- The default `id:gid` has been changed from `1001:0` to `1000:1000`.

Features `NOVNC` and `FIREFOX_PLUS`, that are enabled by default, can be disabled via environment variables:

- If `FEATURES_NOVNC="0"`, then
  - image will not include `noVNC`
  - image tag will get the `-vnc` suffix (e.g. `latest-vnc`, `20.04-firefox-vnc` etc.)
- If `FEATURES_FIREFOX_PLUS="0"` and `FEATURES_FIREFOX="1"`, then
  - image with Firefox will not include the *Firefox Plus features*
  - image tag will get the `-default` suffix (e.g. `latest-firefox-default` or also `latest-firefox-default-vnc` etc.)

Changes in build arguments:

- removed `ARG_FEATURES_USER_GROUP_OVERRIDE`
- renamed `ARG_SUDO_PW` to `ARG_SUDO_INITIAL_PW`
- added `ARG_HEADLESS_USER_ID`, `ARG_HEADLESS_USER_NAME`, `ARG_HEADLESS_USER_GROUP_ID` and `ARG_HEADLESS_USER_GROUP_NAME`

Changes in environment variables:

- removed `FEATURES_USER_GROUP_OVERRIDE`
- added `HEADLESS_USER_ID`, `HEADLESS_USER_NAME`, `HEADLESS_USER_GROUP_ID` and `HEADLESS_USER_GROUP_NAME`

Main changes in files:

- updated `Dockerfile.xfce.nodejs`, `Dockerfile.xfce.postman` and `Dockerfile.xfce.python`
- updated `startup.sh`, `user_generator.rc` and `set_user_permissions.sh`
- updated hook scripts `env.rc`, `build`, `pre_build` and `util.rc`
- added `tests/test-01.sh` allows to quickly check the current permissions

Updated versions:

- **TigerVNC** to version `1.13.0`
- **noVNC** to version `1.4.0`

### Release 22.12.1

This is the last `G3v2` release with the images based on `Ubuntu 20.04 LTS`.

- Updated components:

  - **websockify** to version **0.11.0**

### Release 22.12

This is a maintenance release.

- README files have been updated
- Folder `examples/` has been moved up to the project's root folder
  - New example `Dockerfile.extended` shows how to use the images as the base of new images
  - New compose file `example.yml` shows how to switch to another non-root user and how to set the VNC password and resolution

### Release 22.11.1

This is a quick fix release, because `Chromium Browser` has changed its package naming pattern.

### Release 22.11 (G3v2)

This is a milestone release. It's the first release of the new building pipeline version `G3v2`. The previous version `G3v1` will still be available in this repository as the branch `archived-generation-g3v1`.

The version `G3v2` brings the following major changes:

- Significantly improved building performance by introducing a local cache (`g3-cache`).
- Auto-building on the **Docker Hub** and using of the **GitHub Actions** have been abandoned.
- The enhanced building pipeline moves towards building the images outside the **Docker Hub** and aims to support also stages with CI/CD capabilities (e.g. **GitLab**).
- The **local stage** is the default building stage. The new building pipeline has already been tested also with a local **GitLab** installation in a Docker container on a Linux machine.
- Automatic publishing of README files to the **Docker Hub** has been removed, because it hasn't work properly any more. However, the README files can be still prepared with the provided utility and then copy-and-pasted to the **Docker Hub** manually.

Added files:

- `docker/hooks/cache`
- `ci-builder.sh`
- `readme-builder.md`
- `readme-ci-builder.md`
- `readme-g3-cache.md`
- `readme-local-building-example.md`
- `utils/readme-util-readme-examples.md`

Removed files:

- `local-builder-readme.md`
- `local-building-example.md`
- `utils/example-secrets-utils.rc`
- `utils/examples-util-readme.md`
- `.github/workflows/dockerhub-autobuild.yml`
- `.github/workflows/dockerhub-post-push.yml`
- `.github/workflows/deploy-readme.sh`

Many other files have been updated, some of them significantly.

Hoverer, the changes affect only the building pipeline, not the Docker images themselves. The `Dockerfile`, apart from using the new local `g3-cache`, stays conceptually unchanged.

### Release 22.10 (G3v1)

This is the last release of the current building pipeline generation `G3v1`, which will still be available in the repository as the branch `archived-generation-g3v1`.

The next milestone release will bring some significant changes and improvements in the building pipeline (generation `G3v2`) . The changing parts marked as `DEPRECATED` will be replaced or removed.

### Release 22.09

This is just a maintenance release.

- Warnings about the *README publishing not always working* problem have been added.
- Some comments have been updated.

### Release 22.07

- xfce-nodejs
  - updated the `package.json` file of the sample `electron-test-app` to satisfy the Dependabot alerts

### Release 22.04

- **noVNC** improvements

  - **noVNC** got a new optional argument, which is passed through a new environment variable **NOVNC_HEARTBEAT**
  
    - set the variable by creating the container, like `docker run -e NOVNC_HEARTBEAT=30` for the ping interval 30 seconds
    - it should prevent disconnections because of inactivity, if the container is used behind load-balancers or reverse proxies ([issue #23](https://github.com/accetto/ubuntu-vnc-xfce-g3/issues/23))

  - script `vnc_startup.rc` has been adjusted and improved
  - script `version_of.sh` has been adjusted
  - **numpy** module has been added to make the HyBi protocol faster

  - following variables related to **noVNC** has been renamed in all related files
    - `ARG_NO_VNC_PORT` renamed to `ARG_NOVNC_PORT`
    - `NO_VNC_HOME` renamed to `NOVNC_HOME`
    - `NO_VNC_PORT` renamed to `NOVNC_PORT`

### Release 22.02

- Updated components:

  - **TigerVNC** to version **1.12.0**
  - **noVNC** to version **1.3.0**
  - **websockify** to version **0.10.0**

- Added components:

  - **python3** (also added into the `verbose version sticker`)
  - **systemctl**

- Updated files:

  - `Dockerfile.xfce` (components updated and added)
  - `Dockerfile.xfce.nodejs` (components updated and added)
  - `Dockerfile.xfce.postman` (components updated and added)
  - `Dockerfile.xfce.python` (components updated and added)
  - `vnc_startup.rc` (new **noVNC** startup)
  - `version_sticker.sh` (**python3** included)
  - `env.rc` (handling of tags)
  - `build` (handling of tags)
  - `pre_build` (handling of tags)
  - `util-readme.sh` (fixed token parsing)
  - all readme files

- Added files:

  - `local-builder-readme.md`

- Changes in building and publishing policy:
  - The images without **noVNC** will not be published on Docker Hub any more, because the size difference is now only 2MB. However, they always can be built locally.
  - The images tagged `latest` will always implement **VNC** and **noVNC**.
  - The Firefox images will always include also *Firefox plus features*. They do not change the default Firefox installation in any way and you can simply ignore them, if you wish.

### Release 22.01.1

- fixed `Dockerfile.xfce.postman`
  - package `libxshmfence1` added
  - it's required since Postman v9.8.3

### Release 22.01

- Dockerfiles use **TigerVNC** releases from **SourceForge** website

### Release 21.10

- `Dockerfile.xfce.nodejs` and `Dockerfile.xfce.python` updated (VSCode stage)

### Release 21.08

- `builder.sh` utility added
  - see also `local-building-example.md`

### Release 21.07

- Docker Hub has removed auto-builds from free plans since 2021-07-26, therefore
  - both GitHub Actions workflows `dockerhub-autobuild.yml` and `dockerhub-post-push.yml` have been disabled because they are not needed on free plans any more
    - just re-enable them if you are on a higher plan
  - **if you stay on the free plan**, then
    - you can still build the images locally and then push them to Docker Hub
      - pushing to Docker Hub is optional
      - just follow the added file `local-building-example.md`
    - you can publish the `readme` files to Docker Hub using the utility `util-readme.sh`
      - just follow the added file `examples-util-readme.md`
  - regularity of updates of images on Docker Hub cannot be guaranteed any more
- Other `Xfce4` related changes since the last release
  - keyboard layout explicit config added
  - `xfce4-terminal` set to unicode `utf-8` explicitly

### Release 21.05.2

- fix in script `release_of.sh`
  - because `wget` is not available on Docker Hub
- all images moved to `docker/doc/images`

### Release 21.05.1

- **Dockerfile stage diagrams** added (see the readme files)
- script `release_of.sh` improved

### Release 21.05

- packages **dconf-editor** and **gdebi-core** have been removed

### Release 21.04.2

- TigerVNC from [Release Mirror on accetto/tigervnc][accetto-tigervnc-release-mirror] because **Bintray** is closing on 2021-05-01

### Release 21.04.1

- circumventing limit of 25 auto-builder rules on Docker Hub
  - using two builder repositories
  - workflow `dockerhub-autobuild.yml` triggers both of them
  - see also updated [sibling project Wiki][sibling-wiki] (pages  [Building stages][sibling-wiki-building-stages] and [How CI works][sibling-wiki-how-ci-works])

### Release 21.04

- added **xfce-postman** into [accetto/ubuntu-vnc-xfce-postman-g3][accetto-ubuntu-vnc-xfce-postman-g3]
- sample applications moved from `/srv/projects/` to `/srv/samples`
  - this allows volume binding to `/srv/projects/` without eclipsing the provided samples
  - build argument `ARG_SAMPLES_DIR` and environment variable `SAMPLES_DIR` introduced
- readme files updated, including the embedded ones

### Release 21.03.2

- hook script `post_push` has been improved
  - environment variable `PROHIBIT_README_PUBLISHING` can be used to prevent the publishing of readme file to Docker Hub deployment repositories
  - useful for testing on Docker Hub or by building from non-default branches

### Release 21.03.1

- added **xfce-python** into [accetto/ubuntu-vnc-xfce-python-g3][accetto-ubuntu-vnc-xfce-python-g3]

### Release 21.03

- Initial release
  - **xfce-nodejs** into [accetto/ubuntu-vnc-xfce-nodejs-g3][accetto-ubuntu-vnc-xfce-nodejs-g3]
  - **xfce** image is not built or published on Docker Hub by default

***

[this-user-guide]: https://accetto.github.io/user-guide-g3/

[this-docker]: https://hub.docker.com/u/accetto/
[this-github]: https://github.com/accetto/headless-coding-g3/

[accetto-debian-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nodejs-g3
[accetto-debian-vnc-xfce-nvm-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-nvm-g3
[accetto-debian-vnc-xfce-vscode-g3]: https://hub.docker.com/r/accetto/debian-vnc-xfce-vscode-g3

<!-- Old links -->

[accetto-ubuntu-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3
[accetto-ubuntu-vnc-xfce-postman-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-postman-g3
[accetto-ubuntu-vnc-xfce-python-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-python-g3

[accetto-tigervnc-release-mirror]: https://github.com/accetto/tigervnc/releases

<!-- Sibling projects -->

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki
[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki-building-stages]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/Building-stages
[sibling-wiki-how-ci-works]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/How-CI-works

[dashboard-dockerhub]: https://github.com/accetto/dashboard/blob/master/dockerhub-dashboard.md

<!-- Other links -->

[vscode-portable]: https://code.visualstudio.com/docs/editor/portable
[service-shields-io]: https://shields.io/
