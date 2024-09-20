HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000000
setopt appendhistory
setopt share_history
setopt inc_append_history

autoload -U +X compinit && compinit

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
#export AWS_ASSUME_ROLE_TTL=1h
#export AWS_SESSION_TTL=12h
# export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.9/site-packages
export BROWSER=/usr/bin/chromium
export EDITOR=lvim
export LANG=en_US.UTF-8

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

setopt interactivecomments

bindkey '^[[3~' delete-char 
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
bindkey -e

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

autoload -U colors && colors    # Load colors
autoload -Uz compinit promptinit vcs_info
compinit
promptinit

zstyle ':completion:*' menu select completer _expand _complete _ignored _correct _approximate
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
precmd() { vcs_info }
zstyle ':vcs_info:git*' formats "%b(%a)%m%u%c"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
setopt PROMPT_SUBST

PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}arch%{$fg[green]%}:%{$fg[blue]%}${PWD##*/}%{$fg[green]%} ${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%} %b'

# Kubernetes
source <(kubectl completion zsh)
alias k=kubectl
# complete -F __start_kubectl k


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# https://antelo.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias kp='keepassxc ~/Documents/cloudinuse-custom.kdbx'
alias wo='cd ~/Documents/work'
alias doc='cd ~/Documents'
alias viberkill='kill -9 $(ps -ef | pgrep viber)'
alias ll='ls -l'
alias d='dragon-drag-and-drop -a -x'
alias x="xclip -selection c"
alias lc='colorls -lA --sd'
alias tmux='tmux -u2'
# ~/.local/share/lunarvim/lvim
# git -C ~/.local/share/lunarvim/lvim diff
alias vim='~/.local/bin/lvim'
alias lvim='~/.local/bin/lvim'
alias lt='lvim ~/.local/share/lunarvim/lvim/lua/lvim/core/telescope.lua'
alias lg='git -C ~/.local/share/lunarvim/lvim diff'
alias lf='cd ~/.local/share/lunarvim/lvim'
alias lk='lvim ~/.local/share/lunarvim/lvim/lua/lvim/core/which-key.lua'
alias lck='lvim ~/.local/share/lunarvim/lvim/lua/lvim/keymappings.lua'
alias lgdiff='git -C ~/.local/share/lunarvim/lvim diff > ~/.config/lvimdiff'
alias lll='alias | sort | grep "^l"'

alias c='pbcopy <<<$(echo " ¯\_(ツ)_/¯")'
alias p='lvim ~/.config/nvim/lua/plugins/example.lua'
alias z='lvim ~/.zshrc'
alias t='lvim ~/.tmux.conf'
alias dev='cd ~/Documents/work/devopsinuse/'
alias v='lvim'
alias s='source ~/.zshrc'

alias gd='git diff ORIG_HEAD..'

# https://dev.to/jma/using-brewfile-to-automatic-setup-macos-from-scratch-4ok1
# brew bundle dump
# brew bundle
#
# When Python has a problem with SSL Certificate interceotion
export REQUESTS_CA_BUNDLE=~/Documents/proxyCA.crt

# Using az binary when behind corporate proxy
alias azp='export REQUESTS_CA_BUNDLE=/opt/homebrew/Cellar/azure-cli/2.57.0/libexec/lib/python3.11/site-packages/certifi/cacert.pem'

alias ff='cd ~/Documents/work/$(cd ~/Documents/work && ls -d */  | fzf)'
alias gg="git branch -a | sed 's|remotes\/origin\/||' | fzf --height=20% --reverse --info=inline | xargs git checkout"


alias tt='tmux list-windows | fzf | cut -d: -f1 | xargs tmux select-window -t'
# How to get Primary Proxy Root certificate intercepting each and every reguest behind company proxy
# openssl s_client -showcerts -connect amazon.de:443 2>/dev/null </dev/null |  sed -ne '/s:CN=EGB SHA2 Primary Proxy Root,/,/-END CERTIFICATE-/p' | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/proxyCA.crt
#
function git-prune-branches() {
  echo "switching to master or main branch.."
  git branch | grep 'main\|master' | xargs -n 1 git checkout
  echo "fetching with -p option...";
  git fetch -p;
  echo "running pruning of local branches"
  git branch -vv | grep ': gone]'|  grep -v "\*" | awk '{ print $1; }' | xargs -r git branch -D ;
}

function tmux-crowler ()
{
  tmux new-session -s "mac" -n work -d

  tmux new-window -t "mac:2" -n "~" -c "${HOME}";
  tmux select-pane -t "mac:2" -U;

  for i in  $(ls -d ~/Documents/work/*/ | nl -v3 -s:); do
    wdir=${i##*:}
    DIR=${wdir%/*}
    tmux new-window -t "mac:${i%:*}" -n "${DIR}" -c "${DIR}";
    tmux split-window -t "mac:${i%:*}" -v -c "#{pane_current_path}" -l '14%';
    tmux select-pane -t "mac:${i%:*}" -U;
  done
  

}

f(){ fzf | xargs -I % sh -c '$EDITOR %; echo %; echo % | pbcopy' }


# open_file creates and opens a file in the specified directory
hp() {
  local PWD=$HOME/Documents/work/devopsinuse/hugo/content/english/blog

  echo -n "Enter a filename: "
  read REPLY
  title=$REPLY
	date=$(date +"%Y-%m-%dT%H:%M:%S%z")
	timestamp="$(date +"%Y%m%d%H%m")"
	# Cd into the directory
	# Create the file in the specified directory
	filename=$PWD/$(echo $title | tr " " "-").md
	touch $filename

	echo -e "---
title: $title
date: $date
lastmod: $date
draft: false
description: $title
image: \"images/blog/linux-1.jpg\"
author: \"Jan Toth\"
tags:
  - bash
  - devopsinuse
---


## Links:

$timestamp
" >>$filename

	# Open the file in Neovim
   lvim '+ normal 2GzzA' $filename

}


# KeepassXC using password from local gpg via pass binary
alias kx-list='echo $(pass keepassxc-password) | keepassxc-cli ls   ~/Documents/keepassxc-toth.kdbx'
alias kx-clip='echo $(pass keepassxc-password) | keepassxc-cli clip ~/Documents/keepassxc-toth.kdbx'

# Gcloud host
# gcloud config set auth/token_host https://oauth2-eautsc.p.googleapis.com/token
