# linuxmint 笔记
- install linuxmint18
- set software and driver mirrors from aliyun
- change host
    ```
sudo apt install chromium-browser chromium-browser-l10n
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb && sudo gdebi -n chrome.deb
#https://raw.githubusercontent.com/racaljk/hosts/master/hosts

setHosts(){
    #sudo cp -f /etc/hosts /etc/hosts.$(date +%m%d).bak #不使用日期，使用星期会占用更少的资源
    sudo cp -f /etc/hosts /etc/hosts.$(date +%w).bak #保留一个星期的历史，注意每天只保留一个历史
    curl https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts -#o /etc/hosts
    echo '
10.26.146.180 _on.dongshenghuo.com' >> /etc/hosts
    echo '
127.0.0.1   localhost
127.0.1.1   '`hostname`'

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters' >> /etc/hosts
    # if [ $? -ne 0 ]; then
    #     echo "hosts 下载失败" >&2
    #     exit 2
    # fi
}
    ```
- double click to install sogou input software
    ```
    wget -c "http://pinyin.sogou.com/linux/download.php?f=linux&bit=64" -O sogou.deb && sudo gdebi -n sogou.deb
    ```
- 登录 浏览器 google 账号
- 安装开发工具 `docker`
    ```
    curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
    ```
- 配置我的 `docker` [加速](https://cr.console.aliyun.com/?#/docker/booster)
- 检索下载自己常用的 `docker images`
- 安装 `sudo apt install virtualbox virtualbox-qt virtualbox-ext-pack`
- 配置dns
    ```
sudo echo '
nameserver 223.5.5.5
nameserver 223.6.6.6' > /etc/resolv.conf
    ```
- `sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc`
- `sudo apt-get install conky-all` 然后 `sudo add-apt-repository ppa:teejee2008/ppa && sudo apt update && sudo apt-get install conky-manager`
- `apt install workrave` 定时休息软件
- `/usr/share/backgrounds/linuxmint/default_background.jpg #软连接为你的图片即可修改锁屏背景`
- `sudo apt install backintime-common backintime-gnome #建立系统还原点`
