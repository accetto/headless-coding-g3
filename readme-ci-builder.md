# Utility `ci-builder.sh`

- [Utility `ci-builder.sh`](#utility-ci-buildersh)
  - [Introduction](#introduction)
  - [Preparation](#preparation)
    - [Ensure file attributes after cloning](#ensure-file-attributes-after-cloning)
    - [Set environment variables before building](#set-environment-variables-before-building)
    - [Ensure `wget` utility](#ensure-wget-utility)
  - [Usage modes](#usage-modes)
    - [Group mode](#group-mode)
      - [Group mode examples](#group-mode-examples)
    - [Family mode](#family-mode)
      - [Family mode examples](#family-mode-examples)
    - [Log processing](#log-processing)
      - [Digest command](#digest-command)
      - [Stickers command](#stickers-command)
      - [Timing command](#timing-command)
      - [Errors command](#errors-command)
  - [Additional building parameters](#additional-building-parameters)
  - [Helper commands for specific scenarios](#helper-commands-for-specific-scenarios)
    - [Command `list`](#command-list)
    - [Command `pull`](#command-pull)
    - [Command `update-gists`](#command-update-gists)
    - [Command `helper-help`](#command-helper-help)
    - [Example](#example)

## Introduction

This utility script can build and publish sets of images.
It can also extract selected information from the building log.

The common usage pattern

```shell
./ci-builder.sh <mode> <argument> [<optional-argument>]...
```

has the following typical forms that also described below:

```shell
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)
```

The supported option values can be taken from the embedded help:

```shell
This script can:
    - build sets of images using the builder script 'builder.sh'
    - extract selected information from the log

Usage: <script> <mode> <argument> [<optional-argument>]...

    ./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
    ./ci-builder.sh [<options>] <command> family <parent-blend> [<child-suffix>]...
    ./ci-builder.sh [--log-all] log get (digest|stickers|timing|errors)

<options>      := (--log-all|--no-cache) 
<command>      := (all|all-no-push)
                  |(pull|update-gists|list|helper-help)
<mode>         := (group|family)
<parent-blend> := (complete)|(vscode[-all]|nvm[-vscode]|python[-vscode]|postman|nodejs[-current|-vscode])
<child-suffix> := (-chromium|-firefox), except with 'nodejs-current'
<blend>        := (pivotal|complete[-chromium|-firefox|-vscode|-nvm|-nodejs|-postman|-python])
                  |(vscode|postman)
                  |(nvm[-chromium|-vscode[-chromium|-firefox]])
                  |(nodejs[-current|-chromium|-vscode[-chromium|-firefox]])
                  |(python[-chromium|-vscode[-chromium|-firefox]])

Group mode : All images are processed independently.
Family mode: The children are skipped if a new parent image was not actually built.
Remark: Currently are both modes equivalent, because there are no child suffixes supported.

Note that the groups 'pivotal|complete|complete-chromium|complete-firefox|complete-vscode' do not include
the 'nodejs' and 'postman' images. Those should be built explicitly.

Note that the group 'complete-vscode' includes only 'vscode[-chromium|-firefox]' images.
The group 'complete-vscode-all' includes all images containing 'vscode' (excluding 'nodejs').

The command and the blend are passed to the builder script.
The result "<parent-blend><child-suffix>" must be a blend supported by the builder script.

The script creates a complete execution log.
```

The optional parameter `--no-cache` will be passed to the internally used script `builder.sh`.

The optional parameter `--log-all` will cause that the script's output will be written into the log file in all cases.
Normally the command line errors or the **log processing mode** commands are not logged.

## Preparation

### Ensure file attributes after cloning

It may be necessary to repair the executable files attributes after cloning the repository (by `git clone`).

You can do that by executing the following commands from the project's root directory:

```shell
find . -type f -name "*.sh" -exec chmod +x '{}' \;
chmod +x docker/hooks/*
```

For example, if the files in the folder `docker/hooks` would not be executable, then you would get errors similar to this:

```shell
$ ./builder.sh latest build

==> EXECUTING @2023-03-05_16-42-57: ./builder.sh 

./builder.sh: line 84: ./docker/hooks/build: Permission denied
```

### Set environment variables before building

Open a terminal windows and change the current directory to the root of the project (where the license file is).

Make a copy of the secrets example file, modify it and then source it in the terminal:

```shell
### make a copy and then modify it
cp examples/example-secrets.rc secrets.rc

### source the secrets
source ./secrets.rc

### or also

. ./secrets.rc
```

**TIP**: If you copy a file named `secrets.rc` into the folder `docker/hooks/`, then it will be automatically sourced by the hook script `env.rc`.

Be aware that the following environment variables are mandatory and must be always set:

- `REPO_OWNER_NAME`
- `BUILDER_REPO`

Ensure that your `secrets.rc` file contains at least the lines similar to these:

```shell
export REPO_OWNER_NAME="accetto"
export BUILDER_REPO="headless-coding-g3"
```

You can use your own names if you wish.

Alternatively you can modify the hook script file env.rc like this:

```shell
### original lines
declare _owner="${REPO_OWNER_NAME:?Need repo owner name}"
DOCKER_REPO="${_owner}/${BUILDER_REPO:?Need builder repo name}"

### modified lines
declare _owner="${REPO_OWNER_NAME:-accetto}"
DOCKER_REPO="${_owner}/${BUILDER_REPO:-headless-coding-g3}"
```

Again, you can use your own names if you wish.

You can also use other ways to set the variables.

### Ensure `wget` utility

If you are on Windows, you can encounter the problem of missing `wget` utility.
It is used by refreshing the `g3-cache` and it's available on Linux by default.

On Windows you have generally two choices.
You can build your images inside the `WSL` environment or you can download the `wget.exe` application for Windows.
Make sure to update also the `PATH` environment variable appropriately.

Since the version `25.04` the availability of the utility is checked.

The checking can be skipped by setting the environment variable `IGNORE_MISSING_WGET=1`.

The selected packages still will be downloaded into a temporary image layer, but not into the project's
`.g3-cache` folder nor the shared one, defined by the variable `SHARED_G3_CACHE_PATH`.

## Usage modes

### Group mode

The **group mode** is intended for building sets of independent images.

The **group mode** usage pattern:

```shell
./ci-builder.sh [<options>] <command> group <blend> [<blend>]...
```

#### Group mode examples

The image tags can be listed in the command line.
For example, all these images will be built independently of each other.

```shell
./ci-builder.sh all group nvm-vscode postman-firefox python-vscode-chromium
```

You can also use one of the **named groups**:

```shell
### includes the images 'vscode', 'nvm' and 'python'
./ci-builder.sh all group pivotal

### includes all images except the 'Node.js' and 'Postman' ones
### excluded images can be build explicitly
./ci-builder.sh all group complete

### includes all images featuring Firefox
./ci-builder.sh all group complete-firefox

### includes all images featuring Chromium
./ci-builder.sh all group complete-chromium

### includes all images featuring Visual Studio Code
./ci-builder.sh all group complete-vscode-all

### includes all images of the particular blend group
./ci-builder.sh all group complete-nodejs
./ci-builder.sh all group complete-nvm
./ci-builder.sh all group complete-postman
./ci-builder.sh all group complete-python
./ci-builder.sh all group complete-vscode
```

### Family mode

The **family mode** is intended for efficient building of sets of dependent images.

**Remark:** Since the version G3v3 of the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3] is this mode for advanced use only.
The previous images `accetto/ubuntu-vnc-xfce-g3:latest-fugo` and `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` that used it are not published any more.
The image `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` has been renamed to `accetto/ubuntu-vnc-xfce-firefox-g3:latest`.

The dependency in this context is meant more technically than conceptually.

The following example will help to understand the concept.

This project currently does not include any images that are in such a relation.
Therefore it will be explained using the images from the sibling project [accetto/ubuntu-vnc-xfce-g3][accetto-github-ubuntu-vnc-xfce-g3].

The image `accetto/ubuntu-vnc-xfce-firefox-g3:latest-plus` added some additional features to the image `accetto/ubuntu-vnc-xfce-firefox-g3:latest`, but otherwise were both images identical.

In such case a conclusion can be made, that if the `latest` tag does not need a refresh, then also the `latest-plus` tag doesn't need it and its building can be skipped.

There had been a similar dependency between the images `accetto/ubuntu-vnc-xfce-g3:latest` and `accetto/ubuntu-vnc-xfce-g3:latest-fugo`.

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

The following command could also be used, but there would be no benefit comparing to the equivalent **group mode** command:

```shell
./ci-builder.sh all family latest-chromium
```

You can also skip the publishing to the **Docker Hub** by replacing the `all` command by the `all-no-push` one.
For example:

```shell
### image 'latest-fugo' will be skipped if the 'latest' image doesn't need a re-build
./ci-builder.sh all-no-push family latest -fugo
```

### Log processing

The **log processing** mode is intended for evaluating the outcome of the latest image building session.
The result are extracted from the **ci-builder log** by `grep` utility.

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

Building image 'headless-coding-g3:postman'
Building image 'headless-coding-g3:postman-chromium'
Building image 'headless-coding-g3:postman-firefox'
Built new 'headless-coding-g3:postman'.
Built new 'headless-coding-g3:postman-chromium'.
Built new 'headless-coding-g3:postman-firefox'.
```

#### Stickers command

The `stickers` command extracts the information about the **version stickers** of the ephemeral helper images that have been built by the `pre_build` hook script.
That does not mean that the final persistent images have also been built (and optionally also published).

```shell
./ci-builder.sh log get stickers
```

The output can look out like this:

```text
--> Version stickers:

Current version sticker of 'accetto/headless-coding-g3:postman-chromium_helper': debian11.6-postman10.10.9-chromium110.0.5481.77
Current version sticker of 'accetto/headless-coding-g3:postman-firefox_helper': debian11.6-postman10.10.9-firefox102.8.0esr
Current version sticker of 'accetto/headless-coding-g3:postman_helper': debian11.6-postman10.10.9
```

#### Timing command

The `timing` command extracts the selected timestamps that give an approximation of the building duration.

```shell
./ci-builder.sh log get timing
```

The output can look out like this:

```text
--> Building timing:

==> EXECUTING @2023-02-25_13-38-10: ./ci-builder.sh 
==> EXECUTING @2023-02-25_13-38-10: ./builder.sh
==> FINISHED  @2023-02-25_13-38-45: ./builder.sh
==> EXECUTING @2023-02-25_13-38-45: ./builder.sh
==> FINISHED  @2023-02-25_13-38-59: ./builder.sh
==> EXECUTING @2023-02-25_13-38-59: ./builder.sh
==> FINISHED  @2023-02-25_13-39-14: ./builder.sh
==> FINISHED  @2023-02-25_13-39-14: ./ci-builder.sh
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

## Additional building parameters

There is no notion of additional building parameters by the script `ci-builder.sh` (compare to [builder.sh][readme-builder]).

There is no way to build the images only from particular Dockerfile stages using the script `ci-builder.sh`.

## Helper commands for specific scenarios

There has been a case when it was necessary to update the badges of all repositories because of switching from the **badgen.net** provider to the **shields.io** one.

Therefore the **Release 25.05 (G3v8)** has introduced a new hook script called `helper` and also the following new commands:

- list
- pull
- update-gists
- helper-help

The commands are forwarded by the utility script `builder.sh` to the appropriate target scripts, as it's described in the file `readme-builder.md`.

There is also a new wildcard value `any`, which can be generally used for the command arguments `branch` and `blend` in all cases when the argument values are not really needed, but they are enforced purely by the command syntax.

### Command `list`

The **list** command displays a list of the actual names of the target build and deployment images, that would be built during the given building scenario.
The names of possible helper images will not be included.

For example:

```shell
headless-coding-g3> ./ci-builder.sh list group complete-nvm

### would output
Build target => accetto/headless-coding-g3:nvm
Deploy target => accetto/debian-vnc-xfce-nvm-g3:latest
Build target => accetto/headless-coding-g3:nvm-chromium
Deploy target => accetto/debian-vnc-xfce-nvm-g3:chromium
Build target => accetto/headless-coding-g3:nvm-vscode
Deploy target => accetto/debian-vnc-xfce-nvm-g3:vscode
Build target => accetto/headless-coding-g3:nvm-vscode-chromium
Deploy target => accetto/debian-vnc-xfce-nvm-g3:vscode-chromium
Build target => accetto/headless-coding-g3:nvm-vscode-firefox
Deploy target => accetto/debian-vnc-xfce-nvm-g3:vscode-firefox
```

### Command `pull`

The **pull** command pulls from ***Docker Hub* all the images that would be built and published during the given building scenario.

For example:

```shell
headless-coding-g3> ./ci-builder.sh pull group complete-nvm

### would pull the following images
accetto/debian-vnc-xfce-nvm-g3:latest
accetto/debian-vnc-xfce-nvm-g3:chromium
accetto/debian-vnc-xfce-nvm-g3:vscode
accetto/debian-vnc-xfce-nvm-g3:vscode-chromium
accetto/debian-vnc-xfce-nvm-g3:vscode-firefox
```

### Command `update-gists`

The **update-gists** command updates the deployment gists of the images that would be built and deployed in the given build scenario.

It's expected that all such images are already available locally, e.g that they've been previously built or pulled from the **Docker Hub**.

The values of the `created` and `version sticker` badges are extracted from the local images and the `verbose version sticker` badge values are generated using them.

For example:

```shell
### would update all deployment gists belonging to the above images
headless-coding-g3> ./ci-builder.sh update-gists group complete-nvm

### excerpt from the output
Missing builder image 'accetto/headless-coding-g3:nvm'.
Getting badge values from deployment image 'accetto/headless-coding-g3:latest'.
Wait... generating current verbose sticker file './docker/scrap-version_sticker-verbose_current.tmp'

Badge 'created': 2025-04-10T14:49:33Z
Badge 'version_sticker': debian12.10-nvm0.40.2
Badge 'version_sticker_verbose':
...
Updating builder gists for 'accetto/headless-coding-g3:nvm'
Updating gist 'headless-coding-g3@nvm@created.json'
Attempt 1 of 3...
Gist 'headless-coding-g3@nvm@created.json' updated successfully on attempt 1
Updating gist 'headless-coding-g3@nvm@version-sticker.json'
Attempt 1 of 3...
Gist 'headless-coding-g3@nvm@version-sticker.json' updated successfully on attempt 1
Updating gist 'headless-coding-g3@nvm@version-sticker-verbose.txt'
Attempt 1 of 3...
Gist 'headless-coding-g3@nvm@version-sticker-verbose.txt' updated successfully on attempt 1
...
Updating deployment gists for 'accetto/debian-vnc-xfce-nvm-g3:latest'
Updating gist 'debian-vnc-xfce-nvm-g3@latest@created.json'
Attempt 1 of 3...
Gist 'debian-vnc-xfce-nvm-g3@latest@created.json' updated successfully on attempt 1
Updating gist 'debian-vnc-xfce-nvm-g3@latest@version-sticker.json'
Attempt 1 of 3...
Gist 'debian-vnc-xfce-nvm-g3@latest@version-sticker.json' updated successfully on attempt 1
Updating gist 'debian-vnc-xfce-nvm-g3@latest@version-sticker-verbose.txt'
Attempt 1 of 3...
Gist 'debian-vnc-xfce-nvm-g3@latest@version-sticker-verbose.txt' updated successfully on attempt 1
...
```

### Command `helper-help`

The **helper-help** command displays the embedded help of the new hook script called `helper`, which supports the other new commands.

From the example below it can be also seen, that this is one of the commands, which can be used with the newly introduced wildcard value `any` for the `branch` and `blend` arguments.
  Generally the wildcard value `any` should work in all cases when the argument values are not really needed but they are enforced purely by the command syntax.

For example:

```shell
headless-coding-g3> ./ci-builder.sh helper-help group any any
Warning from 'ci-builder.sh': Nothing to do for 'any' blend!
Provided parameters:
command=helper-help
subject=any
Warning from 'env.rc': Allowing 'any' blend!
Warning from 'env.rc': Allowing 'any' blend!

The script "./docker/hooks/helper" contains helper functions for the script 'ci-builder.sh'.

Usage: ./docker/hooks/helper <branch> <blend> <command>

<branch>    := (any|dev|(or see 'env.rc'))
<blend>     (any|(or see 'env.rc'))
<command>   := (help|--help|-h)
            (list-target|list-build-target|list-deploy-target)
            (pull|pull-deploy-target|pull-build-target)
Warning from 'env.rc': Allowing 'any' blend!
Warning from 'env.rc': Allowing 'any' blend!

The script "./docker/hooks/helper" contains helper functions for the script 'ci-builder.sh'.

Usage: ./docker/hooks/helper <branch> <blend> <command>

<branch>    := (any|dev|(or see 'env.rc'))
<blend>     (any|(or see 'env.rc'))
<command>   := (help|--help|-h)
            (list-target|list-build-target|list-deploy-target)
            (pull|pull-deploy-target|pull-build-target)
```

### Example

This is how you would update the deployment gists of the building group `pivotal` using the "historical" data from the previously published images.

```shell
### Step 1: Pull the previously published images
headless-coding-g3> ./ci-builder.sh pull group pivotal

### Step 2: Update the gists
headless-coding-g3> ./ci-builder.sh update-gists group pivotal
```

If you don't want to use the "historical" data, but to build and publish fresh images, then you would do the following:

```shell
### Step 1: build fresh new images and publish them and update their deployment gists
headless-coding-g3> ./ci-builder.sh all group pivotal
```

***

[readme-builder]: https://github.com/accetto/headless-coding-g3/blob/master/readme-builder.md

[accetto-github-ubuntu-vnc-xfce-g3]: https://github.com/accetto/ubuntu-vnc-xfce-g3
