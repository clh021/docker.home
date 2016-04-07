FROM tutum/lamp:latest
MAINTAINER clh021@gmail.com
#修改阿里云镜像源访问速度会很快
RUN echo "deb http://mirrors.aliyuncs.com/ubuntu/ trusty main restricted universe multiverse \ndeb http://mirrors.aliyuncs.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb http://mirrors.aliyuncs.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb http://mirrors.aliyuncs.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb http://mirrors.aliyuncs.com/ubuntu/ trusty-backports main restricted universe multiverse \ndeb-src http://mirrors.aliyuncs.com/ubuntu/ trusty main restricted universe multiverse \n deb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb-src http://mirrors.aliyuncs.com/ubuntu/ trusty-backports main restricted universe multiverse" > /etc/apt/sources.list
#安装Yii需要的扩展
RUN apt-get update \
    && apt-get -y install php5-gd libpng12-dev libfreetype6-dev zlib1g-dev libicu-dev libmagickwand-dev imagemagick php5-imagick php5-sqlite php5-intl\
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*
#安装前端开发工具
RUN apt-get update \
    && apt-get install -y nodejs \
    && apt-get install -y npm \
    && npm install -g grunt-cli \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g bower \
#    && npm install -g yo \
#    && apt-get install nodejs-legacy \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*
#安装实用工具
RUN apt-get update \
    && apt-get -y install python-mysqldb openssh-server curl vim\
    && php5enmod mcrypt \
    && apt-get install -y openssh-server
    && mkdir /var/run/sshd
    && echo 'root:root' |chpasswd
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

WORKDIR /app
EXPOSE 80 3306 22
CMD ["/run.sh"]