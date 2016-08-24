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
RUN cd $GOPATH/qiangxue/golang-restful-starter-kit && glide up -u -s
