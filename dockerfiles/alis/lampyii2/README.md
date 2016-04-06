###使用方法一
```
docker run -d -p 80:80 -p 3306:3306 -p 8022:22 -e MYSQL_PASS="admin" -v `pwd`:/app -v `pwd`/var_lib_mysql:/var/lib/mysql -v `pwd`/docker.home:/root --name web registry.aliyuncs.com/leehom/lampyii2 && docker exec -it web bash
```
###使用方法二
```
docker run -it -v /app -v /var/lib/mysql -v /root -v /usr/src/app --name lcdata leehom/busy
docker run -it -p "4000:4000" --volumes-from lcdata starefossen/github-pages
docker run -d -p 80:80 -p 3306:3306 -e MYSQL_PASS="admin" --volumes-from lcdata --name web registry.aliyuncs.com/leehom/lampyii2
```

###非阿里内部主机切换源
```
#do this command for not aliyun ecs
echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \n deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \ndeb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse" > /etc/apt/sources.list
```