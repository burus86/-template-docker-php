# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION=8.1

# "php" stage
FROM php:${PHP_VERSION}-fpm

RUN apt-get update && apt-get install -y \
        git \
        wget \
        unzip \
        libaio1 \
        libpq-dev \
        libssh-dev \
        libonig-dev \
        libbz2-dev \
    && docker-php-ext-install \
        pcntl \
        mbstring \
        bcmath \
        mysqli \
        pdo \
        pdo_mysql \
        bz2

RUN apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install Symfony Local Web Server and Composer
RUN wget https://get.symfony.com/cli/installer -O - | bash && mv /root/.symfony/bin/symfony /usr/local/bin/symfony
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install APCu, OPcache and PCOV
RUN pecl install apcu \
        pcov \
    && docker-php-ext-enable apcu \
        opcache \
        pcov

# Copy PHP files
COPY php/ /usr/local/etc/php/

WORKDIR /var/www/

EXPOSE 8080

RUN ls -lisa /var/www
