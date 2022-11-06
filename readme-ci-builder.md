# Utility `ci-builder.sh`

- [Utility `ci-builder.sh`](#utility-ci-buildersh)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [Usage modes](#usage-modes)
    - [Family mode](#family-mode)
      - [Family mode examples](#family-mode-examples)
    - [Group mode](#group-mode)
      - [Group mode examples](#group-mode-examples)
    - [Log processing](#log-processing)
      - [Digest command](#digest-command)
      - [Stickers commands](#stickers-commands)
      - [Timing command](#timing-command)
      - [Errors command](#errors-command)

## Introduction

This utility script can build and publish sets of images. It can also extract selected information from the building log.

The common usage pattern

```shell
./ci-builder.sh <mode> <argument> [<optional-argument>]...
```

has the following typical forms that also described below:

```shell
./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)
```

The supported option values can be taken from the embedded help:

```shell
This script can:
    - build sets of images using the builder script 'builder.sh'
    - extract selected information from the log

Usage: <script> <mode> <argument> [<optional-argument>]...

    ./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
    ./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
    ./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)

<options>      := (--log-all|--no-cache) 
<command>      := (all|all-no-push)
<mode>         := (family|group)
<parent-blend> := (complete)|(postman|nodejs[-current|-vscode]|python[-vscode])
<child-suffix> := (-chromium|-firefox), except with 'nodejs-current'
<blend>        := (pivotal|complete[-chromium|-firefox|-vscode|-nodejs|-postman|-python])
                  |(postman)
                  |(nodejs[-current|-chromium|-vscode[-chromium|-firefox]])
                  |(python[-chromium|-vscode[-chromium|-firefox]])

Family mode: The children are skipped if a new parent image was not actually built.
Group mode : All images are processed independently.

The command and the blend are passed to the builder script.
The result "<parent-blend><child-suffix>" must be a blend supported by the builder script.

The script creates a complete execution log.
```

The optional parameter `--no-cache` will be passed to the internally used script `builder.sh`.

The optional parameter `--log-all` will cause that the script's output will be written into the log file in all cases. Normally the command line errors or the **log processing mode** commands are not logged. 

## Prerequisites

Before building and publishing the images prepare and source a file containing the necessary environment variables. You can use the provided file `example-secrets.rc` as a template.

If you name your file `secrets.rc` and you store it into the folder `docker/hooks/`, then it will sourced automatically by the hook script `env.rc`.

Otherwise you can source it in the terminal manually, for example:

```shell
source secrets.rc

### or also

. secrets.rc
```

## Usage modes

### Family mode

The **family mode** is intended for an efficient building of the sets of dependent images.

The dependency in this context is meant more technically than conceptually.

The following example will help to understand the concept.

This project currently does not include any images that are in such a relation. Therefore it will be explained using the images from the sibling project [accetto/ubuntu-vnc-xfce-g3][sibling-github].

The image `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` adds some additional features to the image `accetto/ubuntu-vnc-xfce-firefox-g3:latest`, but otherwise are both images identical.

In such case a conclusion can be made, that if the `latest` tag does not need a refresh, then also the `latest-plus` tag doesn't need it and it can be skipped.

There is a similar dependency between the images `accetto/ubuntu-vnc-xfce-g3:latest` and `accetto/ubuntu-vnc-xfce-g3:latest-fugo`.

This kind of family-like relation allows to refresh the images more efficiently by skipping the "children" if the "parent" doesn't need a re-build.

The **family mode** usage pattern:

```shell
./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
```

Note that the children tags are specified by their suffixes to the parent's tag.

#### Family mode examples

The following cases bring the efficiency advantage:

```shell
### image 'latest-fugo' will be skipped if the 'latest' image doesn't need a re-build
./ci-builder.sh all family latest -fugo

### 'firefox' image 'latest-plus' will be skipped if the 'latest' image doesn't need a re-build 
./ci-builder.sh all family latest-firefox -plus
```

The following command can also be used, but there would be no benefit comparing to the equivalent **group mode** command:

```shell
./ci-builder.sh all family latest-chromium
```

You can also skip the publishing to the **Docker Hub** by replacing the `all` command by the `all-no-push` one. For example:

```shell
### image 'latest-fugo' will be skipped if the 'latest' image doesn't need a re-build
./ci-builder.sh all-no-push family latest -fugo
```

### Group mode

The **group mode** is intended for building sets of independent images.

The **group mode** usage pattern:

```shell
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
```

#### Group mode examples

The image tags can be listed in the command line. For example, all these images will be built independently of each other.

```shell
./ci-builder.sh all group nodejs-vscode postman-firefox python-vscode-chromium
```
You can also use one of the **named groups**:

```shell
### includes the images 'nodejs', 'nodejs-current', 'nodejs-vscode', 'postman' and 'python'
./ci-builder.sh all group pivotal

### includes the images 'nodejs', 'nodejs-current', 'nodejs-chromium', 'nodejs-vscode',
### 'nodejs-vscode-chromium', 'nodejs-vscode-firefox', 'postman', 'postman-chromium',
### 'postman-firefox', 'python', 'python-chromium', 'python-vscode', 'python-vscode-chromium'
### and 'python-vscode-firefox'
./ci-builder.sh all group complete

### includes all the images featuring the Firefox browser
./ci-builder.sh all group complete-firefox

### includes all the images featuring the Chromium Browser
./ci-builder.sh all group complete-chromium

### includes all the images featuring the Visual Studio Code
./ci-builder.sh all group complete-vscode

### includes all the images featuring the named application
./ci-builder.sh all group complete-nodejs
./ci-builder.sh all group complete-postman
./ci-builder.sh all group complete-python
```
### Log processing

The **log processing** mode is intended for evaluating the outcome of the latest image building session. The result are extracted from the **ci-builder log** by `grep` utility.

The **log processing mode** usage pattern:

```shell
./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)
```

#### Digest command

The `digest` command extracts the information about the images that have been re-built or that do not require that.

```shell
./ci-builder.sh log get digest
```

The output can look out like this:

```text
--> Log digest:

Building image 'headless-ubuntu-coding-g3:postman'
Building image 'headless-ubuntu-coding-g3:postman-chromium'
Building image 'headless-ubuntu-coding-g3:postman-firefox'
No build needed for 'headless-ubuntu-coding-g3:postman'.
No build needed for 'headless-ubuntu-coding-g3:postman-chromium'.
No build needed for 'headless-ubuntu-coding-g3:postman-firefox'.
```

#### Stickers commands

The `stickers` command extracts the information about the **version stickers** of the ephemeral helper images that have been built by the `pre_build` hook script. That does not mean that the final persistent images have also been built (and optionally also published).

```shell
./ci-builder.sh log get stickers
```

The output can look out like this:

```text
--> Version stickers:

Current version sticker of 'accetto/devops-headless-ubuntu-coding-g3:postman-chromium_helper': ubuntu20.04.5-postman10.0.1-chromium105.0.5195.102
Current version sticker of 'accetto/devops-headless-ubuntu-coding-g3:postman-firefox_helper': ubuntu20.04.5-postman10.0.1-firefox106.0.2
Current version sticker of 'accetto/devops-headless-ubuntu-coding-g3:postman_helper': ubuntu20.04.5-postman10.0.1
```

#### Timing command

The `timing` command extracts the selected timestamps that give an approximation of the building duration.

```shell
./ci-builder.sh log get timing
```

The output can look out like this:

```text
--> Building timing:

==> EXECUTING @2022-11-06_11-22-43: ./ci-builder.sh 
==> EXECUTING @2022-11-06_11-22-43: ./builder.sh 
==> FINISHED  @2022-11-06_11-25-32: ./builder.sh 
==> EXECUTING @2022-11-06_11-25-32: ./builder.sh 
==> FINISHED  @2022-11-06_11-26-04: ./builder.sh 
==> EXECUTING @2022-11-06_11-26-04: ./builder.sh 
==> FINISHED  @2022-11-06_11-26-44: ./builder.sh 
==> FINISHED  @2022-11-06_11-26-44: ./ci-builder.sh
```

#### Errors command

The errors command extract the information about the possible errors during the building.

```shell
./ci-builder.sh log get errors
```

The output is mostly empty:

```text
--> Building errors:

```

***

[sibling-github]: https://github.com/accetto/ubuntu-vnc-xfce-g3/
