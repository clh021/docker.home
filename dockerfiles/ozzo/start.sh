#!/bin/bash
cd $GOPATH/src/github.com/qiangxue/golang-restful-starter-kit/
LOCKFILE=./db.init.lock
if [ -f $LOCKFILE ]; then
    echo -e "\033[32mDatabase has been initialized\033[0m"
else
    apt-get update
    apt-get install pwgen
    echo "dsn: \"postgres://postgres:postgres@postgres:5432/go_restful?sslmode=disable\"">config/app.yaml
    echo "jwt_verification_key: \"$(pwgen -s 32 1)\"">>config/app.yaml
    echo "jwt_signing_key: \"$(pwgen -s 32 1)\"">>config/app.yaml
    go run testdata/init.go
    echo -e "\033[32mStart the database initialization\033[0m"
    echo "1" > db.init.lock
fi
go run server.go