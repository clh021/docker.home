#常用操作
```
docker exec -it web bash
docker export lcdata > leehom.lcdata.201603310000.tar #import
docker commit lcdata leehom/lcdata:201603310000
docker save leehom/lcdata:201603310000 > leehom.lcdata.201603310000.tar #load
7z a leehom.lcdata.$(date +%Y-%m-%d_%H:%M:%S).tar.7z leehom.lcdata.201603310000.tar
docker cp kickass_yonath:/home/data.txt .
docker run -d -p 8787:8787 kent72/lantern
docker run -it -v "$PWD"/golang:/usr/src/myapp -w /usr/src/myapp golang go build -v

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
docker run -it -d -p 80:80 -e AUTH=user:pass -v $(pwd):/workspace flyinprogrammer/cloud9-with-carina #完美
docker run -d -it --name=cloud9 --privileged -v /app:/workspace -p 80:80 kdelfour/cloud9-docker
#/etc/supervisor/conf.d/cloud9.conf  --auth ${user}:${pass}
docker run -d richarvey/nginx-php-fpm #[readme](https://hub.docker.com/r/richarvey/nginx-php-fpm/)
docker run -d -v $(pwd):/var/www/html -p 80:80 richarvey/nginx-php-fpm
docker run --name myadmin -d -e PMA_HOST=7908f4d6568d.gz.cdb.myqcloud.com -e PMA_PORT=4158 -p 8080:80 phpmyadmin/phpmyadmin
docker run -d --name=ng2-admin -v $(pwd)/ng2-admin:/var/www -p 8080:8080 registry.aliyuncs.com/leehom/ng2-admin
```
#常用命令
```
apt update && wget -qO- https://get.docker.com/ | sh
```
