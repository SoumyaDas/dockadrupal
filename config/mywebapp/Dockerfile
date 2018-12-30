FROM php:7.1-apache

LABEL name="SoumyaDas/nginx-proxy"
LABEL version="1.0.0"
LABEL maintainer="ssdas@live.in"

## Install packages

RUN rm /bin/sh && \
    ln -s /bin/bash /bin/sh && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
    curl \
    wget \
    vim \
    git \
    unzip \
    mysql-client \
    zlib1g-dev \
    sendmail \
    libpng-dev \
    mcrypt \
    libxml2-dev

RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install soap

RUN apt-get install libpcre3 libpcre3-dev -y
RUN pecl install oauth -y

RUN apt-get install openssl -y
#RUN a2enmod rewrite
RUN a2enmod ssl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Argument list.

ARG virtual_host


## Manually set up the apache environment variables

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV VIRTUAL_HOST $virtual_host
ENV VIRTUAL_PROTO https
ENV VIRTUAL_PORT 443

## Update the default apache site with the config we created.

COPY certs/demoserver.com.pem /usr/local/bin/demoserver.com.pem
COPY certs/demoserver.com.key /usr/local/bin/demoserver.com.key
COPY config/custom-php-settings.ini /usr/local/etc/php/conf.d/custom-php-settings.ini
COPY config/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

RUN ln -s /drush/drush /usr/local/bin/drush

## Clean repository

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 443

ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
