FROM namgivu/ubuntu-pipenv:18.04-3.7
#FROM alpine

# rebuild flag
RUN echo 200527_x00

# create envvar ENV_TAG ie build environ ie DEV or UAT or PROD; this is passed in when start docker build ie via --build-arg
ARG ENV_TAG

# create envvar GIT_COMMIT_ID - to get this value we need git command that query .git/, this requires complex bash to passed in as --build-arg
ARG GIT_COMMIT_ID

# print buildtime args
RUN echo       ENV_TAG=$ENV_TAG
RUN echo GIT_COMMIT_ID=$GIT_COMMIT_ID


# broadcast as envvar in runtime
ENV       ENV_TAG=$ENV_TAG
ENV GIT_COMMIT_ID=$GIT_COMMIT_ID

CMD tail -F `mktemp`

#TODO try build this with dockerhub build @ DEV branch new gitpush and with envvar at BUILD ENVIRONMENT VARIABLES
#TODO how to use keys added to BUILD ENVIRONMENT VARIABLES?
