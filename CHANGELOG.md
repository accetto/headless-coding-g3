# CHANGELOG

## Project `accetto/headless-coding-g3`

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

***

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

[this-docker]: https://hub.docker.com/u/accetto/
[this-github]: https://github.com/accetto/headless-coding-g3/

[sibling-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki
[sibling-discussions]: https://github.com/accetto/ubuntu-vnc-xfce-g3/discussions

[sibling-wiki-building-stages]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/Building-stages
[sibling-wiki-how-ci-works]: https://github.com/accetto/ubuntu-vnc-xfce-g3/wiki/How-CI-works

[accetto-ubuntu-vnc-xfce-nodejs-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-nodejs-g3
[accetto-ubuntu-vnc-xfce-postman-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-postman-g3
[accetto-ubuntu-vnc-xfce-python-g3]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-python-g3

[accetto-tigervnc-release-mirror]: https://github.com/accetto/tigervnc/releases
