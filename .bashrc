alias ..='cd ..'
alias ...='cd ../../'
alias vi='vim'
alias ll='ls -la'
alias lm='ls -altr'
alias vgrep='grep -v'
alias nn='echo \-e "\n\n\n\n\n"'

if [ -f ~/.privaterc ]; then
    source ~/.privaterc
fi
