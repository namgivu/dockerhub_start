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
a create 3 branches DEV UAT PROD aka DUP branch

b each DUP branch has its unique env var specified for it 
eg 
env var   DEV   UAT   PROD
--------  ----  ----  -----
ENV_TAG   DEV   UAT   PROD
ECHO_VAR  ddd   uuu   pppp

TODO where to define/store these env var?
option1: use dockerhub Build env var
option2: use local .env file


# TO BE CONTINUED...
