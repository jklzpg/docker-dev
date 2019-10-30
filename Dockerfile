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

# install items handled by ansible 
RUN apt-get -y --no-install-recommends install \
    redis-server \
    ant \
    openssh-server;
#  Install Cypress dependencies
RUN apt-get -y --no-install-recommends install \
    xvfb \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2
# install PHP for enviroment
RUN apt-get -y install \
    php7.2 \
    php7.2-cli \
    php-mysql \
    php-curl \
    php-redis \
    php-simplexml \
    php-mbstring \
    php-intl \
    php-zip;

RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
    echo "[docker]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts;
RUN mkdir /home/root/.composer -p;

ENTRYPOINT /bin/bash;
