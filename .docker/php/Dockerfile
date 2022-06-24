FROM php:8.1-fpm

RUN apt-get update -y

RUN apt-get install \
    libicu-dev \
    zip \
    libzip-dev \
    gettext \
    git \
    vim \
    -y;

RUN docker-php-ext-install \
    pdo_mysql \
    zip \
    intl;

USER www-data

WORKDIR /srv/app

COPY --chown=www-data:www-data . .
