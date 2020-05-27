#!/usr/bin/env bash
docstring='
ref. https://docs.docker.com/docker-hub/builds/advanced/#override-build-test-or-push-commands
ref. https://docs.docker.com/docker-hub/builds/advanced/#build-hook-examples
'

SH=`cd $(dirname $BASH_SOURCE) && pwd`  # aka SCRIPT_HOME
AH=`cd "$SH/../.." && pwd`  # aka APP_HOME

docker build \
             --build-arg       ENV_TAG=`git branch | grep '*' | cut -d' ' -f2` \
             --build-arg GIT_COMMIT_ID=`git log --oneline -n1 | cut -d' ' -f1` \
             -f $DOCKERFILE_PATH   -t $IMAGE_NAME   $AH

#TODO consider SOURCE_COMMIT SOURCE_BRANCH ref. https://docs.docker.com/docker-hub/builds/advanced/#environment-variables-for-building-and-testing
