#!/usr/bin/env bash
SH=`cd $(dirname $BASH_SOURCE) && pwd`  # SH aka SCRIPT_HOME

cd $SH
    note='
    dockerimage     nn
    dockercontainer nn_c
    '
    set -e  # halt if error ON
        docker build -t nn . ; docker stop -t0 nn_c || true ; docker rm -f nn_c || true ; docker run -d --name nn_c nn
            echo
            docker exec nn_c bash -c "
                [[ ! -z \$ENV_VAR       ]] && echo ENV_VAR=\$ENV_VAR             || echo 'Not found env var ENV_VAR' ;
                [[ ! -z \$GIT_COMMIT_ID ]] && echo GIT_COMMIT_ID=\$GIT_COMMIT_ID || echo 'Not found env var GIT_COMMIT_ID' ;
            "
    set +e  # halt if error OFF
cd - 1>/dev/null
