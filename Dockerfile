#############################
# Playground Sessions | Dev #
#############################
# FROM ubuntu:18.04
FROM mysql:5.6
MAINTAINER Jared Spencer <jared@playgroundsessions.com>

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR "/application"

# Install OS updates
RUN apt-get update; \
    apt-get -y upgrade; \
    apt-get update; \
    apt-get -y --no-install-recommends install \
        build-essential \
        dkms \
        ansible \
        git; \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
    echo "local" >> /etc/ansible/hosts;

ENTRYPOINT /bin/bash;
