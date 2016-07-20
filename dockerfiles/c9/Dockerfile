# ------------------------------------------------------------------------------
# Based on a work at https://github.com/docker/docker.
# ------------------------------------------------------------------------------
# Pull base image.
FROM kdelfour/supervisor-docker
MAINTAINER LeeHom Chen <clh021@gmail.com>

# ------------------------------------------------------------------------------
# Install base
RUN apt-get update
RUN apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs

# ------------------------------------------------------------------------------
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs
    
# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js 

# Add supervisord conf
RUN echo '[program:cloud9]\ncommand = node /cloud9/server.js --listen 0.0.0.0 --port 80 -w /workspace\ndirectory = /cloud9\nuser = root\nautostart = true\nautorestart = true\nstdout_logfile = /var/log/supervisor/cloud9.log\nstderr_logfile = /var/log/supervisor/cloud9_errors.log\nenvironment = NODE_ENV="production"\n' > /etc/supervisor/conf.d/cloud9.conf

# ------------------------------------------------------------------------------
# Add volumes
RUN mkdir /workspace
VOLUME /workspace

# ------------------------------------------------------------------------------
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 80
EXPOSE 3000
