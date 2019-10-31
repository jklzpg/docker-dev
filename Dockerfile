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
        sudo \
        nodejs \
        build-essential \
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
# tag local env for ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
    echo "[docker]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts;
# setup passwordless sudo
RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/passwordless-sudo
# add new user to docker instance
RUN useradd -ms /bin/bash pgdev && adduser pgdev sudo
# act as new user
USER pgdev
# set workdir to user home
WORKDIR /home/pgdev

# add dir for composer and node
RUN mkdir /home/pgdev/.composer -p && mkdir /home/pgdev/.npm;

# add volume for composer cache
VOLUME /home/pgdev/.composer
# add volume for node cache
VOLUME /home/pgdev/.npm


ENTRYPOINT /bin/bash;
