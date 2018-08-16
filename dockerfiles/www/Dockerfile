FROM wordpress:latest
MAINTAINER clh021@gmail.com
# 这是一个基于wordpress镜像构建的主力工作镜像
# source 优化
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 安装常用程序
# 安装nodejs基础库
RUN apt-get update \
    && apt-get install -y -q --no-install-recommends vim wget tree htop curl git golang sshpass zip unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
RUN apt-get update \
    && apt-get install -y -q --no-install-recommends build-essential gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y -q --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
# RUN apt-get install -y -q --no-install-recommends \
#         libgconf-2-4 \
#         rsync \
#         apt-transport-https \
#         build-essential \
#         ca-certificates \
#         ssl-cert \
#         libssl-dev \
#         python \
#         software-properties-common \
#         devscripts \
#         autoconf \
#         default-jdk \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get clean
# 谷歌官方
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#     && apt-get update \
#     && apt-get install -y google-chrome-unstable --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get clean
# 常用组件程序 composer wp
RUN cd /usr/local/bin/ && /usr/bin/curl -sS https://getcomposer.org/installer | /usr/local/bin/php
RUN /bin/mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN sed -i 's/www:\/usr\/sbin\/nologin/www:\/bin\/bash/g' /etc/passwd
RUN chown www-data:www-data -Rf /var/www
USER www-data
# 工具
RUN mkdir /var/www/kod/ && mkdir /var/www/html/_/ && wget -O /var/www/kod/kod.zip http://static.kodcloud.com/update/download/kodexplorer4.32.zip && unzip /var/www/kod/kod.zip -d /var/www/kod/
# 设置composer镜像地址
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
# 安装常用库
# npm 库
RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global' && NPM_CONFIG_PREFIX=~/.npm-global
RUN npm install --global yarn #puppeteer phantomjs casperjs
# composer 库
RUN composer global require "laravel/installer"
# RUN composer global require "phpcasperjs/phpcasperjs"
# RUN composer global require "sunra/php-simple-html-dom-parser"
# 常用配置
COPY .bashrc /var/www/
COPY .gitignore /var/www/
COPY .gitconfig /var/www/
COPY puppeteer.test.js /var/www/
COPY .npmrc /var/www/
USER root
RUN chown www-data:www-data /var/www/.bashrc /var/www/.gitignore /var/www/.gitconfig /var/www/.npmrc
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
