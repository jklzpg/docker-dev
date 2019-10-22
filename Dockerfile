#############################
# Playground Sessions | Dev #
#############################
FROM phpdockerio/php72-fpm
MAINTAINER Jared Spencer <jared@playgroundsessions.com>

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR "/application"

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install ansible git apache2 php7.2-mysql php7.2-curl php7.2-redis php7.2-simplexml php7.2-mbstring php7.2-xdebug php7.2-zip php7.2-intl \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# If dev playbook exists then run
RUN if [ -f "/application/ansible/setup-new-development-environment.yml" ] ; then echo 'Run Playbook'; ansible-playbook ansible/setup-new-development-environment.yml; else echo 'skip playbook'; fi
