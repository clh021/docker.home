FROM tutum/lamp:latest
MAINTAINER clh021@gmail.com
#修改阿里云镜像源访问速度会很快
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \n deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" > /etc/apt/sources.list
#安装Yii需要的扩展
RUN apt-get update \
    && apt-get -y install php5-gd libpng12-dev libfreetype6-dev zlib1g-dev libicu-dev libmagickwand-dev imagemagick php5-imagick php5-sqlite php5-intl\
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get -y install python-mysqldb openssh-server\
    && php5enmod mcrypt \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*
WORKDIR /app
EXPOSE 80 3306 22
CMD ["/run.sh"]