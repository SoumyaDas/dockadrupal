FROM php:7.4-apache

LABEL name="SoumyaDas/app-server"
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
    libzip-dev \
    zip \
    mariadb-client \
    libonig-dev \
    zlib1g-dev \
    sendmail \
    libpng-dev \
    mcrypt \
    libxml2-dev

RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install xml
#RUN docker-php-ext-install pear
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install opcache
RUN docker-php-ext-install soap

RUN apt-get install libpcre3 libpcre3-dev -y
RUN pecl install oauth -y

RUN apt-get install openssl -y
RUN a2enmod rewrite
RUN a2enmod ssl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require drush/drush:8.*
RUN export PATH="$HOME/.config/composer/vendor/bin:$PATH"
RUN source ~/.bashrc
#ENV PATH /root/.composer/vendor/bin:${PATH}

## Argument list.

ARG virtual_host


## Manually set up the apache environment variables

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV VIRTUAL_HOST $virtual_host
ENV VIRTUAL_PROTO http
ENV VIRTUAL_PORT 80

## Update the default apache site with the config we created.

COPY certs/$virtual_host.pem /usr/local/bin/$virtual_host.pem
COPY certs/$virtual_host.key /usr/local/bin/$virtual_host.key
COPY config/custom-php-settings.ini /usr/local/etc/php/conf.d/custom-php-settings.ini
COPY config/apache-config.conf /etc/apache2/sites-enabled/000-default.conf


## Clean repository

#RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80

ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
