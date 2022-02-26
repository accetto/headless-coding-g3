# Examples `util-readme.sh`

## Preparation

You have to have `curl` installed for this utility.

Open a terminal window and change the current directory to `utils`.

Then copy the secrets example file, modify the copy and source it:

```shell
### make a copy and then modify it
cp example-secrets-utils.rc secrets-utils.rc

### source the secrets
source ./secrets-utils.rc
```

Optionally you can provide the secrets as command line parameters.

You can also provide the secrets file as a command line parameter instead of sourcing it.

Embedded help describes the parameters:

```shell
./util-readme.sh -h
```

## Usage examples

```shell
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-nodejs-g3 --context=../docker/xfce-nodejs -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-nodejs-g3 --context=../docker/xfce-nodejs -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-postman-g3 --context=../docker/xfce-postman -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-postman-g3 --context=../docker/xfce-postman -- publish

./util-readme.sh --repo accetto/ubuntu-vnc-xfce-python-g3 --context=../docker/xfce-python -- preview
./util-readme.sh --repo accetto/ubuntu-vnc-xfce-python-g3 --context=../docker/xfce-python -- publish
```
