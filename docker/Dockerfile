# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION=8.4.1
ARG ALPINE_VERSION=3.20

# "php" stage
FROM php:${PHP_VERSION}-fpm-alpine${ALPINE_VERSION}

RUN apk update && apk add --no-cache \
        git \
        wget \
        unzip \
        libaio \
        postgresql-dev \
        libssh \
        oniguruma-dev \
        bzip2-dev \
        sudo \
        shadow \
    && docker-php-ext-install \
        pcntl \
        mbstring \
        bcmath \
        mysqli \
        pdo \
        pdo_mysql \
        bz2

RUN apk add --no-cache zlib-dev icu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install Symfony Local Web Server
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | sh
RUN apk add --no-cache symfony-cli

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data
RUN apk cache clean && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Install APCu and OPcache
RUN apk add --no-cache \
        autoconf \
        g++ \
        make \
        php-pear
RUN pear channel-update pear.php.net
RUN pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable opcache

# Install PCOV from GitHub
#RUN apk add --no-cache libpcre2-dev
#RUN git clone https://github.com/krakjoe/pcov.git /usr/src/php/ext/pcov \
#    && docker-php-ext-install pcov \
#    && docker-php-ext-enable pcov

# Copy PHP files
COPY php/ /usr/local/etc/php/

# Set timezone
ENV TIMEZONE=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

WORKDIR /var/www/

EXPOSE 8080

RUN ls -lisa /var/www
