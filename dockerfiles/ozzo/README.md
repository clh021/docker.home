#使用步骤
```
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" postgres
docker run -d -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
docker run -it --rm -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
#如需包含更多包，欢迎反馈，会酌情添加
```
> 其中随机数没有生成到配置文件中，有好的修改建议欢迎反馈，在该问题解决前请自行修改 jwt_verification_key 和 jwt_signing_key 来保证安全性

> Wherein the random number is not generated in the configuration file, the proposed changes have a good welcome feedback before the issue is resolved and modify their own jwt_verification_key jwt_signing_key to ensure security