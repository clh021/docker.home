# Base image is in https://registry.hub.docker.com/_/golang/
# Refer to https://blog.golang.org/docker for usage
FROM golang:latest
MAINTAINER leehom clh021@gmail.com

# Install go-ozzo & All ozzo pkg
RUN go get -u github.com/go-ozzo/ozzo-routing
RUN go get -u github.com/go-ozzo/ozzo-config
RUN go get -u github.com/go-ozzo/ozzo-dbx
RUN go get -u github.com/go-ozzo/ozzo-validation
RUN go get -u github.com/go-ozzo/ozzo-log
RUN go get -u github.com/go-ozzo/ozzo-di
RUN go get -u github.com/go-sql-driver/mysql

# 尽可能包含所需的所有包到镜像中以节省境内用户的时间精力
# install the starter kit
RUN go get github.com/qiangxue/golang-restful-starter-kit
RUN go get -u github.com/Masterminds/glide
RUN cd $GOPATH/src/github.com/qiangxue/golang-restful-starter-kit && glide up -u -s
WORKDIR $GOPATH/src/github.com/qiangxue/golang-restful-starter-kit
RUN cd config && echo 'dsn: "postgres://postgres:postgres@postgres:5432/go_restful?sslmode=disable"'>app.yaml && echo 'jwt_verification_key: "'$RANDOM'04Cob7b71QCqy738vw5XGS'$RANDOM'"'>>app.yaml && echo 'jwt_signing_key: "'$RANDOM'04Cob7b71QCqy738vw5XGS'$RANDOM'"'>>app.yaml
CMD ["go","run","server.go"]
EXPOSE 8080

#使用步骤
#docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD="postgres" postgres
#docker run -d -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
#docker run -it --rm -p 8080:8080 --name restful --link postgres:postgres leehom/ozzo-restful-kit
#境内用户如需包含更多包，欢迎反馈，会酌情添加

#其中随机数没有生成到配置文件中，有好的修改建议欢迎反馈，在该问题解决前请自行修改 jwt_verification_key 和 jwt_signing_key 来保证安全性
#Wherein the random number is not generated in the configuration file, the proposed changes have a good welcome feedback before the issue is resolved and modify their own jwt_verification_key jwt_signing_key to ensure security