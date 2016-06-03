NODE_PATH=/opt/local/lib/node_modules/

[ -f "$HOME/.bash_profile" ] && source "$HOME/.bash_profile"
[ -f "$HOME/.zshrc.mine" ] && source "$HOME/.zshrc.mine"
[ -f "$HOME/.zshrc.argumets" ] && source "$HOME/.zshrc.argumets"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

typeset -U fpath
fpath=($fpath $HOME/.zsh)

autoload -U compinit
compinit

alias ..='cd ..'
alias ...='cd ../../'
alias vi='vim'
alias ll='ls -la'
alias lm='ls -altr'
alias rm='rm -i'

# typo
alias ks='ls'
alias sl='ls'
alias l='ls'
alias dc='cd'

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey -e

setopt correct
setopt share_history       # 履歴を1つに
setopt hist_ignore_dups    # ヒストリー重複無視
setopt auto_pushd          # 
setopt print_eight_bit     #  日本語対応
setopt auto_remove_slash   # 接尾語を削除
setopt auto_param_keys     # 変数名補完
setopt hist_ignore_space   # 先頭のスペース無視
setopt pushd_ignore_dups  # 重複するディレクトリを無視
# setopt extended_glob       # "#", "~", "^" を正規表現として扱う
setopt list_types          # ファイル種別を表す記号を末尾に表示
setopt no_beep             # ベルを鳴らさない
setopt always_last_prompt  # 無駄なスクロールを避ける
setopt prompt_subst       # プロンプトを毎回評価
# setopt cdable_vars         # 先頭に "~" を付けたもので展開
setopt sh_word_split       # 変数内の文字列分解のデリミタ
setopt magic_equal_subst   # "val=expr" でファイル名展開

## 補完候補に色を付ける。
### "": 空文字列はデフォルト値を使うという意味。
zstyle ':completion:*:default' list-colors ""

## 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'r:|[._-]=*'

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes

zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

## カーソル位置で補完する。
setopt complete_in_word

## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

## jobsでプロセスIDも出力する。
setopt long_list_jobs

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}

unset PS1 # bashのやつクリア

function rprompt-git-current-branch () {
	local name

	if [[ "$PWD" =~ '/\.git(/.*)?$' ]];then
		return
	fi
	name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
	if [[ -z $name ]]; then
		return
	fi
	echo ":$name"
}

BRANCH='`rprompt-git-current-branch`'

if [[ -n $SSH_CONNECTION ]];then
	PROMPT_LEFT="%{[31m%}$LOGNAME@$HOSTNAME"
else
	PROMPT_LEFT="%{[32m%}$USER"
fi

PROMPT="
$PROMPT_LEFT%{[32m%}$BRANCH %{[33m%}%~%{[m%}
%(?.%{[32m%}.%{[31m%})$%{[m%} "

function t () {
	local n
	n=$(basename $(pwd))
	echo -ne "\033]0;${n}\007"
	echo ${n}
}

export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
GREP_OPTIONS="--exclude-dir=.git --color=auto --binary-files=without-match"

if [[ -d "$HOME/.rbenv" ]]; then
	eval "$(rbenv init -)"
fi
