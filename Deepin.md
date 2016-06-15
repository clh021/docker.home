# deepin 笔记
1. install deepin
2. change [host](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)
5. 登录 浏览器 google 账号
8. 安装开发工具 `docker`
    ```
    sudo apt install curl && curl -fsSL https://get.docker.com/ | sh
    ```
9. 配置我的 `docker` [加速](https://cr.console.aliyun.com/?#/docker/booster)
10. 检索下载自己常用的 `docker images`
11. 安装 `sudo apt install sublime-text virtualbox virtualbox-ext-pack`
13. 配置dns `sudo gedit /etc/resolv.conf`
    ```
    nameserver 223.5.5.5
    nameserver 223.6.6.6
    ```
    或者直接使用ali脚本自动配置`wget http://www.alidns.com/static/soft/SetAliDNS.sh -O SetAliDNS.sh && chmod +x SetAliDNS.sh && sudo ./SetAliDNS.sh`
14. `sudo apt-get install conky-all && conky-manager`
12. 安装 phpstorm
