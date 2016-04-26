# cublinux 笔记
1. install cublinux
2. change [host](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)
3. set software and driver mirrors from aliyun
4. double click to install [sogou input software](http://pinyin.sogou.com/linux/download.php?f=linux&bit=64)
5. 登录 浏览器 google 账号
6. 终端字体 - 如果终端字体`monospace`别扭就换成`ubuntu monospace`
7. 使用系统自带的系统备份工具备份系统
8. 安装开发工具 `docker`
    ```
    sudo apt install curl && curl -fsSL https://get.docker.com/ | sh
    ```
    或者
    ```
    curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
    ```
9. 配置我的 `docker` [加速](https://cr.console.aliyun.com/?#/docker/booster)
10. 检索下载自己常用的 `docker images`
11. 安装 `sudo apt install virtualbox && sudo apt install virtualbox-ext-pack`
12. 安装 phpstorm
13. 配置dns `sudo vim /etc/resolv.conf`
    ```
    nameserver 223.5.5.5
    nameserver 223.6.6.6
    ```
    或者直接使用ali脚本自动配置`wget http://www.alidns.com/static/soft/SetAliDNS.sh -O SetAliDNS.sh && chmod +x SetAliDNS.sh && sudo ./SetAliDNS.sh`
14. `sudo apt-get install conky-all` 然后 `sudo add-apt-repository ppa:teejee2008/ppa && sudo apt update && sudo apt-get install conky-manager`
15. 如果chrome字体变成了楷体，就移除两个更新下来的包`sudo apt-get remove fonts-arphic-ukai && sudo apt-get remove fonts-arphic-uming`
