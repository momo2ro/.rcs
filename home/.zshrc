# Created by newuser for 4.3.9

export EDITOR=vim
export LANG=ja_JP.UTF-8
bindkey -v
setopt NO_BEEP
#バックグラウンドジョブの状態変化を即時報告する
setopt NOTIFY
#=commandを`which command`と同じ処理にする
setopt EQUALS
#プロンプトの設定
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(</etc/debian_chroot)
fi

PROMPT="${debian_chroot:+($debian_chroot)}%n@%m:%c%# "
#lesspipe
eval "$(lesspipe.sh)"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export XMODIFIERS="@im=uim"
export GTK_IM_MODULE="uim"
#=============================================
# Completion Config
#=============================================

#補完機能を使用する
setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix
autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*:default' menu select true
zstyle ':completion:*:default' menu select=1
#autoload -Uz compinit && compinit
#compinit
#zstyle ':completion:*' menu select
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
#zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
#
#typeset -ga chpwd_functions
#
##chpwd_recent_dirsでセッションと無関係にディレクトリ補完(>=4.3.11)
#autoload -U chpwd_recent_dirs cdr
#chpwd_functions+=chpwd_recent_dirs
#zstyle ":chpwd:*" recent-dirs-max 500
#zstyle ":chpwd:*" recent-dirs-default true
#zstyle ":completion:*" recent-dirs-insert always

#大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

#コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#予測入力させる
autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^P' predict-on
bindkey '^O' predict-off
zstyle ':predict' verbose true

#入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#入力途中の履歴補完
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#インクリメンタルサーチの設定
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

#履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


#タブキーの連打で自動的にメニュー補完
setopt AUTO_MENU

#/foo/barでいきなりcd
setopt AUTO_CD
cdpath=(.. $HOME $HOME/download)

#cd時にディレクトリスタックにpush
setopt AUTO_PUSHD

#コマンドのスペルを訂正
setopt CORRECT

#=以降も補完する(--prefix=/usrなど)
setopt MAGIC_EQUAL_SUBST

#"~$var" でディレクトリにアクセス
setopt AUTO_NAME_DIRS

#補完が/で終って、つぎが、語分割子か/かコマンドの後(;とか&)だったら、補完末尾の/を取る
unsetopt AUTO_REMOVE_SLASH

#補完候補を一覧表示
setopt AUTO_LIST

#変数名を補完する
setopt AUTO_PARAM_KEYS

#補完候補の表示領域を小さく
setopt LIST_PACKED

#補完候補にファイルの種類も表示
setopt LIST_TYPES

#Shift-Tabで補完候補を逆順("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

#=============================================
# History Config
#=============================================

#ヒストリーサイズ設定
HISTFILE=$HOME/.zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
PATH=${PATH}:~/bin

#ヒストリに実行時間も保存する
setopt EXTENDED_HISTORY

#直前と同じコマンドはヒストリに追加しない
setopt HIST_IGNORE_DUPS

#他のシェルのヒストリをリアルタイムで共有する
setopt SHARE_HISTORY

#マッチしたコマンドのヒストリを表示
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#=============================================
# Aliases
#=============================================
alias su='sudo -i'
alias mpg123='mpg123 -vC'
alias synaptic='sudo synaptic'
alias apt-get='sudo apt-get'
alias aptitude='sudo aptitude'
alias pacman='sudo pacman'
alias ls='ls -a --color=auto'
alias ll='ls -alh --color=auto'
alias v='vim'
alias less='less -N'
alias cp='cp -i'
alias rm='rm -i'
alias w3m='w3m http://google.com'
alias mkcd='source $HOME/bin/mkcd.sh'
alias gcc='gcc-4.8'
alias gia='git add .'
alias gic='git commit'
alias gipo='git push origin master'


#=============================
# source auto-fu.zsh
#=============================
#if [ -f ~/.zsh/auto-fu.zsh ]; then
#	source ~/.zsh/auto-fu.zsh
#	function zle-line-init () {
#	auto-fu-init
#}
#zle -N zle-line-init
#zstyle ':completion:*' completer _oldlist _complete _match _ignored \
#	    _approximate _list _history
#fi
##-azfu-非表示
#zstyle ':auto-fu:var' postdisplay $''

# tmux (auto start)
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmuxx >/dev/null 2>&1; then
            tmuxx
        elif type tmux >/dev/null 2>&1; then
		if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
			tmux attach && echo "tmux attached session "
		else
			tmux new-session && echo "tmux created new session"
        fi
    elif type screen >/dev/null 2>&1; then
            screen -rx || screen -D -RR
        fi
fi

# Setup zsh-autosuggestions
source ~/.zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically
zle-line-init() {
        zle autosuggest-start
}
zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle
# Accept suggestions without leaving insert mode
bindkey '^f' vi-forward-word
