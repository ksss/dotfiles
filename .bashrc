hh=$HOSTNAME
uu=$USER
col=32
TITLEBAR='\[\033]0; \w\007\]'
PS1="${TITLEBAR}
\[\e[${col}m\]$uu@$hh \[\e[33m\]\w
\[\e[${col}m\]\$\[\e[m\] "

alias ..='cd ..'
alias ...='cd ../../'
alias vi='vim'
alias ll='ls -la'
alias lm='ls -altr'
alias vgrep='grep -v'
alias nn='echo \-e "\n\n\n\n\n"'
function phpl() {
	find $1 \( -name "*.php" -or -name "*.phtml" \) -exec php -l {} \;
}
function tagr() {
	tail -f $1 | grep --color $2
}

if [ -f ~/.privaterc ]; then
    source ~/.privaterc
fi
