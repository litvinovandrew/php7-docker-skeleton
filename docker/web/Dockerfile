FROM php:7.1-apache

MAINTAINER Maxim Virchenko <muslim1992@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ARG HOST_UID=1000
ARG HOST_IP=0.0.0.0

RUN echo Europe/Kiev > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
        zlib1g-dev \
        libicu-dev \
        libpq-dev \
        git \
        subversion \
        cron \
        mc \
        dos2unix \
        htop \
	    bzip2 \
	    sudo \
	    libxml2-dev \
	    libfontconfig \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        wget \
        sendmail \
        sasl2-bin

# Install calendar
RUN docker-php-ext-install calendar

# Install mcrypt
RUN docker-php-ext-install -j$(nproc) iconv mcrypt

# Install pdo
RUN apt-get install -y mysql-client
RUN docker-php-ext-install pdo_mysql mysqli

# Install zip
RUN apt-get install -y zip
RUN docker-php-ext-install zip

# Install gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

# Install opcache
RUN docker-php-ext-install opcache

# Install exts
RUN docker-php-ext-install intl pcntl exif mbstring soap

# Install xdebug
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\nxdebug.remote_autostart=on\nxdebug.remote_enable=on\nxdebug.remote_host=\"${HOST_IP}\"\nxdebug.remote_port=9001" \
    > /usr/local/etc/php/conf.d/xdebug.ini

# Install Apache
COPY ./.bashrc /root/.bashrc
COPY ./apache.conf /etc/apache2/sites-available/000-default.conf
COPY ./php.ini /usr/local/etc/php/

RUN echo "LogFormat \"%a %l %u %t \\\"%r\\\" %>s %O \\\"%{User-Agent}i\\\"\" mainlog" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite remoteip

# Install
RUN curl -sS -o /root/.bash_aliases https://raw.githubusercontent.com/morontt/dotfiles/master/ubuntu/.bash_aliases

# Install composer
RUN set -x && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Add crontab
COPY ./crontab /var/www/crontab

# Add permission for www-data
RUN usermod -u ${HOST_UID} www-data \
    && groupmod -g ${HOST_UID} www-data

# Copy user data
RUN chsh -s /bin/bash www-data \
    && cp /root/.bashrc /var/www \
    && cp /root/.bash_aliases /var/www \
    && cp -r /root/.composer /var/www \
    && dos2unix -o /root/.bashrc /root/.bash_aliases /var/www/.bashrc /var/www/.bash_aliases /var/www/crontab \
    && crontab -u www-data /var/www/crontab

# Change owner
RUN chown -R www-data:www-data /var/www

VOLUME ["/var/www/html"]

EXPOSE 80 1357 9001

# Add new startap point for apache2+cron
COPY ./startup.sh /var/www/startup.sh
RUN dos2unix -o /var/www/startup.sh
CMD ["/bin/bash", "/var/www/startup.sh"]