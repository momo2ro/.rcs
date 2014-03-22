version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=ja
set nomodeline
set printoptions=paper:a4
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
"=============================================
" General Config
"=============================================

"バックスペースで行頭削除
set backspace=indent,eol,start

"内容が変更されたら自動的に再読み込み
set autoread

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline

"C-vの矩形選択で行末より後ろもカーソルを置ける
set virtualedit=block

"履歴数
set history=500

"ランタイムパス
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after

"スワップファイル
set swapfile
set directory=$HOME/.vim/swap

"=============================================
" Search Config
"=============================================

"インクリメンタルサーチを有効にする
set incsearch

"大文字小文字を区別しない
set ignorecase

"大文字で検索されたら対象を大文字限定にする
set smartcase

"行末まで検索したら行頭に戻る
set wrapscan

"=============================================
" Format Config
"=============================================

"自動インデントを有効化する
set smartindent
set autoindent

"ファイルタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"フォーマット揃えをコメント以外有効にする
set formatoptions-=c

"コメントの自動補完を無効化
setlocal formatoptions-=ro

"括弧の対応をハイライト
set showmatch

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
  set smarttab

"=============================================
" Look & Feel Config
"=============================================

"行番号表示
set number

"ルーラー表示
set ruler

"TAB,EOFなどを可視化する
set list
set listchars=tab:>-,extends:<,trail:-,eol:<

"検索結果をハイライトする
set hlsearch

"コマンドラインの高さ
set cmdheight=1

"カーソルラインを表示する
set cursorline

"ステータスラインにコマンドを表示
set showcmd

"ステータスラインを常に表示
set laststatus=2

"ファイルナンバー表示
set statusline=[%n]

"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@

"ファイル名表示
set statusline+=%<%F

"変更のチェック表示
set statusline+=%m

"読み込み専用かどうか表示
set statusline+=%r

"ヘルプページなら[HELP]と表示
set statusline+=%h

"プレビューウインドウなら[Prevew]と表示
set statusline+=%w

"ファイルフォーマット表示
set statusline+=[%{&fileformat}]

"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]

"ファイルタイプ表示
set statusline+=%y

"ここからツールバー右側
set statusline+=%=

"skk.vimの状態
set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}

"文字バイト数/カラム番号
set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]

"現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]

"現在文字行/全体行表示
set statusline+=[L=%l/%L]

"現在のファイルの文字数をカウント
"set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]

"現在行が全体行の何%目か表示
set statusline+=[%p%%]

"=============================================
" Encode Config
"=============================================

"エンコード設定
if has('unix')
	    set fileformat=unix
	        set fileformats=unix,dos,mac
		    set fileencoding=utf-8
		        set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
			    set termencoding=
			    elseif has('win32')
			        set fileformat=dos
				    set fileformats=dos,unix,mac
				        set fileencoding=utf-8
					    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
					        set termencoding=
						endif
						

"=============================================
" Key Config
"=============================================

"<S-s>で.vimrc再読み込み
map S :source $HOME/.vimrc<CR>

"ZZは強制的に書き込む
map ZZ :wq!<CR>
