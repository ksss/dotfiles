#! /bin/sh

if [ ! -d ~/dotfiles/ ]; then
	mkdir ~/dotfiles/
	git clone git@github.com:ksss/dotfiles.git ~/dotfiles/
fi

if [ ! -d ~/.vim-backup/ ]; then
	mkdir ~/.vim-backup/
fi

function lnivs () {
	diff -u $2 $1
	ln -ivs $1 $2
}
lnivs ~/dotfiles/.vimrc ~/.vimrc
lnivs ~/dotfiles/.screenrc ~/.screenrc
lnivs ~/dotfiles/.bashrc ~/.bashrc
lnivs ~/dotfiles/.zprofile ~/.zprofile
lnivs ~/dotfiles/.zshrc ~/.zshrc
lnivs ~/dotfiles/.tigrc ~/.tigrc
lnivs ~/dotfiles/.gitconfig ~/.gitconfig
lnivs ~/dotfiles/.gitignore ~/.gitignore
lnivs ~/dotfiles/.gemrc ~/.gemrc
lnivs ~/dotfiles/.vim ~/.vim
lnivs ~/dotfiles/bin ~/bin
