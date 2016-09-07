#使用步骤
```
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" postgres
docker run -d -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
docker run -it --rm -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
#如需包含更多包，欢迎反馈，会酌情添加
```