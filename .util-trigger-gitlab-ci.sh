#!/bin/bash

### This script triggers the pipeline from the given branch or tag in the local GitLab repository.

### TIP: Exclude this script from commits by renaming it to '.util-trigger-gitlab-ci.sh'

### Required environment variable: GITLAB_PIPELINE_TRIGGER_TOKEN (real secret!)

declare pipeline_branch="${1?Need pipeline branch or tag}"
declare clone_branch="${2}"
declare g3_command_group="${3:-pivotal}"
declare g3_command="${4:-all-no-push}"
declare g3_environment="${5:-development}"

declare gitlab="${GITLAB_SERVER_BASE_URL}"
declare token="${GITLAB_PIPELINE_TRIGGER_TOKEN}"

if [[ -z "${GITLAB_SERVER_BASE_URL}" || -z "${GITLAB_PIPELINE_TRIGGER_TOKEN}" ]] ; then

    echo "Environment variables 'GITLAB_SERVER_BASE_URL' and/or 'GITLAB_PIPELINE_TRIGGER_TOKEN' are not set!"

else

    curl -X POST \
        --silent \
        --fail \
        --output /dev/null \
        -F token="${GITLAB_PIPELINE_TRIGGER_TOKEN}" \
        -F "ref=${pipeline_branch}" \
        -F "variables[G3_BUILD_HEADLESS_UBUNTU_CODING]=1" \
        -F "variables[G3_BRANCH_HEADLESS_UBUNTU_CODING]=${clone_branch}" \
        -F "variables[G3_ENVIRONMENT]=${g3_environment}" \
        -F "variables[G3_COMMAND]=${g3_command}" \
        -F "variables[G3_COMMAND_GROUP]=${g3_command_group}" \
    "${GITLAB_SERVER_BASE_URL}/api/v4/projects/11/trigger/pipeline"

    echo -e "\nTriggered pipeline from branch/tag '${pipeline_branch}'.\n"
fi
