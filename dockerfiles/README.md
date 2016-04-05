#常用操作
```
docker exec -it web bash
docker export lcdata > leehom.lcdata.201603310000.tar #import
docker commit lcdata leehom/lcdata:201603310000
docker save leehom/lcdata:201603310000 > leehom.lcdata.201603310000.tar #load
7z a leehom.lcdata.$(date +%Y-%m-%d_%H:%M:%S).tar.7z leehom.lcdata.201603310000.tar

docker run -d -p 8787:8787 kent72/lantern
```
#备用操作
```
docker run -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages
docker run -i -t -p 6080:6080 dorowu/ubuntu-desktop-lxde-vnc

docker run -it --rm -p 5901:5901 -e USER=root dockerfile/ubuntu-desktop \
    bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"
docker pull sevnew/ubuntu-xfce-vnc-desktop-chrome
```
#常用命令
```
apt update && wget -qO- https://get.docker.com/ | sh
#我的淘宝加速器
echo "DOCKER_OPTS=\"--registry-mirror=https://eko4ves3.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
sudo service docker restart
```