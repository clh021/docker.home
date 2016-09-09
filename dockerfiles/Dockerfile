FROM tutum/lamp:latest
MAINTAINER clh021@gmail.com
#大一统开发环境
#修改阿里云镜像源访问速度会很快
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \n deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" > /etc/apt/sources.list
#安装Yii需要的扩展
RUN apt-get update \
    && apt-get -y install curl php5-gd libpng12-dev libfreetype6-dev zlib1g-dev libicu-dev libmagickwand-dev imagemagick php5-imagick php5-sqlite php5-intl libcurl3 libcurl3-dev php5-curl \
    && php5enmod mcrypt \
#安装postgresql数据库
    && apt-get install -y postgresql-server-dev-all \
#安装前端开发工具
    && apt-get install -y nodejs \
    && apt-get install -y npm \
    && npm install -g grunt-cli \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g bower \
#    && npm install -g yo \
#    && apt-get install nodejs-legacy \
#安装实用工具
RUN apt-get -y install python-mysqldb vim wget\
    && apt-get install -y openssh-server\
    && mkdir /var/run/sshd \
    && echo 'root:root' |chpasswd \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo '/usr/sbin/sshd' >> /run.sh
#安装GO环境
RUN echo 'GO install gogogo!' && wget -c https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.7.linux-amd64.tar.gz \
    && echo 'export GOPATH=/app/gopath' >> ~/.profile \
    && echo 'export GOROOT=/usr/local/go' >> ~/.profile \
    && echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.profile \
    && source ~/.profile \
#安装GO常用包
RUN go get github.com/astaxie/beego \
    && go get github.com/beego/bee \
    && go get -u github.com/go-sql-driver/mysql \
    && go get github.com/qiangxue/golang-restful-starter-kit \
    && go get -u github.com/Masterminds/glide \
    && cd $GOPATH/src/github.com/qiangxue/golang-restful-starter-kit && glide up -u -s
WORKDIR /app
EXPOSE 80 3306 22 5432
CMD ["/run.sh"]
