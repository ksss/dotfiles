alias ..='cd ..'
alias vi='vim'
alias lm='ls -altr'
alias vgrep='grep -v'
function phpl() {
	find $1 \( -name "*.php" -or -name "*.phtml" \) -exec php -l {} \;
}
