#charset
export LANG=ja_JP.UTF-8

#vi mode
#bindkey -v

#http://journal.mycom.co.jp/column/zsh/001/index.html
autoload -U compinit
compinit
#PROMPT="%/%% "
#PROMPT2="%_%% "
#SPROMPT="%r is correct? [n,y,a,e]: "

#auto cd
setopt auto_pushd

#colors
autoload colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}(%s %b) %{'$reset_color'%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

#prompt
PROMPT="
%{${fg[yellow]}%}%~%{${reset_color}%}
[%n]$ "

#keybinds
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

#default permissions
umask 022

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
	alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias mvim='$HOME/shellscripts/mvim.sh'
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac
alias ll='ls -Fal'
alias apres='sudo /Applications/XAMPP/xamppfiles/xampp restartapache'
alias killds='find . -name "*.DS_Store" -type f -delete'
alias killthumbs='find . -name "Thumbs.db" -type f -delete'
alias devpochi='sudo dev_appserver.py --address=192.168.218.1 --datastore_path=pochi.db --port=80 pochi'
alias flushdns='dscacheutil -flushcache'
alias fiddle='cp ~/dev/emptyfiddle/* ./'
alias cof='coffee'
alias cofpile='coffee --compile'
alias putcake='cp ~/Dropbox/utils/node/Cakefile ./'

#svn
alias svnadd="svn st | grep '^?' | awk '{ print \$2 }' | xargs svn add"
alias svndel="svn st | grep '^!' | awk '{ print \$2 }' | xargs svn delete"

#ls, autocompl color
export LSCOLORS=DxGxcxdxCxegedabagacad
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#title
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${PWD}\007"
    }
    ;;
esac

# gisty config
export GISTY_DIR="$HOME/dev/gists"
export GISTY_ACCESS_TOKEN=6839feadf8abd9cb07ad6939fbed58beba879d7b

# use nvm
#. ~/.nvm/nvm.sh 
#if [[ -f ~/.nvm/nvm.sh ]]; then
#    source ~/.nvm/nvm.sh
#	nvm use v0.6.10
#fi
#nvmでNode.jsのバージョンを自動で設定する
# nvm と指定されたバージョンの Node.js がインストール済みの場合だけ
# 設定を有効にする
if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh

  if which nvm >/dev/null 2>&1 ;then
    _nodejs_use_version="v0.6.19"
    if nvm ls | grep -F -e "${_nodejs_use_version}" >/dev/null 2>&1 ;then
      nvm use "${_nodejs_use_version}" >/dev/null
    fi
    unset _nodejs_use_version
  fi
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

alias rake="noglob rake"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# brew python
export PATH="/usr/local/share/python:${PATH}"
