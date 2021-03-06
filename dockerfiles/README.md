#常用操作
```
#基本的mysql与php:apache连接
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=root -d mariadb &&\
docker run -d --name web -p 80:80 -v /app:/var/www/html -v /app/docker.home:/root --link mariadb:mysql php:apache

#常用命令
docker run --rm -it node node
docker run --rm -it -p 3000:3000 --name nodestudy -v /app/node:/app/node -v /app/docker.home:/root -w /app/node node npm start
docker run -it --rm -p 3000:3000 --name nodestudy -v /app/node:/app/node -v /app/docker.home:/root -w /app/node node node /app/node/app.js
docker run -d --name=some-swoole -v /workdir:/workdir -p 9501:9501 xlight/docker-php7-swoole php /workdir/app_server.php start

#jekyll
RUN apt-get -y install build-essential zlib1g-dev ruby-dev ruby nodejs libgmp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/
RUN gem install github-pages -v 39

docker exec -it web bash #进入容器
docker stop web && docker rm web #停止并删除容器

#导入、导出、保存、提交
docker export lcdata > leehom.lcdata.201603310000.tar #import
docker commit lcdata leehom/lcdata:201603310000 #提交本地容器镜像
docker save leehom/lcdata:201603310000 > leehom.lcdata.201603310000.tar #load
7z a leehom.lcdata.$(date +%Y-%m-%d_%H:%M:%S).tar.7z leehom.lcdata.201603310000.tar
docker save jekyll/jekyll > jekyll.jekyll.tar
docker load < jekyll.jekyll.tar
7z a jekyll.jekyll.tar.7z jekyll.jekyll.tar

docker run --rm --name=jekyll -v $(pwd):/srv/jekyll -it -p 4000:4000 jekyll/jekyll
docker cp kickass_yonath:/home/data.txt .
docker run -d -p 8787:8787 kent72/lantern
docker run -it -v "$PWD"/golang:/usr/src/myapp -w /usr/src/myapp golang go build -v

OVPN_DATA="/root/ovpn-data"
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn

#Docker快速建立OpenVPN服务
export OVPN_DATA="ovpn-data" #设置变量
docker run --name $OVPN_DATA -v /etc/openvpn busybox #创建$OVPN_DATA 卷容器
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM #创建配置文件及证书
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u tcp://VPN.SERVERNAME.COM
sudo docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki

sudo docker -v
      ○ Docker version 1.2 以上版本
sudo docker run --volumes-from $OVPN_DATA -d -p 1194:1194/udp --cap-add=NETADMIN kylemanna/openvpn
sudo docker run --volumes-from $OVPN_DATA -d -p 1194:1194/tcp --cap-add=NETADMIN kylemanna/openvpn
      ○ Docker version 1.2 以下版本
sudo docker run --volumes-from $OVPN_DATA -d -p 1194:1194/udp --privileged kylemanna/openvpn
sudo docker run --volumes-from $OVPN_DATA -d -p 1194:1194/tcp --privileged kylemanna/openvpn

sudo docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass #生成客户端证书
sudo docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn #生成客户端配置文件
cat CLIENTNAME.ovpn


#清理过时镜像_标签为none的镜像_
docker images|grep none|awk '{print $3}'| xargs docker rmi

# 创建一台安装有Docker环境的Linux虚拟机，指定机器名称为default，同时配置Docker加速器地址。
docker-machine create --engine-registry-mirror=https://eko4ves3.mirror.aliyuncs.com -d virtualbox default

# 查看机器的环境配置，并配置到本地。然后通过Docker客户端访问Docker服务。
docker-machine env default
eval "$(docker-machine env default)"
docker info

#dockertool工具下载
http://mirrors.aliyun.com/docker-toolbox/windows?spm=0.0.0.0.P4F6GU
```
#备用操作
```
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASS="mypass" tutum/postgresql #postgresql
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" -e POSTGRES_USER="postgres" postgres #postres
docker run -d -p 80:80 -e ALLOW_OVERRIDE=true tutum/apache-php #enable .htaccess
docker run -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages
docker run -i -t -p 6080:6080 dorowu/ubuntu-desktop-lxde-vnc

docker run -it --rm -p 5901:5901 -e USER=root dockerfile/ubuntu-desktop \
    bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"
docker pull sevnew/ubuntu-xfce-vnc-desktop-chrome

ls | grep '100MEDIA-03' | xargs rm  #清理服务器数据

docker run -d -v $(pwd):/workspace -p 3131:3131 gai00/cloud9 --username test --password testpass #部分功能缺少mount
docker run -d -v $(pwd):/workspace -p 8181:8181 sapk/cloud9 --auth username:password #终端功能缺少
docker run -it -d -p 8181:8181 -v $(pwd):/workspace -e USER=user -e PASS=secret hansd/cloud9 #无法登陆
docker run -it --name=cloud9 --cap-add SYS_ADMIN --device /dev/fuse -d -p 80:80 -e AUTH=user:pass -v $(pwd):/workspace flyinprogrammer/cloud9-with-carina #完美
docker run -it --name=cloud9 --privileged -d -p 80:80 -e AUTH=user:pass -v $(pwd):/workspace flyinprogrammer/cloud9-with-carina #完美
docker run -d -it --name=cloud9 --privileged -v /app:/workspace -p 80:80 kdelfour/cloud9-docker
#/etc/supervisor/conf.d/cloud9.conf  --auth ${user}:${pass}
docker run -d richarvey/nginx-php-fpm #[readme](https://hub.docker.com/r/richarvey/nginx-php-fpm/)
docker run -d -v $(pwd):/var/www/html -p 80:80 richarvey/nginx-php-fpm
docker run --name myadmin -d -e PMA_HOST=7908f4d6568d.gz.cdb.myqcloud.com -e PMA_PORT=4158 -p 8080:80 phpmyadmin/phpmyadmin
docker run -d --name=ng2-admin -v $(pwd)/ng2-admin:/var/www -p 8080:8080 registry.aliyuncs.com/leehom/ng2-admin
docker run --env PASSWORD=password -p 57575:57575 -d garland/butterfly --port=57575 --login #web terminal

docker run -d -p 80:80 -p 443:443 -v /path/to/my_proxy.conf:/etc/nginx/conf.d/my_proxy.conf:ro -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
$ docker run -d -p 80:80 -p 443:443 -v /path/to/vhost.d:/etc/nginx/vhost.d:ro -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
$ { echo 'server_tokens off;'; echo 'client_max_body_size 100m;'; } > /path/to/vhost.d/app.example.com

docker run --rm -itv `pwd`:/go mbrt/golang-vim-dev #golang vim dev
```
#常用命令
```
apt update && wget -qO- https://get.docker.com/ | sh
```
