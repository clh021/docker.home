#!/bin/bash
# 配置整理
PHP_UPLOAD_MAX_FILESIZE = 20M
PHP_POST_MAX_SIZE = 10M
# 完成安装步骤的整理
sudo apt-get update
sudo apt-get -y upgrade
# 安装 curl,wget,git,git-review,vim
sudo apt-get install -y curl wget git git-review vim
# 安装 apache,mysql,php 以及php的各项扩展
sudo apt-get install -y apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt  php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl
# 需要手动设置数据库密码
# 清理缓存
sudo apt-get clean
# 开启apache的rewrite模块
sudo a2enmod rewrite
# PHP相关配置
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini
sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/"  /etc/php5/apache2/php.ini
sed -ri -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
# 默认初始页面
sudo cat > /var/www/html/index.php <<EOF
<?php \$link = mysql_connect('localhost', 'root', 'root'); ?>
<html>
<head>
    <title>Hello world!</title>
    <style>
    body {
        text-align: center;
    }
    </style>
</head>
<body>
    <h2 align="center">PHP Version: <?php echo phpversion();?></h2>
    <?php if(!\$link) { ?>
        <h2>Can't connect to local MySQL Server!</h2>
    <?php } else { ?>
        <h2>MySQL Server version: <?php echo mysql_get_server_info(); ?></h2>
    <?php } phpinfo();?>
</body>
</html>
EOF





# （以下步骤在服务器中不是必须的）
# 添加一个新用户加入到www-data组
# 把www-data也加入到新用户所在的用户组

#设置mysql远程访问
sudo sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
mysql -u root -p

#手动输入数据库密码
#update user set Password=PASSWORD('root') where User = 'root';
DELETE FROM mysql.user WHERE user = ''; #删除匿名用户
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;
#数据库操作end


# 服务重启
sudo service apache2 restart
sudo service mysql restart
# 本地访问localhost即可看到apache默认页面
# 本地访问localhost/index.php即可看到响应php所有运行环境和扩展