if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
"set fileencodings=ucs-bom,default,latin1,utf-8
set helplang=ja
set nomodeline
set printoptions=paper:a4
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
set backspace=indent,eol,start
set autoread
set nostartofline
set virtualedit=block

set history=2000
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/neobundle.vim/
set swapfile
set directory=$HOME/.vimswap

set incsearch
set ignorecase
set smartcase
set wrapscan

set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab

set formatoptions-=c
setlocal formatoptions-=ro
set showmatch

set number
set relativenumber
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

set ruler

set list
set listchars=tab:>-,trail:-,eol:▸
set hlsearch
set cmdheight=1
set cursorline
set clipboard=autoselect
set clipboard=unnamedplus

"エンコード設定
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

"=============================================
" Key Config
"=============================================

imap <c-k> <esc>
"<S-s>で.vimrc再読み込み
map S :source $HOME/.vimrc<CR>

"ZZは強制的に書き込む
map ZZ :wq!<CR>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
"##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######

"=============================================
"NeoBundle
"=============================================
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'itchyny/lightline.vim'
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
call neobundle#end()

colorscheme badwolf
syntax on
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
filetype plugin on
filetype indent on

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \}

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

