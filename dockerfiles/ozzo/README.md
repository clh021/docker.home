#使用步骤
```
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" -e POSTGRES_DB="go_restful" postgres
docker run -d -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit #一般情况下的使用
docker run -it --rm -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit #短暂测试用
docker run -it -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit bash #调试使用
```
境内用户如需包含更多包，欢迎反馈，会酌情添加
