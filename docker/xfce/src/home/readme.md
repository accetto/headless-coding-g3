# Readme

This is the main **README** file of a set of configurable Docker images that can include additional features.

There are additional **README** files in the home directory.

## Adding more applications

I try to keep the images slim. Consequently you can encounter missing dependencies while adding more applications yourself. You can track the missing libraries on the [Ubuntu Packages Search](https://packages.ubuntu.com/) page and install them subsequently.

You can also try to fix it by executing the following (the default `sudo` password is **headless**):

```shell
### apt cache needs to be updated only once
sudo apt-get update

sudo apt --fix-broken install
```
