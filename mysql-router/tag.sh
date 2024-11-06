#!/bin/bash
# Copyright (c) 2021, 2023 Oracle and/or its affiliates.
#
set -e
source VERSION

SUFFIX='' [ -n "$1" ] && SUFFIX=$1
WEEKLY='' [ -n "$2" ] && WEEKLY=$2
MAJOR_VERSIONS=("${!MYSQL_ROUTER_VERSIONS[@]}"); [ -n "$3" ] && MAJOR_VERSIONS=("${@:3}")

for MAJOR_VERSION in "${MAJOR_VERSIONS[@]}"; do
    if [ "$WEEKLY" == "1" ]; then
      ROUTER_VERSION=${WEEKLY_ROUTER_VERSIONS["${MAJOR_VERSION}"]}
    else
      ROUTER_VERSION=${MYSQL_ROUTER_VERSIONS["${MAJOR_VERSION}"]}
    fi
    FULL_ROUTER_VERSION="${ROUTER_VERSION}-${IMAGE_VERSION}"
    MAJOR_VERSION=${ROUTER_VERSION%.*}
    TAGS="${MAJOR_VERSION}${SUFFIX} ${ROUTER_VERSION}${SUFFIX} ${FULL_ROUTER_VERSION}${SUFFIX}"
    if [[ "$MAJOR_VERSION" == "$LATEST" ]]; then
        TAGS="$TAGS latest${SUFFIX}"
    fi
    echo $TAGS
done
