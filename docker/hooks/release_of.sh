#!/bin/bash -e

main() {
    local result=""

    case "$1" in

        chromium-1804 )
            # result=$(curl -sL \
            result=$(wget -qO- \
                http://archive.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/ \
                | grep -Po -m1 '(?<=href=")[^_]*_([0-9.]+-0ubuntu0\.18\.04\.[^_"]*)_[^"]*' \
                | cut -d _ -f 2 \
            )
            ;;

        nodejs-current )
                # curl -sL https://nodejs.org/en/download/current/ \
            result=$(wget -qO- \
                https://nodejs.org/en/download/current/ \
                | grep "Latest Current Version:" \
                | grep -Po -m1 '[0-9.]+' \
                | head -n1
            )
            ;;

        nodejs-lts )
                # curl -sL https://nodejs.org/en/download/ \
            result=$(wget -qO- \
                https://nodejs.org/en/download/ \
                | grep 'Latest LTS Version:' \
                | grep -Po -m1 '[0-9.]+' \
                | head -n1
            )
            ;;

        * )
            echo "Unknown key '$1'"
            return 1
            ;;

    esac

    echo "${result}"
}

main $@
