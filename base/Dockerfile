#############################
# Playground Sessions | Base #
#############################
FROM ubuntu:18.04 
LABEL maintainer="Jared Spencer <jared@playgroundsessions.com>"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Make sure we have a directory for current step
RUN mkdir /application_setup/base -p

WORKDIR "/application_setup/base"

# Install OS updates
RUN apt-get update;
RUN apt-get -y upgrade; \
# Install ansible, sudo, git, curl, ant, zip, unzip
    apt-get -y --no-install-recommends install \
        ansible \
        sudo \
        git \
        curl \
        ant \
        zip \
        unzip;

WORKDIR "/application_setup"

ENTRYPOINT /bin/bash;
