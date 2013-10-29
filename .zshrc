path=(
	$HOME/.rbenv/bin
	$HOME/.rbenv/shims
	$HOME/bin
	/opt/local/bin
	/opt/local/sbin
	/usr/local/heroku/bin
	/usr/local/mysql/bin
	/usr/local/bin
	/usr/bin
	/usr/sbin
	/bin
	/sbin
)

NODE_PATH=/opt/local/lib/node_modules/
ANDROID_NDK_ROOT=$HOME/lib/android-ndk-r8e
ANDROID_SDK_ROOT=$HOME/lib/adt-bundle-mac-x86_64-20130729/sdk

[ -f "$HOME/.bash_profile" ] && source "$HOME/.bash_profile"
[ -f "$HOME/.zshrc.mine" ] && source "$HOME/.zshrc.mine"
[ -f "$HOME/.zshrc.argumets" ] && source "$HOME/.zshrc.argumets"


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000

typeset -U fpath
fpath=($fpath $HOME/.zsh)

autoload -U compinit
compinit

alias ..='cd ..'
alias ...='cd ../../'
alias vi='vim'
alias ll='ls -la'
alias lm='ls -altr'
alias vgrep='grep -v'
alias nn='echo \-e "\n\n\n\n\n"'
alias rm='rm -i'

# typo
alias ks='ls'
alias sl='ls'
alias l='ls'
alias dc='cd'

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

setopt correct
setopt share_history       # 履歴を1つに
setopt hist_ignore_dups    # ヒストリー重複無視
setopt auto_pushd          # 
setopt print_eight_bit     #  日本語対応
setopt auto_remove_slash   # 接尾語を削除
setopt auto_param_keys     # 変数名補完
setopt hist_ignore_space   # 先頭のスペース無視
# setopt prompt_subst       # プロンプト内で変数展開
setopt pushd_ignore_dups  # 重複するディレクトリを無視
setopt extended_glob       # "#", "~", "^" を正規表現として扱う
setopt list_types          # ファイル種別を表す記号を末尾に表示
setopt no_beep             # ベルを鳴らさない
setopt always_last_prompt  # 無駄なスクロールを避ける
# setopt cdable_vars         # 先頭に "~" を付けたもので展開
setopt sh_word_split       # 変数内の文字列分解のデリミタ
setopt magic_equal_subst   # "val=expr" でファイル名展開

unset PS1 # bashのやつクリア

if [[ -n $SSH_CONNECTION ]];then
	PROMPT_LEFT="%{[31m%}$LOGNAME@$HOSTNAME"
else
	PROMPT_LEFT="%{[32m%}$USER"
fi

PROMPT="
$PROMPT_LEFT %{[33m%}%~%{[m%}
$ "

if [[ -d "$HOME/.rbenv" ]]; then
	eval "$(rbenv init -)"
fi
