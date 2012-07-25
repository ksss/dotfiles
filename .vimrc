syntax on
filetype plugin indent on
call pathogen#runtime_append_all_bundles() " ~/.vim/bundle 全部読む

" jpTemplateの起動キー
let g:jpTemplateKey = '<C-B>'

" debuggerの使用ポート
let g:debuggerPort = 20016

if &term =~ "xterm-256color" " 256色
	colorscheme desert256
	" desert256 調整 +-36
	highlight SpecialKey ctermfg=238
	hi StatusLineNC ctermbg=246 ctermfg=236
	hi Folded ctermfg=253
	hi Pmenu ctermbg=236
	hi CursorLine cterm=none ctermbg=236
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
set cursorline                   " カーソル行をハイライト
set vb t_vb=                     " ビープ音を消す
set ruler
set autochdir                    " 自動ディレクトリ移動
set wildmenu                     " 補完候補表示する


" インデント
" default
set tabstop=4
set shiftwidth=4
set noexpandtab

" {{{ オートコマンド
augroup MyAutocmd
	autocmd!

	" filetype変更 phtml -> php
	au BufRead,BufNewFile *.phtml setlocal filetype=php

	" filetypeごと
	" au filetype php setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
	au filetype javascript setlocal ts=4 sw=4 tw=0 noexpandtab
	au filetype coffee setlocal ts=2 sw=2 tw=0 expandtab
	au filetype ruby setlocal ts=2 sw=2 expandtab

	" 開発環境下
	" au BufRead,BufNewFile */fwrs/* setlocal ts=4 sw=4 sts=4 noexpandtab fileformat=unix

	" 失敗した時だけechoする
	function! s:phplint()
		if &filetype == 'php'
			let ret = system(printf("php -l %s", expand('%')))
			if ret !~ '^No.*'
				echo ret
			endif
		endif
	endfunction
	" PHP保存した時にlint
	au BufWritePost * call s:phplint()

	" 自動でchmod +x
	au BufWritePost * if getline(1) =~ "^#!" | exe "silent !chmod +x %" | endif
augroup END
" }}}

" {{{ セルフ実行
function! ShebangExecute()
	let m = matchlist(getline(1), '#!\(.*\)')
	if (len(m) > 2)
		echo system(printf('%s %s', m[1], expand('%')))
	else
		execute '!' . &ft ' %'
	endif
endfunction
nmap ,e :call ShebangExecute()<CR>
" }}}

" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<TAB>"
	else
		if pumvisible()
			return "\<C-N>"
		else
			return
			"\<C-N>\<C-P>"
		end
	endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

" {{{ MyTabLine() show tabpage num
function! MyTabLine()
	let label = ''
	let t = tabpagenr()
	let i = 1
	while i <= tabpagenr('$')
		" let page num as index started '0'
		let pn = i
		" buffer list
		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		" append tab number
		let label .= '%' . i . 'T'
		let label .= (i == t ? '%1*' : '%2*')
		let label .= (i == t ? '%#LineNr#' . ' ' . pn : '%#TabLine#' . ' ' . pn)
		let label .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let file = bufname(buflist[winnr - 1])
		let file = fnamemodify(file, ':p:t')
		" Add '+' if one of the buffers in the tab page is modified
		let label .= ':' . (i == t ? '%#NonText#' : '%#TabLine#')
		if file == ''
			let file = '[No Name]'
		endif
		let label .= file
		if getbufvar(file, "&modified")
			let label .= '[+]'
		endif
		let label .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		" Append the number of windows in the tab page
		let label .= ' |'
		let i = i + 1
	endwhile
	let label .= '%T%#TabLineFill#%='
	let label .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
	return label
endfunction
if exists("+showtabline")
	set stal=2
	set tabline=%!MyTabLine()
endif
" }}}

" {{{ OpenAppModels
function! OpenAppModels()
	let m = expand('<cword>')
	if matchstr(m, '^App') != ""
		execute ':tabedit ' . $models . '/' . substitute(m, '_', '/', 'g') . '.php'
	endif
endfunction
command! -nargs=0 OpenAppModels call OpenAppModels()
"}}}

" ノーマルモードマップ
" タブ移動
" nnoremap <C-tab> gt
" nmap <C-S-tab> gT
" ESCの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
" 空行挿入
nmap <C-l> :<C-u>call append(expand('.'), '')<CR>
" 画面分割した方に
" nmap <C-w>v <C-w>v<C-w><C-w>

nmap bb :ls<cr>:buffer

" g?でタブ番号へ
for i in range (1, 8)
	exec 'nmap g' . i . ' ' . i . 'gt<ESC>'
endfor

" コマンド
" vimrcリロード
command! Reloadvimrc source ~/.vimrc

" svn diffショートカット
command! -nargs=0 Svndiff echo system(printf("svn diff %s", expand('%')))
