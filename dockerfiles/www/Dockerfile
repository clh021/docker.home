FROM wordpress:latest
MAINTAINER clh021@gmail.com
# 这是一个基于wordpress镜像构建的主力工作镜像
# source 优化
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
# 常用程序添加
RUN apt-get update
RUN apt-get install -y -q --no-install-recommends \
        wget \
        gnupg \
        tree \
        htop \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        python \
        rsync \
        software-properties-common \
        devscripts \
        autoconf \
        ssl-cert \
    && apt-get clean
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
# 常用组件程序 composer wp
RUN cd /usr/local/bin/ && /usr/bin/curl -sS https://getcomposer.org/installer | /usr/local/bin/php
RUN /bin/mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN sed -i 's/www:\/usr\/sbin\/nologin/www:\/bin\/bash/g' /etc/passwd
RUN chown www-data:www-data -Rf /var/www
USER www-data
# 设置composer镜像地址
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
# 安装常用库
# 谷歌官方
RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global' && NPM_CONFIG_PREFIX=~/.npm-global
RUN npm install --global puppeteer
RUN composer global require "laravel/installer"
COPY .bashrc /var/www/
USER root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
