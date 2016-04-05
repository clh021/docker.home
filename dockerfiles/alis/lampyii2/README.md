###使用方法一
```
docker run -d -p 80:80 -p 3306:3306 -p 8022:22 -e MYSQL_PASS="admin" -v `pwd`:/app -v `pwd`/var_lib_mysql:/var/lib/mysql -v `pwd`/docker.home:/root --name web leehom/lampyii2 && docker exec -it web bash
```
###使用方法二
```
docker run -it -v /app -v /var/lib/mysql -v /root -v /usr/src/app --name lcdata leehom/busy
docker run -it -p "4000:4000" --volumes-from lcdata starefossen/github-pages
docker run -d -p 80:80 -p 3306:3306 -e MYSQL_PASS="admin" --volumes-from lcdata --name web leehom/lampyii2
```