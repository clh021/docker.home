### 服务器常用命令
```
#centos
ps -aux | grep queue #查看后台进程
cat /etc/redhat-release #查看版本信息
yum install -y nginx php php-fpm mysql mysql-server php-mysql && yum clean all
```
###配置php-fpm与nginx配置
```
/etc/php-fpm.d/www.conf #几乎不用改
/etc/nginx/conf.d/default.conf #取消部分注释即可
ps -ef | grep nginx #检查是否有nginx进程
systemctl enable nginx.service #ln -s '/usr/lib/systemd/system/nginx.service' '/etc/systemd/system/multi-user.target.wants/nginx.service'
```
###快捷服务器命令
```
#备份数据库
mysqldump -uroot -proot wetrip > /wetrip/wetripdev/wetripdev_sql_$(date +%Y%m%d_%H%M%S).sql\r

#备份目录
tar -cvzpf /wetrip/wetripdev_web_$(date +%Y%m%d_%H%M%S).tar.gz /wetrip/wetripdev --exclude=/wetrip/wetripdev/web/assets\r

#清除命令日志
echo > /var/log/wtmp\r
echo > /var/log/btmp\r
cd #\r
rm -f .bash_history\r
rm -f .mysql_history\r
history -c\r

#开启3306端口
/sbin/iptables -I INPUT -p tcp --dport 3306 -j ACCEPT\r

#启动服务
service nginx restart
service mysqld restart
service php-fpm restart
service redis restart
service apache2 restart
/etc/init.d/nginx.conf start #启动nginx
/etc/init.d/php-fpm start #启动php-fpm

#数据库命令
mysql_install_db #建立Mysql系统表
mysqld_safe & #启动mysql
mysql -uroot #测试链接mysql

location ~\.php$ {
    root            /var/www;
    fastcgi_pass    127.0.0.1:9000;
    fastcgi_index   index.php;#非文件结尾时自动添加文件名
    fastcgi_param   SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include         fastcgi_params;
}
```

常用的sublime字符串替换操作
```
\n*\* @link http[^\n]+.php\n[^*]+ //去除带链接的注释
\n\t/\*\*[^/]+/ //替换掉所有段落注释
```