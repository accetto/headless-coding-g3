# Readme `pyside-test-app`

This is a very simple test application for the Python GUI frameworks `PySide2` and `PySide6`.

## Prerequisites

First ensure that `PySide2` or `PySide6` is correctly installed. The installation is described in the file `readme-python.md` in the home directory.

## Starting test application

Before starting the application enable the correct framework version in the source file `main.py`:

```python
### enable the correct framework version
from PySide2 import QtCore, QtWidgets
# from PySide6 import QtCore, QtWidgets
```

The application should open a simple window:

```shell
### PWD = /srv/samples/pyside-test-app
python main.py
```

## What next

You can start by checking the [Qt for Python documentation](https://doc.qt.io/qtforpython).
