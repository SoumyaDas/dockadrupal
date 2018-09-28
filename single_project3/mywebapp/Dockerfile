FROM php:7.1-apache

# Install packages
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
    mcrypt

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ARG virtual_host

# Update the default apache site with the config we created.
COPY apache-config.conf /etc/apache2/sites-enabled/000-default.conf

COPY config/addcert.sh /usr/local/bin/addcert.sh
COPY config/addhost.sh /usr/local/bin/addhost.sh

ENV VIRTUAL_HOST $virtual_host
RUN chmod +x /usr/local/bin/addcert.sh
RUN /usr/local/bin/addcert.sh

#RUN chmod +x /usr/local/bin/addhost.sh
#RUN /usr/local/bin/addhost.sh

# Clean repository
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80
ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
