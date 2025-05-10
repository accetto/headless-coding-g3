#!/bin/bash
### do not use '-e'

### depends on the script 'builder.sh'
### set the environment variables first, e.g. 'source .secrets'

### usage: './<scrip-name> <command>', where <command>=[all|all-no-push]

die() {
    local message="${1:-(unknown)}"
    local -i code=${2:-1}
    local place="${3:-$0}"

    echo -e "\nEXITING at line "${BASH_LINENO[0]}" in '${place}' with code ${code}: ${message}\n" >&2
    exit ${code}
}

clear_log() {

    ### just for debugging
    # cp -f "${_ci_builder_log}" "${_ci_builder_log}_copy"

    >"${_ci_builder_log}"
    echo -e "\n==> EXECUTING @$(date -u +'%Y-%m-%d_%H-%M-%S'): ${0} $@\n"
}

execute_smart() {

    if [[ -z "${_option_logall}" ]]; then

        _flag_skip_footer="1"

        exec 1>/dev/null
        {
            ### execute without logging
            $@

        } >&3

    else

        ### execute with logging
        $@
    fi
}

show_error() {

    ### don't output to 'stderr' (>&2) here!
    echo -e "\nERROR in ${0}: ${@:-(unknown)}\n"
}

show_log_digest() {

    echo -e "\n--> Log digest:\n"
    grep -Po "${_regex_log_digest}" "${_ci_builder_log}" | sort -u
    echo
}

show_log_stickers() {

    echo -e "\n--> Version stickers:\n"
    grep "${_regex_log_stickers}" "${_ci_builder_log}" | sort -u
    echo
}

show_log_timing() {

    echo -e "\n--> Building timing:\n"
    grep -P "${_regex_log_timing}" "${_ci_builder_log}"
    echo
}

show_log_errors() {

    echo -e "\n--> Building errors and warnings:\n"
    grep -iPn "${_regex_log_errors}" "${_ci_builder_log}"
    echo
}

show_unlogged_help() {

    # help is never logged
    exec 1>&-
    {
        cat <<EOT

This script can:
    - build sets of images using the builder script '${_builder_script}'
    - extract selected information from the log

Usage: <script> <mode> <argument> [<optional-argument>]...

    ${0} [<options>] <command> group <blend> [<blend>]...
    ${0} [<options>] <command> family <parent-blend> [<child-suffix>]...
    ${0} [--log-all] log get (digest|stickers|timing|errors)

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
EOT
    } >&3

    # Examples of family mode:
    # Build and publish all blends, not using the Docker builder cache:
    #     ${0} --no-cache all family complete
    # Build the 'latest' and 'latest-ver2' blends, but skip the publishing:
    #     ${0} all-no-push family latest -ver2
    # Build and publish only the 'latest-firefox' and 'latest-firefox-ver2' blends:
    #     ${0} all family latest-firefox -ver2
    # Build and publish only the 'latest' and 'latest-firefox-ver2' blends:
    #     ${0} all family latest -firefox-ver2

    # Examples of group mode:
    # Build and publish all blends:
    #     ${0} all group complete
    # Build the 'latest' and 'latest-ver2' blends, but skip the publishing:
    #     ${0} all-no-push group latest latest-ver2
    # Build and publish the images containing Firefox:
    #     ${0} all group complete-firefox

    # Other examples:
    # Build only the 'latest' blend and skip the publishing:
    #     ${0} all-no-push family latest
    #     ${0} all-no-push group latest
    # Display log digest:
    #     ${0} log get digest
    # Display version stickers of newly built images:
    #     ${0} log get stickers
    # Display building timing:
    #     ${0} log get timing
    # Display building errors:
    #     ${0} log get errors
}

build_single_image() {
    local command="${1?Expected command}"
    local blend="${2?Expected blend}"
    local option_nocache="${3}"
    local -i exit_code=0

    if [[ "${command}" == "pull" ]]; then

        "${_build_context}/hooks/${_helper_script}" dev "${blend}" pull

    elif [[ "${command}" == "update-gists" ]]; then

        "${_build_context}/hooks/post_push" dev "${blend}"

    elif [[ "${command}" == "list" ]]; then

        "${_build_context}/hooks/${_helper_script}" dev "${blend}" list

    elif [[ "${command}" == "helper-help" ]]; then

        "${_build_context}/hooks/${_helper_script}" dev "${blend}" help

    else
        echo -e "${_log_mark} Building image '${_builder_project}:${blend}'"

        ### call builder script
        ./"${_builder_script}" "${blend}" "${command}" "${option_nocache}"
        exit_code=$?
        if [[ ${exit_code} -ne 0 ]]; then die "Script '${_builder_script}' failed with code ${exit_code}." ${exit_code}; fi

        if [[ $(tail "${_builder_log}" | grep -c "==> No build needed for '${blend}'") -eq 1 ]]; then
            echo -e "${_log_mark} No build needed for '${_builder_project}:${blend}'."
        else
            case "${command}" in
            all-no-push)
                if [[ $(tail "${_builder_log}" | grep -c "==> Built '${blend}'") -eq 1 ]]; then
                    echo -e "${_log_mark} Built new '${_builder_project}:${blend}'."
                else
                    echo -e "${_log_mark} Failed to build new '${_builder_project}:${blend}'."
                fi
                ;;
            all)
                if [[ $(tail "${_builder_log}" | grep -c "==> Published '${blend}'") -eq 1 ]]; then
                    echo -e "${_log_mark} Published new '${_builder_project}:${blend}'."
                else
                    echo -e "${_log_mark} Failed to publish new '${_builder_project}:${blend}'."
                fi
                ;;
            *)
                die "Unknown command: '${command}'"
                ;;
            esac
        fi
    fi
}

build_family() {
    local command="${1?Expected command}"
    local parent="${2?Expected parent blend}"

    if [[ $# -ge 2 ]]; then shift 2; fi

    ### note that the option '--no-cache' is passed in by the parent image
    build_single_image "${command}" "${parent}" "${_option_nocache}"

    ### if the parent probe succeeded then probe the children
    if [[ $(tail "${_builder_log}" | grep -cE "==> (Published|Built) '${parent}'") -eq 1 ]]; then
        for child in $@; do

            # note that we do not pass in the option '--no-cache' by children
            build_single_image "${command}" "${parent}${child}"
        done
    fi
}

build_group() {
    local command="${1?Expected command}"

    if [[ $# -gt 0 ]]; then shift; fi

    for blend in $@; do

        # note that the option '--no-cache' is passed in by each image
        build_single_image "${command}" ${blend} "${_option_nocache}"
    done
}

main() {

    if [[ $# -eq 0 ]]; then

        show_unlogged_help
        return 0
    fi

    ### parse command options
    while [[ $# -gt 0 && "${1}" =~ "--" ]]; do

        case "${1}" in

        --no-cache) _option_nocache="${1}" ;;
        --log-all) _option_logall="${1}" ;;

        *)
            execute_smart show_error "Unknown option '${1}'"
            return 1
            ;;
        esac

        shift
    done

    local command="${1}"
    local mode="${2}"
    local subject="${3}"

    local -a list=()

    if [[ $# -ge 3 ]]; then shift 3; fi

    case "${command}" in

    help | --help | -h)

        show_unlogged_help
        return 0
        ;;

    log)
        case "${mode}" in

        get)

            case "${subject}" in

            digest) execute_smart show_log_digest ;;
            stickers) execute_smart show_log_stickers ;;
            timing) execute_smart show_log_timing ;;
            errors) execute_smart show_log_errors ;;
            *)
                execute_smart show_error "Unknown 'log get' command argument '${subject}'"
                ;;
            esac
            ;;

        *)
            execute_smart show_error "Unknown 'log' command '${mode}'"
            ;;

        esac
        ;;

    all-no-push | all | pull | update-gists | list | helper-help)
        case "${mode}" in

        family)
            case "${subject}" in

            complete)

                clear_log

                build_family "${command}" vscode -chromium -firefox

                build_family "${command}" nvm -chromium
                build_family "${command}" nvm-vscode -chromium -firefox

                build_family "${command}" python -chromium
                build_family "${command}" python-vscode -chromium -firefox

                # build_family "${command}" postman -chromium -firefox

                # build_family "${command}" nodejs -chromium
                # build_family "${command}" nodejs-vscode -chromium -firefox
                # build_family "${command}" nodejs-current
                ;;

            latest | vscode | nvm | python | postman | nodejs)

                clear_log
                build_family "${command}" "${subject}" $@
                ;;

            *)
                execute_smart show_error "Unknown parent blend '${subject}'"
                ;;

            esac
            ;;

        group)
            case "${subject}" in

            pivotal)

                clear_log
                # build_group "${command}" "vscode" "nvm" "python" "postman" "nodejs" "nodejs-current"
                build_group "${command}" "vscode" "nvm" "python"
                ;;

            complete-chromium)

                clear_log
                # list+=( "vscode-chromium" "nvm-chromium" "nvm-vscode-chromium" "python-chromium" "python-vscode-chromium" "postman-chromium" "nodejs-chromium" "nodejs-vscode-chromium" )
                list+=("vscode-chromium" "nvm-chromium" "nvm-vscode-chromium" "python-chromium" "python-vscode-chromium")
                build_group "${command}" "${list[@]}"
                ;;

            complete-firefox)

                clear_log
                # build_group "${command}" "vscode-firefox" "nvm-vscode-firefox" "python-vscode-firefox" "postman-firefox" "nodejs-vscode-firefox"
                build_group "${command}" "vscode-firefox" "nvm-vscode-firefox" "python-vscode-firefox"
                ;;

            complete-vscode)

                clear_log
                list+=("vscode" "vscode-chromium" "vscode-firefox")
                build_group "${command}" "${list[@]}"
                ;;

            complete-vscode-all)

                clear_log
                list+=("vscode" "vscode-chromium" "vscode-firefox")
                list+=("nvm-vscode" "nvm-vscode-chromium" "nvm-vscode-firefox")
                list+=("python-vscode" "python-vscode-chromium" "python-vscode-firefox")
                # list+=( "nodejs-vscode" "nodejs-vscode-chromium" "nodejs-vscode-firefox" )
                build_group "${command}" "${list[@]}"
                ;;

            complete-nvm)

                clear_log
                list+=("nvm" "nvm-chromium" "nvm-vscode" "nvm-vscode-chromium" "nvm-vscode-firefox")
                build_group "${command}" "${list[@]}"
                ;;

            complete-python)

                clear_log
                list+=("python" "python-chromium" "python-vscode" "python-vscode-chromium" "python-vscode-firefox")
                build_group "${command}" "${list[@]}"
                ;;

            complete-postman)

                clear_log
                build_group "${command}" "postman" "postman-chromium" "postman-firefox"
                ;;

            complete-nodejs)

                clear_log
                list+=("nodejs" "nodejs-chromium" "nodejs-vscode" "nodejs-vscode-chromium" "nodejs-vscode-firefox" "nodejs-current")
                build_group "${command}" "${list[@]}"
                ;;

            complete)

                clear_log

                list+=("vscode" "vscode-chromium" "vscode-firefox")
                list+=("nvm" "nvm-chromium" "nvm-vscode" "nvm-vscode-chromium" "nvm-vscode-firefox")
                list+=("python" "python-chromium" "python-vscode" "python-vscode-chromium" "python-vscode-firefox")
                # list+=( "postman" "postman-chromium" "postman-firefox" )
                # list+=( "nodejs" "nodejs-chromium" "nodejs-vscode" "nodejs-vscode-chromium" "nodejs-vscode-firefox" "nodejs-current" )

                build_group "${command}" "${list[@]}"
                ;;

            vscode | vscode-chromium | vscode-firefox | \
                nvm | nvm-chromium | nvm-vscode | nvm-vscode-chromium | nvm-vscode-firefox | \
                python | python-chromium | python-vscode | python-vscode-chromium | python-vscode-firefox | \
                postman | postman-chromium | postman-firefox | \
                nodejs | nodejs-chromium | nodejs-vscode | nodejs-vscode-chromium | nodejs-vscode-firefox | nodejs-current)

                clear_log
                build_group "${command}" "${subject}" $@
                ;;

            any)
                echo "Warning from 'ci-builder.sh': Nothing to do for 'any' blend!"
                echo "Provided parameters:"
                echo "command=${command}"
                echo "subject=${subject}"

                build_group "${command}" "${subject}" $@
                ;;

            *)
                # execute_smart show_error "Unknown blend '${subject}'"
                die "Unknown blend '${_blend}'" -1 'ci-builder.sh'
                ;;

            esac
            ;;

        *)
            execute_smart show_error "Unknown mode '${mode}'"
            ;;

        esac
        ;;

    *)
        execute_smart show_error "Unknown command '${command}'"
        ;;
    esac

    if [[ -z "${_flag_skip_footer}" ]]; then

        echo -e "\n==> FINISHED  @$(date -u +'%Y-%m-%d_%H-%M-%S'): ${0} $@\n"
    fi
}

declare _builder_project="${BUILDER_REPO:-headless-coding-g3}"
declare _builder_log="scrap_builder.log"
declare _build_context="./docker"
declare _helper_script="helper"

declare _builder_script="builder.sh"
declare _ci_builder_log="scrap_ci-builder.log"

declare _log_mark="\n[CI-BUILDER]"

declare _regex_log_digest="(?<=\[CI-BUILDER\] ).+"
declare _regex_log_stickers="Current version sticker of "
declare _regex_log_timing="==> (EXECUTING @.*builder\.sh.*|FINISHED  @.*builder\.sh.*)"
declare _regex_log_errors="\berror\b|\bwarning\b|\bexiting at line\b"

declare _flag_skip_footer=""
declare _option_nocache=""
declare _option_logall=""

### duplicate 'stdout' so we can close it when needed
exec 3>&1

### main entry point
declare -i __exit_code=0

main $@ 2>&1 | tee -a "${_ci_builder_log}"

__exit_code=${PIPESTATUS[0]}

exit ${__exit_code}
