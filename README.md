`git clone --depth=1 https://github.com/clh021/docker.home.git`
### TODO
- Yii应用
- srchData
- AutoMessageData
- Drupal8

### 基于的环境的使用
```
#基本的mysql与php:apache连接
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -d mariadb &&\
docker run -d --name web -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache
#常用命令
docker exec -it web bash
docker stop web && docker rm web
docker save jekyll/jekyll > jekyll.jekyll.tar
docker load < jekyll.jekyll.tar
7z a jekyll.jekyll.tar.7z jekyll.jekyll.tar
docker run --rm --name=jekyll -v $(pwd):/srv/jekyll -it -p 4000:4000 jekyll/jekyll
#常用环境
docker run --rm -it node node
docker run --rm -it -p 3000:3000 --name nodestudy -v /app/node:/app/node -v /app/docker.home:/root -w /app/node node npm start
docker run -it --rm -p 3000:3000 --name nodestudy -v /app/node:/app/node -v /app/docker.home:/root -w /app/node node node /app/node/app.js
#jekyll
RUN apt-get -y install build-essential zlib1g-dev ruby-dev ruby nodejs libgmp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/
RUN gem install github-pages -v 39
```
### 服务器服务端口修改
```
nano /etc/ssh/sshd_config
Port 22
/etc/init.d/sshd restart
```
### 服务器常用命令
```
#centos
ps -aux | grep queue #查看后台进程
cat /etc/redhat-release #查看版本信息
yum install -y nginx php php-fpm mysql mysql-server php-mysql && yum clean all
du -sh * #查看当前目录下所有文件和文件夹的大小，用于找出不合理的大文件
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

echo > /var/log/wtmp
echo > /var/log/btmp
cd #
rm -f .bash_history
rm -f .mysql_history
history -c


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
### 如何强制谷歌访问使用https
谷歌浏览器，打开[`chrome://net-internals/#hsts`]然后在"Add domain"中输入网址勾选下面俩勾点击"Add"即可
网址包括：
```
google.com
google.com.hk
googleusercontent.com
googleapis.com
```

### 其它
常用的sublime字符串替换操作
```
\n*\* @link http[^\n]+.php\n[^*]+ //去除带链接的注释
\n\t/\*\*[^/]+/ //替换掉所有段落注释
```

服务器上的下载操作
```
sudo apt-get install transmission-cli
wget http://releases.ubuntu.com/14.10/ubuntu-14.10-desktop-amd64.iso.torrent
transmission-cli ubuntu-14.10-desktop-amd64.iso.torrent
transmission-cli -w ~/iso -D -u 50 -f ~/finish.sh ubuntu-14.10-desktop-amd64.iso.torrent
```
安装mysql控制面板
```
wget -c http://www.adminer.org/latest.php
```
隐藏标志性面板
```
vim //build/standalone/skin/default/dark.css #两处，元素查找
echo //static/plugins/..layout.classic/images/loading-logo.png
echo //local/index.html #title
echo //local/favicon.ico
```
