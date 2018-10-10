FROM wordpress:php7.2-fpm
MAINTAINER clh021@gmail.com
RUN apt update && apt install -y apt-utils unzip libxml2-dev --no-install-recommends && apt install $PHPIZE_DEPS && pecl install xdebug-2.6.1 && docker-php-ext-enable xdebug
