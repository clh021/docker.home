FROM wordpress:latest
MAINTAINER clh021@gmail.com
# 这是一个基于wordpress镜像构建的主力工作镜像
# source 优化
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
# 安装常用程序
# apt-transport-https 可使https(比如源)免运营商劫持
RUN apt update \
    && apt install -y -q --no-install-recommends vim wget tree htop curl git golang sshpass zip unzip apt-transport-https\
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt clean
# 安装官方谷歌浏览器
# 使用： google-chrome --headless --disable-gpu --no-sandbox --remote-debugging-port=9222 https://baidu.com
# 检查： curl http://localhost:9222 包含调试信息即可
RUN apt update \
    && apt install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt update \
	&& apt install -y google-chrome-stable --no-install-recommends \
	&& apt install -y fonts-ipafont-gothic fonts-ipafont-mincho ttf-wqy-microhei fonts-wqy-microhei fonts-tlwg-loma fonts-tlwg-loma-otf fonts-gargi \
	&& apt purge --auto-remove -y gnupg \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt clean
# 安装官方nodejs
RUN apt update \
    && apt install -y -q --no-install-recommends build-essential gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt install -y -q --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt clean
# 常用组件程序 composer wp
RUN cd /usr/local/bin/ && /usr/bin/curl -sS https://getcomposer.org/installer | /usr/local/bin/php
RUN /bin/mv /usr/local/bin/composer.phar /usr/local/bin/composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN sed -i 's/www:\/usr\/sbin\/nologin/www:\/bin\/bash/g' /etc/passwd
RUN chown www-data:www-data -Rf /var/www
USER www-data
# 工具
RUN mkdir /var/www/kod/ && wget -O /var/www/kod/kod.zip http://static.kodcloud.com/update/download/kodexplorer4.32.zip && unzip /var/www/kod/kod.zip -d /var/www/kod/ && rm -f /var/www/kod/kod.zip
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
COPY .npmrc /var/www/
RUN cd /var/www/ && composer create-project --prefer-dist laravel/laravel dusk && cd dusk && composer require --dev laravel/dusk && php artisan dusk:install
USER root
RUN chown www-data:www-data /var/www/.bashrc /var/www/.gitignore /var/www/.gitconfig /var/www/.npmrc
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
