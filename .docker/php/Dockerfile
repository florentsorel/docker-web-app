FROM php:8.1-fpm

RUN apt-get update -y

RUN apt-get install \
    libicu-dev \
    zip \
    libzip-dev \
    gettext \
    git \
    -y;

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN docker-php-ext-install \
    pdo_mysql \
    zip \
    intl;

WORKDIR /srv/app
