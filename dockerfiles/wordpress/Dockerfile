FROM wordpress:fpm
MAINTAINER clh021@gmail.com
RUN apt update \
    && apt install -y apt-utils unzip libxml2-dev --no-install-recommends \
    && apt install $PHPIZE_DEPS && pecl install xdebug && docker-php-ext-enable xdebug \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt clean
