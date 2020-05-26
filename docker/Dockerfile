FROM namgivu/ubuntu-pipenv:18.04-3.7

# rebuild flag
RUN echo 200527_x00

# create envvar ENV_VAR
ARG ENV_VAR
ENV ENV_VAR=$ENV_VAR

# create envvar ECHO_VAR
ARG ECHO_VAR
ENV ECHO_VAR=$ECHO_VAR

CMD tail -F `mktemp`
