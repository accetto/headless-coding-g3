# Readme `Python`

This Docker image comes with only a few Python modules installed by intention. That allows you to choose the modules and the way of installation that suite you best.

## Updating `pip` and setup tools

You can update pip and the related setup tools by:

```shell
python -m pip install --upgrade pip setuptools wheel
```

## Installing libraries and Python modules

Additional libraries and some Python modules can be installed by `apt-get`, for example:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### numerical python library
sudo apt-get install python3-numpy
```

Other Python modules can be installed by `pip`, for example:

```shell
### framework for easy logging
pip install loguru

### framework for building CLI applications
pip install typer

### or also
### python -m pip install loguru
### python -m pip install typer
```

You can also check the [Loguru documentation](https://github.com/Delgan/loguru) and the [Typer documentation](https://typer.tiangolo.com).

## Installing web frameworks

The simple test applications can be found in `/srv/samples/`.

**Hint**: It is recommended to use an image that includes also **Chromium** or **Firefox** web browser. Then you can test your web application  inside the container.

### Flask

The `Flask` web framework can be installed by:

```shell
pip install flask
```

You can start by checking the [Flask documentation](https://palletsprojects.com/p/flask/).

### Bottle

The `Bottle` web framework can be installed by:

```shell
pip install bottle
```

You can start by checking the [Bottle documentation](https://bottlepy.org/).

## Installing GUI frameworks

The following GUI frameworks are mutually exclusive and you need only one of them. The simple test applications can be found in `/srv/samples/`.

Before installing any of the following frameworks you have to refresh the `apt` cache first:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update
```

### Tkinter

Installing `Tkinter`:

```shell
### install Tkinter
sudo apt-get -y install python3-tk

### optional check: built-in test should open a window
### python -m tkinter
```

You can start by checking the [Tkinter documentation](https://docs.python.org/3/library/tkinter.html).

### wxPython

Installing `wxPython`:

```shell
### install required libraries
sudo apt-get -y install libsdl2-2.0-0 libxtst6

### install wxPynton
pip install -U \
    -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 \
    wxPython
```

You can start by checking the [wxPython documentation](https://wxpython.org/).

### PyQt5

Installing `PyQt5`:

```shell
### install required libraries
sudo apt-get -y install libqt5gui5

### install PyQt5
pip install pyqt5

### optional: QtDesigner and other tools
sudo apt-get -y install qttools5-dev-tools
```

You can start by checking the [PyQt5 documentation](https://riverbankcomputing.com/static/Docs/PyQt5).

### Qt for Python (PySide2 and PySide6)

Installing `PySide2`:

```shell
### install required libraries
sudo apt-get -y install libqt5gui5

### install PySide2
pip install pyside2

### optional: QtDesigner and other tools
sudo apt-get -y install qttools5-dev-tools
```

Installing `PySide6`:

```shell
### install required libraries
sudo apt-get -y install libqt5gui5 libopengl0

### install PySide6
pip install pyside6
```

You can start by checking the [Qt for Python documentation](https://doc.qt.io/qtforpython) and also the part about [Porting Applications from PySide2 to PySide6](https://doc.qt.io/qtforpython/porting_from2.html).

### Kivy

Installing `Kivy`:

```shell
### install required libraries
sudo apt-get -y install libgl1 libmtdev1

### install Kivy
pip install kivy[base]

### optional: Kivy examples
### /home/headless/.local/share/kivy-examples/
pip install kivy_examples
```

You can start by checking the [Kivy documentation](https://kivy.org/doc/stable).

## What next

You can start by checking the [Python Documentation](https://www.python.org/doc/).

There are also some sample applications in `/srv/samples/`.
