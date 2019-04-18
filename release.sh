#!/bin/bash
set -e

# Taken from https://github.com/semver/semver/issues/232
SEMVER_REGEX="^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(-(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\+[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)?$"

LAST_TAG=$(git describe --tags --abbrev=0)
NEW_TAG=$LAST_TAG

MAJOR=0
MINOR=0
PATCH=0

DRY_RUN="true"

if [[ ${LAST_TAG} =~ ${SEMVER_REGEX} ]]; then
    MAJOR=${BASH_REMATCH[1]}
    MINOR=${BASH_REMATCH[2]}
    PATCH=${BASH_REMATCH[3]}
    REST=${BASH_REMATCH[4]}
    echo "Latest tag found: ${LAST_TAG}"
else
    echo
    echo "The latest tag could not be parsed correctly. Are you following SemVer?"
    echo
    exit 1
fi

increase_major () {
    ((NEW_MAJOR=MAJOR+1))
    NEW_TAG=$NEW_MAJOR.$MINOR.$PATCH
    if [[ -e $REST ]]; then
        NEW_TAG=$NEW_TAG.$REST
    fi
    echo
    echo "Increasing major version from ${MAJOR} to ${NEW_MAJOR}"
    echo "The new tag will be ${NEW_TAG}"

    if [[ $DRY_RUN ]]; then
        echo "Running dry"
    else
        echo "Going serious"
    fi
}

increase_minor () {
    ((NEW_MINOR=MINOR+1))
    NEW_TAG=$MAJOR.$NEW_MINOR.$PATCH
    if [[ -e $REST ]]; then
        NEW_TAG=$NEW_TAG.$REST
    fi
    echo
    echo "Increasing minor version from ${MINOR} to ${NEW_MINOR}"
    echo "The new tag will be ${NEW_TAG}"
}

increase_patch () {
    ((NEW_PATCH=PATCH+1))
    NEW_TAG=$MAJOR.$MINOR.$NEW_PATCH
    if [[ -e $REST ]]; then
        NEW_TAG=$NEW_TAG.$REST
    fi
    echo
    echo "Increasing patch version from ${PATCH} to ${NEW_PATCH}"
    echo "The new tag will be ${NEW_TAG}"
}

init () {
    git tag 0.0.0
}

create_new_tag () {
    echo
    echo $LAST_TAG
    echo $NEW_TAG
}

show_help () {
    echo "Usage:"
    echo "  semver <action> <part>"
    echo
    echo "<action> can be any of the following:"
    echo "  increase"
    echo
    echo "<part> can be any of the following:"
    echo "  major, minor, patch"
}

# Main script
ACTION=$1
RESOURCE=$2

case $ACTION:$RESOURCE in
increase:major) increase_major;;
increase:minor) increase_minor;;
increase:patch) increase_patch;;
*) show_help;;
esac
