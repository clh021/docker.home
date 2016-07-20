FROM kdelfour/supervisor-docker
MAINTAINER LeeHom Chen <clh021@gmail.com>
# ------------------------------------------------------------------------------
# Install base
RUN apt-get update \
    && apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs
# ------------------------------------------------------------------------------
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup | bash - \
    && apt-get install -y nodejs
# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh
# ------------------------------------------------------------------------------
# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 
# Config supervisord conf
RUN echo '[program:cloud9] \ncommand = node /cloud9/server.js --listen 0.0.0.0 --port 1818 -w /workspace \ndirectory = /cloud9 \nuser = root \nautostart = true \nautorestart = true \nstdout_logfile = /var/log/supervisor/cloud9.log \nstderr_logfile = /var/log/supervisor/cloud9_errors.log \nenvironment = NODE_ENV="production" \n' > /etc/supervisor/conf.d/cloud9.conf
# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace
# Expose ports.
EXPOSE 1818
EXPOSE 3000
