#!/bin/bash
# leehom Chen clh021@gmail.com
# sed -i 's/\r//' lianghongdev.sh
# ==================================================
# ready
#_today=`date +%Y%m%d%H%M%S`
_today=`date +%F_%T`
MENUS=(install_something docker_run_lamp docker_rm_lamp);
INSTALL_MENUS=(alidebian aliubuntu inst_docker inst_composer inst_phpcs inst_phpmd inst_nodejs_grunt_yeoman_bower inst_memcache inst_redis conf_php_env php_exts inst_ssh inst_git_vim_wget_curl echoclrs inst_xdebug)
DOCKER_MENUS=()
# ==================================================

inst_docker(){
    apt update;\
    apt-get install curl;\
    curl -fsSL https://get.docker.com/ | sh;\
    curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose;\
    chmod +x /usr/local/bin/docker-compose;\
    docker-compose --version;
}
docker_run_lamp(){
    #dockr run -t busybox
    docker run -d -p 80:80 -p 3306:3306 -e MYSQL_PASS="admin" -v `pwd`:/app -v `pwd`/var_lib_mysql:/var/lib/mysql -v `pwd`/docker.home:/root --name web leehom/lampyii2 && docker exec -it web bash
}

docker_rm_lamp(){
    docker_rm_web;
}
docker_pull_php_apache_mariadb(){
    docker pull php:apache;\
    docker pull mariadb;\
    docker pull leehom/dev:php7apacheyii2;#后面节省硬盘空间
}
docker_run_redis_rabbitmq_mariadb_php(){
    docker run --name rabbitmq354 -d rabbitmq:3.5.4 &&\
    docker run --name redis303 -d redis:3.0.3 redis-server --appendonly yes &&\
    docker run --name mariadb10020 -e MYSQL_ROOT_PASSWORD=root -d mariadb:10.0.20 &&\
    docker run -it --name php56wetrip -p 80:8000 -v /app:/var/www/html -v /app/docker.home:/root --link rabbitmq354:rabbitmq --link redis303:redis --link mariadb10020:mysql php:apache
}
docker_run_web(){
    docker ps -a;
    read -p 'Do you see mariadb name containt [Y/N]?' mariadb_exists
    if test "$mariadb_exists" = "N" ; then
        docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -d mariadb && \
        docker run -d --name web -p 80:80 -v `pwd`:/var/www/html -v `pwd`/docker.home:/root --link mariadb:mysql leehom/dev:php7apacheyii2;
#        docker run -d --name dev -p 8000:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache;
    else
        docker run -d --name web -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql leehom/dev:php7apacheyii2;
    fi
    docker exec -it web bash
}
docker_run_weby(){
    docker ps -a;
    read -p 'Do you see mariadb name containt [Y/N]?' mariadb_exists
    if test "$mariadb_exists" = "N" ; then
        docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -d mariadb && \
        docker run -d --name web -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache;
#        docker run -d --name dev -p 8000:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache;
    else
        docker run -d --name web -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache;
    fi
    docker exec -it web bash
}
docker_rm_web(){
    docker stop web && docker rm web
}
# Update sources to aliyun
alidebian(){
	echo "deb http://mirrors.aliyun.com/debian jessie main contrib non-free" > /etc/apt/sources.list; \
	echo "deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list; \
	echo "deb http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free" >> /etc/apt/sources.list;
    echoclr blue 'Switch to the source of aliyun success!';

# echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list; \
# echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list; \
# echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list; \
# echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list; \
# echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list;
}
# Update sources to aliyun
aliubuntu(){
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list;
    echoclr blue 'Switch to the source of aliyun success!';
}
conf_php_env(){
	## 配置PHP环境
	cat /usr/src/php/php.ini-development | sed 's/^;\(date.timezone.*\)/\1 \"PRC\"/' > /usr/local/etc/php/conf.d/php.ini;
	sed -i 's/\(extension_dir = \)\"\.\/\"/\1\"\/usr\/local\/lib\/php\/extensions\/no-debug-non-zts-20060613\/\"/' /usr/local/etc/php/php.ini
	echo 'upload_max_filesize = 50M' >> /usr/local/etc/php/conf.d/php.ini
	echo 'post_max_size = 50M' >> /usr/local/etc/php/conf.d/php.ini
	echo 'max_execution_time = 0' >> /usr/local/etc/php/conf.d/php.ini
    echoclr blue 'PHP configuration file write completion!';
}
php_exts(){
	## 安装PHP扩展
#    && apt-get install -y libmemcached-dev && pecl install memcached && docker-php-ext-enable memcached \//pecl/memcached requires PHP (version >= 5.2.0, version <= 6.0.0)
    apt-get update \
    && apt-get install -y zlib1g-dev && docker-php-ext-install zip \
	&& apt-get install -y mcrypt libmcrypt-dev && docker-php-ext-install mcrypt \
    && apt-get install -y libpng12-dev libfreetype6-dev libjpeg62-turbo-dev && docker-php-ext-install -j$(nproc) iconv mcrypt && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
    && apt-get install -y zlib1g-dev libicu-dev g++ && docker-php-ext-configure intl && docker-php-ext-install intl \
    && apt-get install -y libmagickwand-dev imagemagick --no-install-recommends && pecl install imagick-beta && pecl install imagick && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-ext-install sockets \
    && docker-php-ext-install exif \
    && a2enmod rewrite \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    #docker-php-ext-install bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
}
inst_composer(){
	## 安装composer
	#curl -sS http://install.phpcomposer.com/installer | php -- --install-dir=/usr/local/bin --filename=composer ##全局安装
	curl -sS http://install.phpcomposer.com/installer | php ##局部安装
	#cp /usr/src/php/php.ini-development /usr/local/etc/php/php.ini #composer.phar need
	php ./composer.phar global require "fxp/composer-asset-plugin:~1.1.1" #Yii2 need
	php ./composer.phar create-project yiisoft/yii2-app-advanced advanced 2.0.7 #install Yii2
}
inst_phpcs(){
	## 安装phpcs
	composer global require "squizlabs/php_codesniffer=*" #composer安装
	#pear install PHP_CodeSniffer #pear安装
	## 下载安装
	#curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
	#php phpcs.phar -h
	#curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
	#php phpcbf.phar -h
	#phpcs --config-set installed_paths PATH_TO_SEARCH_STANDARDS #添加标准
}
inst_phpmd(){
	## 安装phpmd
	## 一个检查代码质量的工具
	wget -c http://static.phpmd.org/php/latest/phpmd.phar
}
inst_nodejs_grunt_yeoman_bower(){
	# 安装nodejs
	apt update && apt install -y nodejs
	## 安装grunt## 一个前端自动化工具
	apt install npm
	npm install -g cnpm --registry=https://registry.npm.taobao.org #淘宝镜像
	npm install -g grunt-cli
	## 安装yeoman
	## 现代化 web app 脚手架工具
	npm install -g yo
	apt-get install nodejs-legacy
	## 安装bower
	## web的包管理器，跟踪管理更新
	npm install -g bower
}
inst_memcached(){
	curl -L https://pecl.php.net/get/memcached-2.2.0.tgz >> /usr/src/php/ext/memcached.tgz \
	&& tar -xf /usr/src/php/ext/memcached.tgz -C /usr/src/php/ext/ \
	&& rm /usr/src/php/ext/memcached.tgz \
	&& docker-php-ext-install memcached-2.2.0
}
inst_redis(){
	curl -L https://pecl.php.net/get/redis-2.2.7.tgz >> /usr/src/php/ext/redis.tgz \
	&& tar -xf /usr/src/php/ext/redis.tgz -C /usr/src/php/ext/ \
	&& rm /usr/src/php/ext/redis.tgz \
	&& docker-php-ext-install redis-2.2.7
}
inst_xdebug(){
    read -p 'You should configure PHP environment, now configure [Y]?' dophpenv
    if test "$dophpenv" = "Y" ; then
        php_env;
        ln -s /usr/local/etc/php/conf.d/php.ini /usr/local/etc/php/php.ini -f
    fi
    echoclr blue 'Start the installation xdebug';
    pecl install xdebug-beta;
    docker-php-ext-enable xdebug \
    #echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" >> /usr/local/etc/php/conf.d/php.ini;
    echo "xdebug.remote_enable=on";  >> /usr/local/etc/php/conf.d/xdebug.ini \
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
    && echo "memory_limit = 64M" >> /usr/local/etc/php/conf.d/php.ini
    echoclr blue 'The xdebug install successful. You may need to restart the container.';
}
echoclr(){
	case $1 in
	'red')
		echo -e "\033[31m$2\033[0m"
	;;
	'blue')
		echo -e "\e[1;34m$2\e[0m"
	;;
	'green')
		echo -e "\e[1;32m$2\e[0m"
	;;
	*)
		echo "$2"
		esac
	}

echoclrs(){
    for STYLE in 0 1 2 3 4 5 6 7; do
        for FG in 30 31 32 33 34 35 36 37; do
            for BG in 40 41 42 43 44 45 46 47; do
                CTRL="\033[$STYLE;$FG;${BG}m"
                echo -en "$CTRL"
                echo -n "$STYLE;$FG;$BG"
                echo -en "\033[0m"
            done
            echo
        done
        echo
    done
    # Reset
    echo -e "\033[0m"
}
echousage(){
    echo "=======================[ 良宏工作室 ]==================================
    test说明
    为了尽可能简便的在各个版本的环境中配置出自己需要的开发环境（如php5.4,5.5,5.6,7.0）特此编写如下脚本
    test用法
    1,备份数据库(back_mysql)
    一般选择对应操作的数字即可
    ----------------------------------------------------------------------
    快捷操作：
    以备份数据库为例
    'lee back_mysql' 或者 'lee 1' 可直接进入到备份数据库功能
    后面继续跟上参数 可直接进入备份操作，不用询问输入
    例如：'lee back_mysql dongshenghuo'
    其它操作同理。好玩吧！^_^
    ----------------------------------------------------------------------
    ## 常用命令
    # docker run -d --name dev -p 80:80 -v /c/Users/clh02/Desktop/app:/var/www/html -v /c/Users/clh02/Desktop/app/docker.home:/root php:apache #windows
    # docker run -d --name dev -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root php:apache #linux
    # php -S 0.0.0.0:8000 -t /app
    # docker start dev && docker exec -it dev bash
    # service apache2 restart
    ======================================================================"
}
inst_git_vim_wget_curl(){
    apt update;apt -y install curl wget git git-review vim;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*
}
inst_ssh(){
    apt update;apt-get install -y openssh-server;
    mkdir /var/run/sshd;
    echo 'root:leehom' | chpasswd
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
    /usr/sbin/sshd
}
install_something(){
	echo -e "======[ install on $_today ]======="
	MENUS_CNT=${#INSTALL_MENUS[@]}
	for ((I=0; I<MENUS_CNT; ++I))
    do
        echo -e "$I.${INSTALL_MENUS[I]}\t"
    done
    echo -e "Please select[num]:";
    read menu
    allow="^[0-9]+$";
    if test "$menu" = "" ; then
        exit 0;
    elif [[ "$menu" =~ $allow ]]; then
        if test $menu -lt $MENUS_CNT ; then
            eval ${INSTALL_MENUS[$menu]};
        else
            echoclr red 'Invalid selection';
        fi
    else
        echoclr red 'Please enter a number';
    fi
}
show_menu(){
	echo -e "============[ $_today ]=============="
	MENUS_CNT=${#MENUS[@]}
	for ((I=0; I<MENUS_CNT; ++I))
    do
        echo -e "$I.${MENUS[I]}\t"
    done
    echo -e "Please select[num]:";
    read menu
    allow="^[0-9]+$";
    if test "$menu" = "" ; then
        exit 0;
    elif [[ "$menu" =~ $allow ]]; then
        if test $menu -lt $MENUS_CNT ; then
            eval ${MENUS[$menu]};
        else
            echoclr red 'Invalid selection';
        fi
    else
        echoclr red 'Please enter a number';
    fi
    show_menu;
    #if [ "$1" -eq "$1" ] 2>/dev/null
    #then
    #    echo "$1 is an integer !!"
    #else
    #    echo "ERROR: first paramter must be an integer."
}

#begin working
#if test "$1" != "" ; then
#    analy_param $1 $2 $3 $4 $5;
#else
#    show_menu;
#fi
show_menu;