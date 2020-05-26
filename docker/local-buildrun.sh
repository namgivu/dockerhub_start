#!/usr/bin/env bash
SH=`cd $(dirname $BASH_SOURCE) && pwd`  # SH aka SCRIPT_HOME

cd $SH/docker/
    note='
    dockerimage     nn
    dockercontainer nn_c
    '
    docker build -t nn . ; echo ; docker stop nn_c; docker rm nn_c; docker run -d --name nn_c nn
        docker exec nn_c bash -c "
            [[ ! -z '$ENV_VAR' ]]  && echo ENV_VAR=$ENV_VAR   || echo 'Not found env var ENV_VAR' ;
            [[ ! -z '$ECHO_VAR' ]] && echo ECHO_VAR=$ECHO_VAR || echo 'Not found env var ECHO_VAR' ;
        "
