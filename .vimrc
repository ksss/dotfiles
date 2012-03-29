syntax on
filetype plugin indent on

call pathogen#runtime_append_all_bundles() " ~/.vim/bundle 全部読む

if &term =~ "xterm-256color" " 256色
	colorscheme desert256
	" desert256 調整
	highlight SpecialKey ctermfg=244
	hi StatusLineNC ctermbg=246 ctermfg=236
	hi Folded ctermfg=249
	hi Pmenu ctermbg=236
	hi CursorLine cterm=none ctermbg=237
	hi PreProc ctermfg=88
	hi Constant ctermfg=210
	hi Normal ctermfg=15
	hi Search ctermfg=15
	hi LineNr ctermfg=3
"	hi ModeMsg
else                         " 16色
	colorscheme desert
endif

hi ExSpace ctermbg=1
match ExSpace /\s\+$\|　/

if has('gui_running')  " guiなら
	set guioptions+=b    " 横バー
else                   " cuiなら
endif

set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8           " char cord
set clipboard=unnamed            " クリップボード可
set listchars=tab:>.             " Tab表記
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行端で止めない
set laststatus=2                 " ステータスバー表示
set statusline=%F%m%r%h%w:\ %p%%\ %y  "   フルパスファイル名と%
set foldenable                   " 最初の折りたたみ
set foldmethod=marker            " {{{ }}} で折りたたみ
set backspace=indent,eol,start   " BSで消せるもの
set number                       " 行番号を表示する
set autoread                     " 自動で読み直し
set noswapfile                   " ファイル名~を作らない
set nobackup                     " バックアップをとらない。
set incsearch                    " インクリメンタル検索
set list                         " Tabとか可視化
set magic                        " 正規表現記号ON
set smartcase
set smarttab
set showcmd                      " 入力中のコマンド表示
set showmatch                    " 対応する括弧の表示
set nowrap                       " 折り返さない
" set autoindent
set cursorline                 " カーソル行をハイライト
set vb t_vb=                   " ビープ音を消す
set ruler

" インデント
" default
set tabstop=4
set shiftwidth=4
set noexpandtab

" filetype変更 phtml -> php
autocmd BufRead,BufNewFile *.phtml setlocal filetype=php
" filetypeごと
au filetype php setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
au filetype javascript setlocal ts=4 sw=4 tw=0 noexpandtab
" 開発環境下
au BufRead,BufNewFile */fwrs/* setlocal ts=4 sw=4 sts=4 noexpandtab fileformat=unix
" 自動ディレクトリ移動
au BufEnter * execute ":lcd " . expand("%:p:h")


" オートコマンド
augroup MyAutocmd
	au!
	" 失敗した時だけechoする
	function! s:phplint()
		let ret = system(printf("php -l %s", expand('%')))
		if ret !~ '^No.*'
			echomsg ret
		endif
	endfunction

	" PHP保存した時にlint
	au BufWritePost * if &filetype == "php" | call s:phplint() | endif
	" 自動でchmod +x
	au BufWritePost * if getline(1) =~ "^#!" | exe "silent !chmod +x %" | endif
augroup END

" ノーマルモードマップ
" タブ移動
nnoremap <C-tab> gt
nmap <C-S-tab> gT
" ESCの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
" 空行挿入
nmap <C-l> :<C-u>call append(expand('.'), '')<CR>
" 画面分割した方に
nmap <C-w>v <C-w>v<C-w><C-w>
" タブ番号へ
nmap g1 1gt<ESC>
nmap g2 2gt<ESC>
nmap g3 3gt<ESC>
nmap g4 4gt<ESC>
nmap g5 5gt<ESC>
nmap g6 6gt<ESC>
nmap g7 7gt<ESC>
nmap g8 8gt<ESC>

" コマンド
" vimrcリロード
command! Reloadvimrc source ~/.vimrc
" svn ショートカット
command! -nargs=0 Diff exe "!svn diff % | less"

" typoなおし
iabbr funcrion function
iabbr fucntion function
