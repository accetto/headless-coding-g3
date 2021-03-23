# Readme `Python`

This Docker image comes with only a few Python modules by intention. That allows you to choose the modules and the way of installation that suite you best.

## Updating `pip` and setup tools

You can update pip and the related setup tools by:

```shell
python -m pip install --upgrade pip setuptools wheel

```

## Installing modules

Some modules can be installed by `apt-get`, for example:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### numerical python library
sudo apt-get install python3-numpy
```

Other modules can be installed by `pip`, for example:

```shell
### framework for building CLI applications
python -m pip install typer
```

## Installing GUI frameworks

The following GUI frameworks are mutually exclusive, you need only one of them. There are sorted from the simplest one. The simple test applications can be found in `/srv/projects/`.

Installing `Tkinter`:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### install Tkinter
sudo apt-get -y install python3-tk

### optional: built-in test should open a window
python -m tkinter
```

Installing `wxPython`:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### install required libraries
sudo apt-get -y install libsdl2-2.0-0 libxtst6

### install wxPynton
pip install -U \
    -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 \
    wxPython
```

Installing `PyQt5`:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### install required libraries
sudo apt-get -y install libqt5gui5

### install PyQt5
pip install pyqt5

### optional: QtDesigner and other tools
sudo apt-get -y install qttools5-dev-tools
```

Installing `PySide2`:

```shell
### apt cache needs to be refreshed only once
sudo apt-get update

### install required libraries
sudo apt-get -y install libqt5gui5

### install PySide2
pip install pyside2

### optional: QtDesigner and other tools
sudo apt-get -y install qttools5-dev-tools
```

## Other tips

You can check the installed `Python` version by:

```shell
python --version

### or also
python3 --version
```

You start by following the [Python Documentation](https://www.python.org/doc/).
