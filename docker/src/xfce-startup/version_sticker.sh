#!/bin/bash

### resolve also symlinks
_current_dir="$(dirname "$(readlink -f "$0")")"

debian=$("${_current_dir}/version_of.sh" debian)
ubuntu=$("${_current_dir}/version_of.sh" ubuntu)
chromium=$("${STARTUPDIR}/version_of.sh" chromium)
firefox=$("${STARTUPDIR}/version_of.sh" firefox)
nodejs=$("${STARTUPDIR}/version_of.sh" nodejs)
npm=$("${STARTUPDIR}/version_of.sh" npm)
nvm=$("${STARTUPDIR}/version_of.sh" nvm)
postman=$("${STARTUPDIR}/version_of.sh" postman)
vscode=$("${STARTUPDIR}/version_of.sh" vscode)

python=$("${STARTUPDIR}/version_of.sh" python)
if [[ -n "${python}" ]] ; then python_pip=$("${STARTUPDIR}/version_of.sh" python-pip) ; fi

main() {
    local key

    if [[ $# -gt 0 ]] ; then
    
        while [[ $# -gt 0 ]] ; do

            key="$1"

            if [[ "${key}" = '--' ]] ; then
            
                shift
            fi

            case "${key}" in

                -h )
                    echo "Usage: version_sticker [-h] [-v] [-V] [-f]"
                    echo "-h    help"
                    echo "-v    short version sticker"
                    echo "-V    verbose version sticker"
                    echo "-f    features"
                    ;;

                -f )
                    env | grep "FEATURES_" | sort
                    ;;

                -v )
                    if [[ -n "${chromium}" ]] ; then echo "Chromium ${chromium}" ; fi
                    if [[ -n "${firefox}" ]] ; then echo "Firefox ${firefox}" ; fi
                    if [[ -n "${nodejs}" ]] ; then echo "Node.js ${nodejs}" ; fi
                    if [[ -n "${npm}" ]] ; then echo "npm ${npm}" ; fi
                    if [[ -n "${nvm}" ]] ; then echo "nvm ${nvm}" ; fi
                    if [[ -n "${postman}" ]] ; then echo "Postman ${postman}" ; fi
                    if [[ -n "${python}" ]] ; then echo "Python ${python}" ; fi
                    if [[ -n "${python_pip}" ]] ; then echo "python-pip ${python_pip}" ; fi

                    if [[ -n "${debian}" ]] ; then
                        echo "Debian ${debian}"
                    elif [[ -n "${ubuntu}" ]] ; then
                        echo "Ubuntu ${ubuntu}"
                    fi

                    if [[ -n "${vscode}" ]] ; then echo "VSCode ${vscode}" ; fi
                    ;;

                -V )
                    if [[ -n "${chromium}" ]] ; then echo "Chromium ${chromium}" ; fi

                    version=$("${_current_dir}/version_of.sh" curl)
                    if [[ -n "${version}" ]] ; then echo "curl ${version}" ; fi

                    # version=$("${_current_dir}/version_of.sh" dconf-editor)
                    # if [[ -n "${version}" ]] ; then echo "dconf-editor ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" fakeroot)
                    if [[ -n "${version}" ]] ; then echo "fakeroot ${version}" ; fi

                    if [[ -n "${firefox}" ]] ; then echo "Firefox ${firefox}" ; fi

                    # version=$("${_current_dir}/version_of.sh" gdebi)
                    # if [[ -n "${version}" ]] ; then echo "gdebi ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" git)
                    if [[ -n "${version}" ]] ; then echo "git ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" gpg)
                    if [[ -n "${version}" ]] ; then echo "gpg ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" jq)
                    if [[ -n "${version}" ]] ; then echo "jq ${version}" ; fi
                    
                    version=$("${_current_dir}/version_of.sh" mousepad)
                    if [[ -n "${version}" ]] ; then echo "Mousepad ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" nano)
                    if [[ -n "${version}" ]] ; then echo "nano ${version}" ; fi

                    if [[ -n "${nodejs}" ]] ; then echo "Node.js ${nodejs}" ; fi

                    version=$("${_current_dir}/version_of.sh" novnc)
                    if [[ -n "${version}" ]] ; then echo "noVNC ${version}" ; fi

                    if [[ -n "${npm}" ]] ; then echo "npm ${npm}" ; fi

                    if [[ -n "${nvm}" ]] ; then echo "nvm ${nvm}" ; fi

                    if [[ -n "${postman}" ]] ; then echo "Postman ${postman}" ; fi

                    version=$("${_current_dir}/version_of.sh" python3)
                    if [[ -n "${version}" ]] ; then echo "Python ${version}" ; fi

                    if [[ -n "${python_pip}" ]] ; then echo "python-pip ${python_pip}" ; fi

                    version=$("${_current_dir}/version_of.sh" ristretto)
                    if [[ -n "${version}" ]] ; then echo "Ristretto ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" rpm)
                    if [[ -n "${version}" ]] ; then echo "rpm ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" screenshooter)
                    if [[ -n "${version}" ]] ; then echo "Screenshooter ${version}" ; fi

                    version=$("${_current_dir}/version_of.sh" tigervnc)
                    if [[ -n "${version}" ]] ; then echo "TigerVNC ${version}" ; fi

                    if [[ -n "${debian}" ]] ; then
                        echo "Debian ${debian}"
                    elif [[ -n "${ubuntu}" ]] ; then
                        echo "Ubuntu ${ubuntu}"
                    fi

                    if [[ -n "${vscode}" ]] ; then echo "VSCode ${vscode}" ; fi

                    version=$("${_current_dir}/version_of.sh" websockify)
                    if [[ -n "${version}" ]] ; then echo "websockify ${version}" ; fi
                    ;;
            esac
            shift
        done
    else
        if [[ -n "${debian}" ]] ; then
            sticker="debian${debian}"
        elif [[ -n "${ubuntu}" ]] ; then
            sticker="ubuntu$ubuntu"
        fi

        ### Warning, 'nvm' must come before 'nodejs'!
        if [[ -n "${nvm}" ]] ; then

            sticker="${sticker}"-"nvm${nvm}"

        elif [[ -n "${nodejs}" ]] ; then

            sticker="${sticker}"-"nodejs${nodejs}"-"npm${npm}"

        elif [[ -n "${python}" ]] ; then

            sticker="${sticker}"-"python${python}"-"pip${python_pip}"
        fi

        if [[ -n "${postman}" ]] ; then

            sticker="${sticker}"-"postman${postman}"
        fi

        if [[ -n "${vscode}" ]] ; then

            sticker="${sticker}"-"code${vscode}"
        fi

        if [[ -n "${chromium}" ]] ; then

            sticker="${sticker}-chromium${chromium}"

        elif [[ -n "${firefox}" ]] ; then
        
            sticker="${sticker}-firefox${firefox}"
        fi
        
        echo "${sticker}"
    fi
}

main $@
