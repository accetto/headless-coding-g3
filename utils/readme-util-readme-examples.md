# Examples `util-readme.sh`

## Preparation

Open a terminal window and change the current directory to `utils`.

The utility requires the `ID` of the deployment **GitHub Gist**, which you can provide as a parameter or by setting the environment variable `DEPLOY_GIST_ID`:

```shell
export DEPLOY_GIST_ID="<deployment-gist-ID>"
```

Embedded help describes the parameters:

```shell
./util-readme.sh -h
```

## Usage examples

```shell
### PWD = utils/

./util-readme.sh --repo accetto/debian-vnc-xfce-nodejs-g3 --context=../docker/xfce-nodejs --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/debian-vnc-xfce-postman-g3 --context=../docker/xfce-postman --gist <deployment-gist-ID> -- preview

./util-readme.sh --repo accetto/debian-vnc-xfce-python-g3 --context=../docker/xfce-python --gist <deployment-gist-ID> -- preview

### or if the environment variable 'DEPLOY_GIST_ID' has been set

./util-readme.sh --repo accetto/debian-vnc-xfce-nodejs-g3 --context=../docker/xfce-nodejs -- preview

./util-readme.sh --repo accetto/debian-vnc-xfce-postman-g3 --context=../docker/xfce-postman -- preview

./util-readme.sh --repo accetto/debian-vnc-xfce-python-g3 --context=../docker/xfce-python -- preview
```

See the sibling Wiki page ["Utility util-readme.sh"][sibling-wiki-utility-util-readme] for more information.

***

[sibling-wiki-utility-util-readme]: https://github.com/accetto/debian-vnc-xfce-g3/wiki/Utility-util-readme
