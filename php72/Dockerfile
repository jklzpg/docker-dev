###########################################
# Playground Sessions | PHP7.2 Enviroment #
###########################################
FROM jklz/pg-dev:base
LABEL maintainer="Jared Spencer <jared@playgroundsessions.com>"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR "/application_run"

# install PHP for enviroment 
RUN apt-get -y install \
        php7.2 \
        php7.2-cli \
        php-mysql \
        php-curl \
        php-simplexml \
        php-mbstring \
        php-intl \
        php-zip;

ENTRYPOINT /bin/bash;
