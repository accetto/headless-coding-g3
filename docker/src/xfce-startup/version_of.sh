#!/bin/bash

# cSpell:disable

case "$1" in
    angular | angular-cli | angularcli | ng )
        ### source example: Angular CLI: 8.3.2
        echo $(ng --version 2>/dev/null | grep -Po -m1 '(?<=Angular CLI:\s)[0-9.]+')
        ;;
    chromium | chromium-browser)
        ### source example: Chromium 115.0.5790.170 built on Debian 12.1, running on Debian 12.1
        echo $(chromium --version 2>/dev/null | grep -Po -m1 '(?<=Chromium\s)[0-9.]+')
        ;;
    code | vsc | vscode | visual-studio-code | visualstudiocode )
        ### source example: 1.37.1
        echo $(code --version 2>/dev/null | grep -Po -m1 '^[0-9.]+$')
        ;;
    curl )
        ### source example: curl 7.58.0 (x86_64-pc-linux-gnu) libcurl/7.58.0 OpenSSL/1.1.1 zlib/1.2.11 libidn2/2.0.4 libpsl/0.19.1 (+libidn2/2.0.4) nghttp2/1.30.0 librtmp/2.3
        echo $(curl --version 2>/dev/null | grep -Po -m1 '(?<=curl\s)[0-9.]+')
        ;;
    dconf-editor )
        ### source example: dconf-editor 3.36.0
        echo $(dconf-editor --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    debian )
        ### source example: 11 (bullseye)
        # echo $(cat /etc/os-release 2>/dev/null | grep -Po -m1 '(?<=VERSION\=")[0-9.]+')
        ### source example: 11.6
        echo $(cat /etc/debian_version 2>/dev/null | grep -Po -m1 '^[0-9.]+$')
        ;;
    drawio | drawio-desktop )
        ### source example: 12.2.2
        echo $(drawio --no-sandbox --version 2>/dev/null | grep -Po -m1 '^[0-9.]+$')
        ;;
    fakeroot )
        ### source example: fakeroot version 1.22
        echo $(fakeroot --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    firefox )
        ### source example: Mozilla Firefox 68.0.2
        echo $(firefox -v 2>/dev/null | grep -Po -m1 '(?<=Firefox\s)[0-9a-zA-Z.-]+')
        ;;
    gimp )
        ### source example: GNU Image Manipulation Program version 2.8.22
        echo $(gimp --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    gdebi )
        ### source example: 0.9.5.7+nmu2
        echo $(gdebi --version 2>/dev/null | grep -Po -m1 '^[0-9.]+')
        ;;
    git )
        ### source example: git version 2.17.1
        echo $(git --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    gpg )
        ### source example: gpg (GnuPG) 2.2.19
        echo $(gpg --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    heroku | heroku-cli | herokucli )
        ### source sample: heroku/7.29.0 linux-x64 node-v11.14.0
        echo $(heroku --version 2>/dev/null | grep -Po -m1 '(?<=heroku/)[0-9.]+')
        ;;
    inkscape )
        ### Inkscape requires display!
        ### source sample: Inkscape 0.92.3 (2405546, 2018-03-11)
        echo $(inkscape --version 2>/dev/null | grep -Po -m1 '(?<=Inkscape\s)[0-9.]+')
        ;;
    jq )
        ### source sample: jq-1.5-1-a5b5cbe
        echo $(jq --version 2>/dev/null | grep -Po -m1 '(?<=jq\-)[0-9.]+')
        ;;
    mousepad )
        ### Mousepad requires display!
        ### source example: Mousepad 0.4.0
        echo $(mousepad --version 2>/dev/null | grep -Po -m1 '(?<=Mousepad\s)[0-9.]+')
        ;;
    nano )
        ### source example: GNU nano, version 4.8
        echo $(nano --version 2>/dev/null | grep -Po -m1 '(?<=version\s)[0-9.]+')
        ;;
    nodejs | node-js | node )
        ### source example: v10.16.3
        echo $(node --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    novnc | no-vnc )
        ### source example: 1.1.0
        #echo $(cat "${NOVNC_HOME}"/VERSION 2>/dev/null | grep -Po '^[0-9.]+$')
        echo $(cat "${NOVNC_HOME}"/package.json 2>/dev/null | grep -Po -m1 '(?<=\s"version":\s")[0-9.]+')
        ;;
    npm )
        ### source example: 6.9.0
        echo $(npm --version 2>/dev/null  | grep -Po -m1 '[0-9.]+$')
        ;;
    nvm )
        ### source example: 0.39.5
        if [ -f "${HOME}/.nvm/nvm.sh" ] ; then
            \. "${HOME}"/.nvm/nvm.sh && echo $(nvm --version 2>/dev/null  | grep -Po -m1 '[0-9.]+$')
        fi
        ;;
    postman )
        # jq -r '.version' /opt/Postman/app/resources/app/package.json
        if [[ -n "$(which postman)" && -n "$(which jq)" ]] ; then
            jq -r '.version' "${POSTMAN_PATH}"/Postman/app/resources/app/package.json 2>/dev/null
        fi
        ;;
    psql | postgresql | postgre-sql | postgre )
        ### source example: psql (PostgreSQL) 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
        echo $(psql --version 2>/dev/null | grep -Po -m1 '(?<=psql \(PostgreSQL\)\s)[0-9.]+')
        ;;
    python )
        ### source example: Python 3.8.5
        echo $(python --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    python-pip )
        ### source example: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
        echo $(python -m pip --version 2>/dev/null | grep -Po -m1 '(?<=pip\s)[0-9.]+')
        ;;
    python3 )
        ### source example: Python 3.8.5
        echo $(python3 --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    python3-pip )
        ### source example: pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
        echo $(python3 -m pip --version 2>/dev/null | grep -Po -m1 '(?<=pip\s)[0-9.]+')
        ;;
    ristretto )
        ### source example: ristretto 0.8.2
        echo $(ristretto --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    rpm )
        ### source example: RPM version 4.14.1
        echo $(rpm --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    tigervnc | tiger-vnc | vncserver | vnc-server | vnc )
        ### till TigerVNC 1.10.1
        ### source example: Xvnc TigerVNC 1.9.0 - built Jul 16 2018 14:18:04
        # echo $(vncserver -version 2>/dev/null | grep -Po '(?<=Xvnc TigerVNC\s)[0-9.]+')
        ### since TigerVNC 1.11.0 (it's coming out on the stderr stream!)
        ### source example: Xvnc TigerVNC 1.11.0 - built Sep  8 2020 12:27:03
        echo $(Xvnc -version 2>&1 | grep -Po -m1 '(?<=Xvnc TigerVNC\s)[0-9.]+')
        ;;
    tsc | typescript | type-script )
        ### source example: Version 3.6.2
        echo $(tsc --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
    ubuntu | xubuntu )
        ### source example: Ubuntu 18.04.3 LTS
        echo $(cat /etc/os-release 2>/dev/null | grep -Po -m1 '(?<=VERSION\=")[0-9.]+')
        ;;
    vim )
        ### source example: VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Jun 06 2019 17:31:41)
        echo $(vim --version 2>/dev/null | grep -Po -m1 '(?<=VIM - Vi IMproved\s)[0-9.]+')
        ;;
    websockify )
        ### source example: 0.8.0
        echo $(cat "${NOVNC_HOME}"/utils/websockify/CHANGES.txt 2>/dev/null | grep -Po -m1 '^[0-9.]+')
        ;;
    xfce4-screenshooter | screenshooter | screenshot )
        ### source example: xfce4-screenshooter 1.8.2
        echo $(xfce4-screenshooter --version 2>/dev/null | grep -Po -m1 '[0-9.]+$')
        ;;
esac
