#############################
# Playground Sessions | Dev #
#############################
FROM jklz/pg-dev:base
LABEL maintainer="Jared Spencer <jared@playgroundsessions.com>"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# User America/Bosie for docker timezone
RUN sudo echo "America/Bosie" > /etc/timezone


WORKDIR "/application_setup"

# Install OS updates
RUN apt-get update;
RUN apt-get -y upgrade; \
    apt-get -y --no-install-recommends install \
        ansible \
        sudo \
        build-essential \
        git \
        curl \
# install items handled by ansible 
        ant \
        openssh-server \
#  Install Cypress dependencies
        xvfb \
        libgtk2.0-0 \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libasound2 \
        zip \
        unzip;


# tag local env for ansible
#RUN echo "[local]" >> /etc/ansible/hosts && \
#    echo "localhost" >> /etc/ansible/hosts && \
#    echo "[docker]" >> /etc/ansible/hosts && \
#    echo "localhost" >> /etc/ansible/hosts
# setup passwordless sudo
RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/passwordless-sudo;


# Set working directory
WORKDIR /application_setup/dev_setup

# Add Node.js PPA
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

# process installs at this level (node and php as both may need to be run)
RUN apt-get -y install \
# Install nodejs
        nodejs \
# Install PHP (force 7.2 for now)
        php7.2 \
        php7.2-cli \
        php-mysql \
        php-curl \
        php-simplexml \
        php-mbstring \
        php-intl \
        php-xdebug \
        php-zip;


# add new user to docker instance
RUN useradd -ms /bin/bash pgdev && \
    adduser pgdev sudo
# act as new user
USER pgdev
# set workdir to user home
WORKDIR /home/pgdev

# add dir for composer and node
RUN mkdir /home/pgdev/.composer -p && mkdir /home/pgdev/.npm -p;

# add volume for composer cache
VOLUME /home/pgdev/.composer
# add volume for node cache
VOLUME /home/pgdev/.npm


ENTRYPOINT /bin/bash;
