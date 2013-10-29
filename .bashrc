if [ -f ~/.privaterc ]; then
    source ~/.privaterc
fi

function color() {
	sed -e "s/${1}/^[[32m${1}^[[m/"
}
