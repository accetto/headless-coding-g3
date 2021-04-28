# CHANGELOG

## Project `accetto/headless-coding-g3`

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][sibling-wiki] - [Discussions][sibling-discussions]

***

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
