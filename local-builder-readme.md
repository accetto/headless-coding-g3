# Utility `builder.sh`

Builder command pattern:

```bash
./builder.sh <blend> <cmd> [build-options]
```

Supported values for `<cmd>`: `pre_build`, `build`, `push`, `post_push` and `all`.

Supported values for `<blend>` can be found in the hook script `env.rc`. The typical values are listed below.

Examples:

```bash
./builder.sh latest build --no-cache

### set the environment variables first, e.g. 'source ./secrets.rc'
./builder.sh latest all
```

## ubuntu-vnc-xfce-nodejs-g3

Builds for Docker Hub:

| Blend                  | Deployment tag  |
| ---------------------- | --------------- |
| nodejs                 | latest          |
| nodejs-chromium        | chromium        |
| nodejs-vscode          | vscode          |
| nodejs-vscode-chromium | vscode-chromium |
| nodejs-vscode-firefox  | vscode-firefox  |
| nodejs-current         | current         |

Local builds only:

| Blend                              | Deployment tag              |
| ---------------------------------- | --------------------------- |
| nodejs-vnc                         | vnc                         |
| nodejs-vnc-chromium                | vnc-chromium                |
| nodejs-vnc-vscode                  | vnc-vscode                  |
| nodejs-vnc-vscode-chromium         | vnc-vscode-chromium         |
| nodejs-vnc-vscode-firefox          | vnc-vscode-firefox          |
| nodejs-vnc-current                 | current-vnc                 |
| nodejs-vnc-chromium-current        | current-vnc-chromium        |
| nodejs-vnc-vscode-current          | current-vnc-vscode          |
| nodejs-vnc-vscode-chromium-current | current-vnc-vscode-chromium |
| nodejs-vnc-vscode-firefox-current  | current-vnc-vscode-firefox  |

## ubuntu-vnc-xfce-postman-g3

Builds for Docker Hub:

| Blend            | Deployment tag |
| ---------------- | -------------- |
| postman          | latest         |
| postman-chromium | chromium       |
| postman-firefox  | firefox        |

Local builds only:

| Blend                | Deployment tag |
| -------------------- | -------------- |
| postman-vnc          | vnc            |
| postman-vnc-chromium | vnc-chromium   |
| postman-vnc-firefox  | vnc-firefox    |

## ubuntu-vnc-xfce-python-g3

Builds for Docker Hub:

| Blend                  | Deployment tag  |
| ---------------------- | --------------- |
| python                 | latest          |
| python-chromium        | chromium        |
| python-vscode          | vscode          |
| python-vscode-chromium | vscode-chromium |
| python-vscode-firefox  | vscode-firefox  |

Local builds only:

| Blend                      | Deployment tag      |
| -------------------------- | ------------------- |
| python-vnc                 | vnc                 |
| python-vnc-chromium        | vnc-chromium        |
| python-vnc-vscode          | vnc-vscode          |
| python-vnc-vscode-chromium | vnc-vscode-chromium |
| python-vnc-vscode-firefox  | vnc-vscode-firefox  |

## headless-coding-g3

These base images are not published on Docker Hub.

Local builds only:

| Blend                   | Deployment tag   |
| ----------------------- | ---------------- |
| coding                  | latest           |
| coding-chromium         | chromium         |
| coding-firefox          | firefox          |
| coding-firefox-plus     | firefox-plus     |
| coding-vnc              | vnc              |
| coding-vnc-chromium     | vnc-chromium     |
| coding-vnc-firefox      | vnc-firefox      |
| coding-vnc-firefox-plus | vnc-firefox-plus |

## ubuntu-vnc-xfce-python-g3 (bonus branch)

```plain
Local only:

- python-vnc-kivy
- python-vnc-kivy-vscode
- python-vnc-novnc-kivy
- python-vnc-novnc-kivy-vscode
- python-vnc-pyqt5
- python-vnc-pyqt5-vscode
- python-vnc-novnc-pyqt5
- python-vnc-novnc-pyqt5-vscode
- python-vnc-pyside2
- python-vnc-pyside2-vscode
- python-vnc-novnc-pyside2
- python-vnc-novnc-pyside2-vscode
- python-vnc-pyside6
- python-vnc-pyside6-vscode
- python-vnc-novnc-pyside6
- python-vnc-novnc-pyside6-vscode
- python-vnc-tkinter
- python-vnc-tkinter-vscode
- python-vnc-novnc-tkinter
- python-vnc-novnc-tkinter-vscode
- python-vnc-wxpython
- python-vnc-wxpython-vscode
- python-vnc-novnc-wxpython
- python-vnc-novnc-wxpython-vscode
```
