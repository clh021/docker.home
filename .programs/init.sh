#!/bin/bash
# leehom Chen clh021@gmail.com
# ==================================================
_today=`date +%Y%m%d%H%M%S`

MENUS=(init_deepin_system installDocker);
# PRE_URL=https://raw.githubusercontent.com/clh021/sh/master/init/
PRE_URL=~/workspace/sh/ #需要提前下载
# ==================================================
installAppsDeepin(){
    sudo apt install -y curl git
    sudo apt install -y vscode #vscode
    sudo apt install -y filezilla #ftp
    sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-vnc #远程链接
    #sudo apt install -y sublime-text-dev #sublime3体验更好
    sudo apt install -y apps.com.wechat.web #微信
    #sudo apt install -y apps.com.xunlei.mini #迅雷
    # sudo apt install -y apps.com.yidianzixun #一点资讯#安卓版#140M大小，占用513M空间#体验并不很好
    #sudo apt install -y virtualbox virtualbox-qt virtualbox-ext-pack #虚拟机
    sudo apt install -y workrave #定时休息软件
    sudo apt install -y redshift #调节屏幕亮度和色温来保护眼睛
    sudo apt install -y peek #录制gif的好用工具，深度将会推出类似工具
    #sudo apt install -y scrt-sfx # scrt-sfx - SecureCRT and SecureFX #必须填写注册码才可以用
    #sudo apt install -y kazam # 还不错的教学视频录制软件 暂选择 vokoscreen
    sudo apt install -y vokoscreen #非常强大的屏幕录像，教学视频录制工具
    #sudo apt install -y backintime-common backintime-gnome #系统还原点#deepin中无法使用
    #可以通过 apt-cache search apps.com 命令发现更多最新windows软件
    # sudo apt install -y apps.com.baidu.music.pad # 百度音乐安卓pad版,可下载音乐
    # sudo apt install -y apps.com.kugou.music #酷狗音乐网页版,用来听音乐,收藏音乐很好#不推荐，有更好的替代方案
    #sudo apt install -y apps.cn.kugou.hd #酷狗音乐安卓平板APP,可以完美替换网页版
    #sudo apt install -y apps.com.sanguosha #三国杀游戏
    #sudo apt install -y apps.com.baidu.naotu #百度网页版思维脑图工具 #安装可方便的多开，用不了多少资源
    # sudo apt install -y bcloud #百度网盘第三方python版本 #并不能使用
}
removeAppsDeepin(){
    sudo apt remove -y thunderbird
    sudo apt remove -y steam
}
setHosts(){
    sudo cp -f /etc/hosts /etc/hosts.$(date +%m%d).bak
    curl https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts -#o /etc/
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
    sudo rcnscd restart
}
setAliDns(){
    echo '
nameserver 223.5.5.5
nameserver 223.6.6.6' > /etc/resolv.conf
}
installDocker(){
    # curl -sSL https://get.docker.com/ | sudo sh
    curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
    sudo mkdir -p /etc/systemd/system/docker.service.d 
    sudo tee /etc/systemd/system/docker.service.d/mirror.conf <<-'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// --registry-mirror=https://eko4ves3.mirror.aliyuncs.com
EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}
setBackground(){
    cd;
    gsettings set org.gnome.desktop.background picture-uri file:///`pwd`/Pictures/Wallpapers/_bg.jpg
    cd -;
}
#恢复home之后不需要该操作
setting(){
    #以下如果您有自己的操作，请自行修改
    git config --global push.default simple
    git config --global user.email "clh021@gmail.com"
    git config --global user.name "chenlianghong"
}
tips(){
    echo "\033[31m您可能需要手动完成的其它操作：\033[0m
1、设置workrave为开机启动
"
}
init_deepin_system(){
    apt update
    removeApps
    installApps
    setHosts
    setAliDns
    # installDocker
    setBackground
    tips
}
echoclr(){
	case $1 in
	'red')
		echo -e "\033[31m$2\033[0m"
	;;
	'blue')
		echo -e "\e[1;34m$2\e[0m"
	;;
	'green')
		echo -e "\e[1;32m$2\e[0m"
	;;
	*)
		echo "$2"
		esac
}
show_menu(){
	echo -e "============[ $_today ]=============="
	MENUS_CNT=${#MENUS[@]}
	for ((I=0; I<MENUS_CNT; ++I))
    do
        echo -e "$I.${MENUS[I]}\t"
    done
    echo -e "Please select[num]:";
    read menu
    allow="^[0-9]+$";
    if test "$menu" = "" ; then
        exit 0;
    elif [[ "$menu" =~ $allow ]]; then
        if test $menu -lt $MENUS_CNT ; then
            eval ${MENUS[$menu]};
        else
            echoclr red 'Invalid selection';
        fi
    else
        echoclr red 'Please enter a number';
    fi
    show_menu;
}


# show_menu;
init_deepin_system