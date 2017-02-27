# ~/.bashrc: executed by bash(1) for non-login shells.
PS1='\[\e[32m\]\# [\e[33m\D{%Y-%m-%d %T}]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[32m\]\w\[\e[m\]\n\$ '
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#git color set
# git config --global color.status auto
# git config --global color.diff auto
# git config --global color.branch auto
# git config --global color.interactive auto

PATH="/home/lee/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lee/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lee/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lee/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lee/perl5"; export PERL_MM_OPT;
