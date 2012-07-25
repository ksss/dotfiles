[ -f "$HOME/.bash_profile" ] && source "$HOME/.bash_profile"
[ -f "$HOME/.zshrc.mine" ] && source "$HOME/.zshrc.mine"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit
compinit

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

PROMPT="
%{[31m%}$USER@$HOSTNAME%} %{[33m%}%~%{[m%}
$ "
