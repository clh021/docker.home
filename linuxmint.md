# linuxmint 笔记
1. install linuxmint18
2. change [host](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)
3. set software and driver mirrors from aliyun
4. double click to install [sogou input software](http://pinyin.sogou.com/linux/download.php?f=linux&bit=64)
5. 登录 浏览器 google 账号
6. 安装开发工具 `docker`
    ```
    curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
    ```
7. 配置我的 `docker` [加速](https://cr.console.aliyun.com/?#/docker/booster)
8. 检索下载自己常用的 `docker images`
9. 安装 `sudo apt install virtualbox && sudo apt install virtualbox-ext-pack`
10. 配置dns `sudo xed /etc/resolv.conf`
    ```
    nameserver 223.5.5.5
    nameserver 223.6.6.6
    ```
11. `sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc`
12. `sudo apt-get install conky-all` 然后 `sudo add-apt-repository ppa:teejee2008/ppa && sudo apt update && sudo apt-get install conky-manager`
13. /usr/share/backgrounds/linuxmint/default_background.jpg #软连接为你的图片即可修改锁屏背景
