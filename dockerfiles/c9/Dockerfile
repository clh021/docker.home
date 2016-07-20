FROM ubuntu:trusty
MAINTAINER LeeHom Chen <clh021@gmail.com>
RUN buildDeps='make build-essential g++ gcc python' && softDeps="git" \
 && apt-get update && apt-get upgrade -y \
 && apt-get install -y $buildDeps --no-install-recommends \
 && curl -sL https://deb.nodesource.com/setup | sudo bash - \
 && apt-get install -y nodejs build-essential g++ python curl ca-certificates libssl-dev apache2-utils git libxml2-dev sshfs \
 && npm install -g forever && npm cache clean \
 && git clone https://github.com/c9/core.git /cloud9 && cd /cloud9 \
 && scripts/install-sdk.sh \
 && apt-get purge -y --auto-remove $buildDeps \
 && apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && npm cache clean
 
VOLUME /workspace
EXPOSE 8181 
ENTRYPOINT ["forever", "/cloud9/server.js", "-w", "/workspace", "-l", "0.0.0.0"]
