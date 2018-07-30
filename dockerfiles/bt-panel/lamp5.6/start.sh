#!/bin/bash
if [ -f "/etc/init.d/bt" ];then
    /etc/init.d/bt start
fi
if [ -f "/etc/init.d/nginx" ];then
    /etc/init.d/nginx start
fi
if [ -f "/etc/init.d/httpd" ];then
    /etc/init.d/httpd start
fi
if [ -f "/etc/init.d/pure-ftpd" ];then
    /etc/init.d/pure-ftpd start
fi
if [ -f "/etc/init.d/mysqld" ];then
    chown -R mysql:mysql /www/server/data
    chown -R mysql:mysql /www/server/mysql
    /etc/init.d/mysqld start
fi
if [ -f "/etc/init.d/php-fpm-52" ];then
    /etc/init.d/php-fpm-52 start
fi
if [ -f "/etc/init.d/php-fpm-53" ];then
    /etc/init.d/php-fpm-53 start
fi
if [ -f "/etc/init.d/php-fpm-54" ];then
    /etc/init.d/php-fpm-54 start
fi
if [ -f "/etc/init.d/php-fpm-55" ];then
    /etc/init.d/php-fpm-55 start
fi
if [ -f "/etc/init.d/php-fpm-56" ];then
    /etc/init.d/php-fpm-56 start
fi
if [ -f "/etc/init.d/php-fpm-70" ];then
    /etc/init.d/php-fpm-70 start
fi
if [ -f "/etc/init.d/php-fpm-71" ];then
    /etc/init.d/php-fpm-71 start
fi
if [ -f "/etc/init.d/php-fpm-72" ];then
    /etc/init.d/php-fpm-72 start
fi
if [ -f "/etc/init.d/redis" ];then
    /etc/init.d/redis start
fi
if [ -f "/etc/init.d/memcached" ];then
    /etc/init.d/memcached start
fi
tail -f /dev/null
