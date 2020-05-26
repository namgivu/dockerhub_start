# intro
goal: auto build docker image on the event of new push occurred on a given branch

official dockerhub manual 
ref. https://docs.docker.com/docker-hub/builds/
ref. https://docs.docker.com/docker-hub/builds/advanced/#environment-variables-for-building-and-testing

# 00 create a repo on docker hub 
create a repo on docker hub associated with this code repo 
ie having same name as :dockerhub_start
ie https://hub.docker.com/r/namgivu/dockerhub_start


# 01 new gitpush to DEV UAT PROD branch will build new dockerimage accordingly

## a create 3 branches DEV UAT PROD aka DUP branch
```bash
git checkout -b DEV;  git push --set-upstream origin DEV
git checkout -b UAT;  git push --set-upstream origin UAT
git checkout -b PROD; git push --set-upstream origin PROD
```

## b each DUP branch has its unique env var specified for it 
eg 
env var   DEV   UAT   PROD
--------  ----  ----  -----
ENV_TAG   DEV   UAT   PROD
ECHO_VAR  ddd   uuu   pppp

TODO where to define/store these env var?
[option1: use dockerhub Build env var](option1.use-dockerhub-build-envvar.md)
option2: use local .env file

## c1 local build+run Dockerfile
```bash
cd ./docker/            
    note='
    dockerimage     nn
    dockercontainer nn_c
    '
    docker build -t nn . ; echo ; docker stop nn_c; docker rm nn_c; docker run -d --name nn_c nn
        docker exec nn_c bash -c "
            [[ ! -z '$ENV_VAR' ]]  && echo ENV_VAR=$ENV_VAR   || echo 'Not found env var ENV_VAR' ; 
            [[ ! -z '$ECHO_VAR' ]] && echo ECHO_VAR=$ECHO_VAR || echo 'Not found env var ECHO_VAR' ; 
        "
    
```

## c2 remote build+run via dockerhub build
TODO

# TO BE CONTINUED...
