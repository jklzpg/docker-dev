##########################################
# Playground Sessions | Full Enviroment #
##########################################
FROM jklz/pg-dev:php72 
LABEL maintainer="Jared Spencer <jared@playgroundsessions.com>"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR "/application_run"
# tag local env for ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
    echo "[docker]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts && \
# setup passwordless sudo
    echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/passwordless-sudo;

# install nodejs
 RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
 RUN apt-get -y install \
        nodejs;

# Install build-essential
RUN apt-get -y --no-install-recommends install \
        build-essential \
# install items handled by openssh-server 
        openssh-server \
#  Install Cypress dependencies
        xvfb \
        libgtk2.0-0 \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libasound2;


# add new user to docker instance
RUN useradd -ms /bin/bash pgdev && \
    adduser pgdev sudo
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
