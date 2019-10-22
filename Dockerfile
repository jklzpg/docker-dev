#############################
# Playground Sessions | Dev #
#############################
FROM ubuntu:trusty
MAINTAINER Jared Spencer <jared@playgroundsessions.com>

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive
# MySQL 5.6
FROM mysql:5.6
# PHP 7.2
FROM phpdockerio/php72-fpm
WORKDIR "/application"

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install apache2 php7.2-mysql php7.2-curl php7.2-redis php7.2-simplexml php7.2-mbstring php7.2-xdebug php7.2-zip php7.2-intl \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
