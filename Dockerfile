FROM php:5.6
MAINTAINER harryosmar <harryosmarsitohang@gmail.com>

# Configured timezone.
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV TZ=Asia/Jakarta

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install OS packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    zlib1g-dev \
    libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
    libmemcached-dev \
    libicu-dev \
    g++
    
RUN pecl install memcached-2.2.0

RUN docker-php-ext-configure intl

RUN docker-php-ext-install gd mcrypt mysqli pdo pdo_mysql mbstring bcmath intl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/composer

RUN apt-get autoclean && apt-get clean && du -sh /var/cache/apt/archives && apt-get autoremove

WORKDIR /var/www/html

CMD ["php", "-a"]