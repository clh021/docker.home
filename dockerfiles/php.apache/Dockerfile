FROM php:apache
MAINTAINER clh021@gmail.com
#暂时没有维护此文档，请参考tutum/lamp二次开发的文档，更省空间更省事
#配置环境变量
#ENV PATH $PATH:/root/.composer/vendor/bin
#修改阿里云镜像源访问速度会很快
RUN echo "deb http://mirrors.aliyun.com/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free" >> /etc/apt/sources.list

# Install PHP extensions
RUN apt-get update \
    && apt-get install -y apt-utils zlib1g-dev && docker-php-ext-install zip \
    && apt-get install -y mcrypt libmcrypt-dev && docker-php-ext-install mcrypt \
    && apt-get install -y libpng12-dev libfreetype6-dev libjpeg62-turbo-dev && docker-php-ext-install -j$(nproc) iconv mcrypt && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
    && apt-get install -y zlib1g-dev libicu-dev g++ && docker-php-ext-configure intl && docker-php-ext-install intl \
    && apt-get install -y libmagickwand-dev imagemagick --no-install-recommends && pecl install imagick-beta && pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini
RUN docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-ext-install sockets \
    && docker-php-ext-install exif \
    && pecl install apcu-4.0.10 && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini
# Enable mod_rewrite
RUN a2enmod rewrite \
    # Fix write permissions with shared folders
    && usermod -u 1000 www-data
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*
## 配置PHP环境
RUN cat /usr/src/php/php.ini-development | sed 's/^;\(date.timezone.*\)/\1 \"PRC\"/' > /usr/local/etc/php/conf.d/php.ini; \
    && sed -i 's/\(extension_dir = \)\"\.\/\"/\1\"\/usr\/local\/lib\/php\/extensions\/no-debug-non-zts-20060613\/\"/' /usr/local/etc/php/php.ini \
    && echo 'upload_max_filesize = 50M' >> /usr/local/etc/php/conf.d/php.ini \
    && echo 'post_max_size = 50M' >> /usr/local/etc/php/conf.d/php.ini \
    && echo 'max_execution_time = 0' >> /usr/local/etc/php/conf.d/php.ini \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

    # 安装xdebug
RUN  ln -s /usr/local/etc/php/conf.d/php.ini /usr/local/etc/php/php.ini -f \
    && pecl install xdebug-beta; \
    && docker-php-ext-enable xdebug \
    #echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" >> /usr/local/etc/php/conf.d/php.ini;
    && echo "xdebug.remote_enable=on";  >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=192.168.59.3" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=On" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_mode = \"req\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=\"lcphpstormidekey\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=true" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_dir=\"/temp/profiledir\"" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "memory_limit = 64M" >> /usr/local/etc/php/conf.d/php.ini \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

# Next composer and global composer package, as their versions may change from time to time
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer.phar \
    && composer.phar global require --no-progress "fxp/composer-asset-plugin:~1.1.2" \
    && composer.phar global require --no-progress "codeception/codeception=2.0.*" \
    && composer.phar global require --no-progress "codeception/specify=*" \
    && composer.phar global require --no-progress "codeception/verify=*"


RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get --yes install \
        nodejs \
        build-essential \
        default-jre \
    && curl -sL https://www.npmjs.org/install.sh | bash - \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*


# Apache config and dev shell
# COPY apache2.conf /etc/apache2/apache2.conf
COPY lianghongdev.sh /var/www/html/lianghongdev.sh

RUN chown www-data:www-data -R /var/www/html/
USER www-data