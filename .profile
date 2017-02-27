# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

##########################################################################
### The following configuration system environment by clh021@gmail.com ###
##########################################################################
# node PATH
if [ -d "$HOME/.programs/node-v6.9.5-linux-x64/bin" ] ; then
    PATH="$HOME/.programs/node-v6.9.5-linux-x64/bin:$PATH"
fi
# golang PATH
if [ -d "$HOME/.programs/go1.7.4.linux-amd64/bin" ] ; then
    export GOPATH="$HOME/go" #work path
    export GOROOT="$HOME/.programs/go1.7.4.linux-amd64/bin" #install path
    PATH="$HOME/.programs/go1.7.4.linux-amd64/bin:$PATH"
fi

#.###.!/bin/bash
#sudo ln -s `pwd`/node-v6.9.5-linux-x64/bin/node /usr/local/bin/node
#sudo ln -s `pwd`/node-v6.9.5-linux-x64/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
#sudo ln -s `pwd`/node-v6.9.5-linux-x64/lib/node_modules/cnpm/bin/cnpm /usr/local/bin/cnpm
#可以直接把 `pwd`/node-v6.9.5-linux-x64/bin 加入 到 PATH 一切都解决了，恢复时候不用执行脚本
#此处依然保留供以后参考用
