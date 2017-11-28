FROM node:latest

RUN git clone --depth=1 https://github.com/akveo/ngx-admin.git --branch v2.0.1 /var/www \
    && cd /var/www \
    && npm install --global rimraf \
    && npm run clean \
    && npm install --global webpack webpack-dev-server typescript \
    && npm install \
    && npm run prebuild:prod && npm run build:prod

EXPOSE 8080

WORKDIR /var/www
ENTRYPOINT ["npm", "run", "server:prod"]
