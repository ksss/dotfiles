alias ..='cd ..'
alias vi='vim'
alias ll='ls -la'
alias lm='ls -altr'
alias vgrep='grep -v'
alias nn='echo \-e "\n\n\n\n\n"'
function phpl() {
	find $1 \( -name "*.php" -or -name "*.phtml" \) -exec php -l {} \;
}
