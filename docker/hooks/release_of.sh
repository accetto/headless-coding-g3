#!/bin/bash -e

main() {
    local result=""

    case "$1" in

        chromium-1804)
            result=$( \
                curl -s http://archive.ubuntu.com/ubuntu/pool/universe/c/chromium-browser/ \
                | grep -Po -m1 '(?<=href=")[^_]*_([0-9.]+-0ubuntu0\.18\.04\.[^_"]*)_[^"]*' \
                | cut -d _ -f 2 )
            ;;

        nodejs-lts )
            result=$( \
                curl -s https://nodejs.org/en/download/ \
                | grep "Latest LTS Version:" \
                | grep -Po -m1 "[0-9.]+" \
                | head -n1 )
            ;;

        nodejs-current )
            result=$( \
                curl -s https://nodejs.org/en/download/current/ \
                | grep "Latest Current Version:" \
                | grep -Po -m1 "[0-9.]+" \
                | head -n1 )
            ;;

        * )
            echo "Unknown key '$1'"
            return 1
            ;;

    esac

    echo "${result}"
}

main $@
