" 基本設定 {{{1

" モードライン {{{2

set modeline
set modelines=3

" スワップ {{{2

set swapfile
set directory=$HOME/.vimswap

" 検索 {{{2

set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch

" インデント {{{2

set smartindent
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab

" 行番号 {{{2

set number
set relativenumber
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
" カーソルラインを表示
set cursorline


" エンコード設定 {{{2

if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
    set fileencoding=utf-8
    set encoding=utf-8
    set termencoding=
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencoding=utf-8
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=
endif

" その他の設定 {{{2

" クリップボードと共有
set clipboard=autoselect
set clipboard=unnamedplus
" ルーラーを表示
set ruler
" コマンドラインの行数
set cmdheight=1
" 不可視文字の視覚化
set list
set listchars=tab:>-,trail:-,eol:▸
" ファイルタイプごとのプラグインとインデント
filetype plugin on
filetype indent on
"タブ補完を有効
if &cp | set nocp | endif
" 印刷時にA4を使う
set printoptions=paper:a4
" 日本語ヘルプ
set helplang=ja
" ファイルの開き方
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
" 以下の拡張子はワイルドカードでの優先度を低くする
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" 矩形選択時に文字の無い場所まで選択する
set virtualedit=block
" 移動時行頭に移動させない
set nostartofline
" コメントを自動改行させない
set formatoptions-=c
" 対応する括弧表示
set showmatch
set matchtime=1
" 履歴の数
set history=2000
" 設定・プラグインのpath
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/neobundle.vim/
" バックスペースを有効
set backspace=indent,eol,start
" 外部からの変更に対応
set autoread
" 長い行を表示
set display=lastline

" }}}2

" キーマッピング {{{1

nnoremap Y y$
"<S-s>で.vimrc再読み込み
map S :source $HOME/.vimrc<CR>
"ZZは強制的に書き込む
map ZZ :wq!<CR>
" if(a) {<Enter>
" ↓
" if(a) {
"
" }
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" カラー {{{1

" カラースキーム {{{2

colorscheme molokai
highlight Normal ctermbg=none

" ハイライト {{{2
syntax on
au BufRead,BufNewFile *.md set filetype=mark

" PowerLine {{{2

let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set laststatus=2

" }}}2

" プラグイン {{{1

" NeoBundle {{{2

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"括弧補完
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'
"コメントアウトのON/OFF
NeoBundle 'tomtom/tcomment_vim'
"インデントに色付け
NeoBundle 'nathanaelkane/vim-indent-guides'
" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'TwitVim'
NeoBundle 'LeafCage/foldCC.vim'
NeoBundle 'thinca/vim-singleton'
" hybrid
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
call neobundle#end()
" NeoBundleの後にsyntaxを置かないといけないらしい
syntax on

" Unite {{{2
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" vim-indent-guides {{{2

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

" NeoComplete {{{2

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

" PreVim {{{2

let g:previm_open_cmd='xdg-open'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" TwitVim {{{2

let twitvim_browser_cmd = 'xdg-open'
let twitvim_force_ssl = 1
let twitvim_count = 40

" foldCC {{{2

set foldmethod=marker
set foldtext=FoldCCtext()
set foldcolumn=5
set fillchars=vert:\|
hi Folded gui=bold term=standout ctermbg=LightGrey ctermfg=Green guibg=Grey30 guifg=Grey80
hi FoldColumn gui=bold term=standout ctermbg=LightGrey ctermfg=Green guibg=Gray guifg=Green

" singleton.vim {{{2

call singleton#enable()

" }}}2

" }}}1

" vim: filetype=vim
" vim: foldlevel=0
