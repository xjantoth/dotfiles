# vi:syntax=sh

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
alias ll='ls -l'
#alias d='dragon-drag-and-drop -a -x'
#alias x="xclip -selection c"
alias tmux='tmux -u2'
# ~/.local/share/lunarvim/lvim
# git -C ~/.local/share/lunarvim/lvim diff
alias vim='~/.local/bin/lvim'
alias lvim='~/.local/bin/lvim'
alias lt='lvim ~/.local/share/lunarvim/lvim/lua/lvim/core/telescope.lua'
alias lg='git -C ~/.local/share/lunarvim/lvim diff'
alias lff='cd ~/.local/share/lunarvim/lvim'
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
# KeepassXC using password from local gpg via pass binary
alias kx-list='echo $(pass keepassxc-password) | keepassxc-cli ls   ~/Documents/keepassxc-toth.kdbx'
alias kx-clip='echo $(pass keepassxc-password) | keepassxc-cli clip ~/Documents/keepassxc-toth.kdbx'

alias gd='git diff ORIG_HEAD..'
alias gpp='git push --set-upstream $(git remote show) $(git branch --show-current)'
alias gp='git pull'
alias cm='echo "git commit -m \"${${$(git branch --show-current)##*/}:0:8} \""'
# Using az binary when behind corporate proxy
alias azp='export REQUESTS_CA_BUNDLE=/opt/homebrew/Cellar/azure-cli/2.57.0/libexec/lib/python3.11/site-packages/certifi/cacert.pem'

alias ff='cd ~/Documents/work/$(cd ~/Documents/work && ls -d */  | fzf)'
alias gg="git branch -a | sed 's|remotes\/origin\/||' | fzf --height=20% --reverse --info=inline | xargs git checkout"
alias ss="tmux list-windows -F '#I #W' | fzf | cut -d' ' -f1 | xargs tmux select-window -t"
alias dots='open https://github.com/xjantoth/dotfiles'

# To detect duplicates in yaml list
# yq -o=json eval  data/prod/root.yaml | jq '.ldap.ldap.members  | group_by(.) | map(select(length>1) | .[0])'
# fzf --preview 'bat --color=always {}'

cme() {git commit -m \""${${$(git branch --show-current)##*/}:0:8} ${*}"\"}
f(){ fzf --preview 'bat {}' | xargs -I % sh -c '$EDITOR %; echo %; echo % | pbcopy' }
vs(){ fzf | xargs -I % sh -c 'code %; echo %; echo % | pbcopy' }

ggo() {
   # Opens Bitbucket URL in a Web Browser based on `git remote -v command` like command
   repo_name=$(basename ${${${${$(git remote get-url origin)#*@}/:7999/}/.git/}/\//\/projects\/})
   open ${${${${${${$(git remote get-url origin)#*@}/:7999/}/.git/}/\//\/projects\/}/%$repo_name/repos\/$repo_name}/#/https:\/\/}
}

b(){
  # Search through Chrome bookmarks using jq and fzf
   RESULT="$(echo $(cat ~/Library/Application\ Support/Google/Chrome/Default/Bookmarks | \
     jq -r '.roots.bookmark_bar.children | .[] | [.name, .url] | join(" ")' |  fzf --height=65% )|  awk '{print $NF}')"
   if [[ "${RESULT}" != "" ]]; then
     open "${RESULT}"
   fi
}


# When Python has a problem with SSL Certificate interceotion
export REQUESTS_CA_BUNDLE=~/Documents/proxyCA.crt

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

function tc() {
  # set -xT
  FILE="/tmp/$(date +"%Y-%m-%dT%H:%M:%S").txt"
  CLONED_REPOS="/tmp/cloned-$(date +"%Y-%m-%dT%H:%M:%S").txt"
  find ~/Documents/work -maxdepth 1 -type d | nl -v8 -s: | nl -v8 -s: > "${CLONED_REPOS}"

  PASS=$(echo $(pass keepassxc-password) | keepassxc-cli show -sa password ~/Documents/keepassxc-toth.kdbx  "cleaner/bitbucket-token")
  SUSER=$(echo $(pass keepassxc-password) | keepassxc-cli show -sa username ~/Documents/keepassxc-toth.kdbx  "cleaner/bitbucket-suser")
  BITBUCKET_URL=$(echo $(pass keepassxc-password) | keepassxc-cli show -sa url ~/Documents/keepassxc-toth.kdbx  "cleaner/bitbucket-url")

  for i in HORIZON TFE-GCP-MODULES AZURE O365 TFE-GCP-DATABASES CS-ATRON MONGODBATLAS GCP-WEBFOCUS GCP-DATAPLATFORM-CUSTOMERINSIGHTS_RETAIL-AT; do 
    curl -s -u "${SUSER}:$PASS" -X GET "https://${BITBUCKET_URL}/rest/api/1.0/projects/${i}/repos?limit=1000" | jq -r '.values|.[]|.name' \
      | sed 's|^|'"$i/"'|' >> ${FILE}; 
  done

  # Clone repositories
  while read -r i; do
    repo="${i##*/}"
    if [[ "$(grep -E "${repo}" "${CLONED_REPOS}")" == "" ]]; then
      full="${i// /-}"
      lpath="${repo// /-}"
      echo "git clone ssh://git@${BITBUCKET_URL}:7999/${full}.git ~/Documents/work/${lpath}"
      git clone ssh://git@${BITBUCKET_URL}:7999/${full}.git ~/Documents/work/${lpath}
    fi
  done < "${FILE}"

  :> ${FILE}
  # Update file after cloning
  for i in HORIZON TFE-GCP-MODULES AZURE O365 TFE-GCP-DATABASES CS-ATRON MONGODBATLAS GCP-WEBFOCUS GCP-DATAPLATFORM-CUSTOMERINSIGHTS_RETAIL-AT; do 
    curl -s -u "${SUSER}:$PASS" -X GET "https://${BITBUCKET_URL}/rest/api/1.0/projects/${i}/repos?limit=1000" | jq -r '.values|.[]|.name' \
      | sed 's|^|'"$i/"'|' >> ${FILE}; 
  done

  tmux new-session -s "mac" -n work -d

  tmux new-window -t "mac:2" -n "home" -c "${HOME}";
  tmux new-window -t "mac:3" -n "Documents" -c "${HOME}/Documents";
  tmux new-window -t "mac:4" -n "Downloads" -c "${HOME}/Downloads";
  tmux new-window -t "mac:5" -n ".tmux.conf" -c "${HOME}";
  tmux new-window -t "mac:6" -n ".zshrc" -c "${HOME}";
  tmux new-window -t "mac:7" -n "tmp" -c "/tmp";

  for i in  $(ls -d ~/Documents/work/*/ | nl -v8 -s:); do

    real_wdir=${${i##*:}%/*}
    fancy_wdir=$(grep -E "/${real_wdir##*/}$" $FILE)

    if [[ "$fancy_wdir" == "" ]]; then
      name=${real_wdir##*/}
    else
      name=$fancy_wdir
    fi

    tmux new-window -t "mac:${i%:*}" -n "${name}" -c "${real_wdir}";
    tmux split-window -t "mac:${i%:*}" -v -c "#{pane_current_path}" -l '14%';
    tmux select-pane -t "mac:${i%:*}" -U;
  done
}

# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#using-fzf-as-interactive-ripgrep-launcher
hh(){
  export BAT_THEME='zenburn' # 'gruvbox-dark'
  export BAT_THEME='gruvbox-dark'
  cd /Users/$(whoami)/Documents/work/devopsinuse/hugo/content/english/blog/
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --prompt '1. ripgrep> ' \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(lvim {1} +{2})'
  cd -
}

ww(){
  export BAT_THEME='gruvbox-dark'
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --prompt '1. ripgrep> ' \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(lvim {1} +{2})'
}

solution(){

  for i in $(find . -type f -name "RI*.yaml" | xargs -I % sh -c 'echo %'); do 
    FN=${i##*/}; 
    name=$(yq -o json eval $i | jq -r '[(.solution_name),(.use_case // ""),(if .suffix then .suffix|tostring else "0" end)]| map(select(length > 0)) | join("-")'); 
    oo=${${i##*organization/}%%/*}; 
    if [[ "$oo" == *"dev"* ]]; then org="deaut"; else org="eaut"; fi; 

    project_name="$org-${${i##*environments/}%%/*}-$name"; 
    echo "${i} ${project_name}"

  # done | fzf --preview 'bat {1}' | xargs -I % sh -c '$EDITOR %; echo %; echo % | pbcopy'
  done > /tmp/solutions.txt
  
  export BAT_THEME='gruvbox-dark'
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case < /tmp/solutions.txt"

  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --prompt '1. ripgrep> ' \
      --delimiter ': ' \
      --preview 'bat --color=always -l yaml $(echo {1} | grep -oE "\.\/.*\s")' \
      --preview-window 'up,80%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(lvim $(echo {1} | grep -oE "\.\/.*\s"); echo $(echo {1} | grep -oE "\.\/.*\s"); echo $(echo {1} | grep -oE "\.\/.*\s") | pbcopy)'
    
}

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

ulimit -n 1024

# Gcloud host
# gcloud config set auth/token_host https://oauth2-eautsc.p.googleapis.com/token
# v organization/*/*/*/*/XZY*.yaml
# :bufdo exe "g/bigtable.googleapis.com/d" | update

# cat JIRA....csv  | python3 -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))' | jq -r '.[] | select(.Status=="Done" and ."Issue Type"=="Story") | [(."Issue key", .Summary, .Status, .Assignee)] | join(" ")'


# yq -o=json eval  data/prod/azure-eg.yaml | jq '.workspaces | [keys[] as $k | {($k): .[$k]["vcs_repo"].identifier}] | add'


# https://dev.to/jma/using-brewfile-to-automatic-setup-macos-from-scratch-4ok1
# brew bundle dump
# brew bundle
# terraform state  mv 'tfe_project.project["azure-deveg_loganalytics"]' 'tfe_project.project["azure-deveg_o365"]'
#
