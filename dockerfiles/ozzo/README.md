#使用步骤
```
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" postgres
docker run -d -p 8080:8080 --name myrestapi leehom/ozzo-restful-kit
#如需包含更多包，欢迎反馈会酌情添加
```