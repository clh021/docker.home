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
