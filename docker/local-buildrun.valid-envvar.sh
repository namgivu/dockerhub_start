#!/usr/bin/env bash
SH=`cd $(dirname $BASH_SOURCE) && pwd`  # SH aka SCRIPT_HOME

cd $SH
    note='
    dockerimage     nn
    dockercontainer nn_c
    '
    set -e  # halt if error ON
        docker build \
                     --build-arg       ENV_TAG='DEV or UAT or PROD' \
                     --build-arg GIT_COMMIT_ID=`git log --oneline -n1 | cut -d' ' -f1` \
                     -t nn .
            echo
            docker stop -t0 nn_c || true; docker rm -f nn_c || true

            # run container with envvar ref. https://stackoverflow.com/a/55839775
            docker run -d --name nn_c nn
                echo
                docker exec nn_c bash -c "
                    [[ ! -z \$ENV_TAG       ]] && echo '      ENV_TAG=\$ENV_TAG'       || echo 'Not found env var ENV_TAG' ;
                    [[ ! -z \$GIT_COMMIT_ID ]] && echo 'GIT_COMMIT_ID=\$GIT_COMMIT_ID' || echo 'Not found env var GIT_COMMIT_ID' ;
                "
    set +e  # halt if error OFF
cd - 1>/dev/null
