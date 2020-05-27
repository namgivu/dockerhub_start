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
GIT_COMMIT_ID  ddd   uuu   pppp

TODO where to define/store these env var?
[option1: use dockerhub Build env var](option1.use-dockerhub-build-envvar.md)
option2: use local .env file

## c1 local build+run Dockerfile
view or run
00 [not found envvar](../../docker/local-buildrun.notfound.sh)
01 [valid envvar](../../docker/local-buildrun.valid-envvar.sh)

## c2 remote build+run Dockerfile via dockerhub build
```bash
# trigger remote build by merge master to D U P branch
trigger_dockerhub_build() {
    [[ ! -z $1 ]] && target_branch=$1 || echo 'Param :target_branch is required as $1'  
    
    cb=`git branch | grep '*' | cut -d' ' -f2`  # cb aka current_branch
        git fetch && git checkout master && git pull
            git checkout $target_branch && git pull && git merge master && git push origin $target_branch
                echo 'dockerhub autobuild should be triggered and running now at https://hub.docker.com/r/namgivu/dockerhub_start/builds'
    git checkout $cb
}
    trigger_dockerhub_build DEV
    trigger_dockerhub_build UAT
    trigger_dockerhub_build PROD

# run those D U P remote built images 
docker pull namgivu/dockerhub_start:DEV;   
    clear_c() { docker stop -t1 $1; docker rm -f $1; }
    # image name                      container name   command run in container to print envvar                                       clear previous if any         get latest image      run the container                                       echo the envvar                                   clean up container
    i='namgivu/dockerhub_start:DEV';  c='dhs_DEV';     cmd_print_envvar='echo ENV_TAG=$ENV_TAG; echo GIT_COMMIT_ID=$GIT_COMMIT_ID';   clear_c $c;             echo; docker image pull $i; docker run -d --name $c $i; docker exec $c sh -c "$cmd_print_envvar"; echo; clear_c $c
    i='namgivu/dockerhub_start:UAT';  c='dhs_UAT';     cmd_print_envvar='echo ENV_TAG=$ENV_TAG; echo GIT_COMMIT_ID=$GIT_COMMIT_ID';   clear_c $c;             echo; docker image pull $i; docker run -d --name $c $i; docker exec $c sh -c "$cmd_print_envvar"; echo; clear_c $c
    i='namgivu/dockerhub_start:PROD'; c='dhs_PROD';    cmd_print_envvar='echo ENV_TAG=$ENV_TAG; echo GIT_COMMIT_ID=$GIT_COMMIT_ID';   clear_c $c;             echo; docker image pull $i; docker run -d --name $c $i; docker exec $c sh -c "$cmd_print_envvar"; echo; clear_c $c
    
    #TODO we see empty envvar even we added keys to BUILD ENVIRONMENT VARIABLES
```

we can get [dockerhub build notification in slack channel](./get-dockerhub-build-notify-in-slackchanel.png)

# TO BE CONTINUED...
