#! /bin/sh

if [ ! -d ~/dotfiles/ ]; then
	mkdir ~/dotfiles/
	git clone git@github.com:ksss/dotfiles.git ~/dotfiles/
fi

function link(){
	ln -ivs $1 $2
}

link ~/dotfiles/.vimrc ~/.vimrc
link ~/dotfiles/.screenrc ~/.screenrc
link ~/dotfiles/.bashrc ~/.bashrc
link ~/dotfiles/.zshrc ~/.zshrc
link ~/dotfiles/.vim ~/.vim
link ~/dotfiles/bin ~/bin

