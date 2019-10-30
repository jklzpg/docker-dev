#############################
# Playground Sessions | Dev #
#############################
FROM ubuntu:18.04
MAINTAINER Jared Spencer <jared@playgroundsessions.com>

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR "/application"

# Install OS updates
RUN apt-get update;
RUN apt-get -y upgrade; \
    apt-get -y --no-install-recommends install \
        ansible \
        git;
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
    echo "[docker]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts;
RUN mkdir /home/root/.composer -p;

ENTRYPOINT /bin/bash;
