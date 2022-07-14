HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
#export AWS_ASSUME_ROLE_TTL=1h
#export AWS_SESSION_TTL=12h
# export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.9/site-packages
export BROWSER=/usr/bin/chromium
export VBOX_USB=usbfs
export EDITOR=nvim
export NNN_PLUG='p:preview-tui-ext;f:fzopen' 
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_BMS='d:~/Documents;w:~/Downloads/'
export LANG=en_US.UTF-8

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
# LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# https://antelo.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias kp='keepassxc ~/Documents/cloudinuse-custom.kdbx'
alias wo='cd ~/Documents/work'
alias wp='cd ~/Documents/work/wadzpay-service'
alias doc='cd ~/Documents'
alias viberkill='kill -9 $(ps -ef | pgrep viber)'
alias ll='ls -l'
alias w='ip a show wlp1s0'
alias e='ip a show enp0s31f6'
alias d='dragon-drag-and-drop -a -x'
alias x="xclip -selection clipboard"
alias x="pbcopy < "
alias lc='colorls -lA --sd'
alias tmux='tmux -u2'
alias vim='nvim'
alias ra='cd ~/Documents/work/red-queen-auth && source auth-venv/bin/activate'
alias rn='cd ~/Documents/work/red-queen-network && source net-venv/bin/activate'
alias rno='open "$(greadlink -f  "$(ls -tr newman/* | tail -n 1 )")"'
alias hg='cd ~/Documents/hugo/devopsinuse/hugo'
# alias rs='cd ~/Documents/work/testalchemy && source venv-sql/bin/activate'

alias gown='export GOOGLE_APPLICATION_CREDENTIALS=/home/jantoth/.google-cloud-keys/consummate-atom-309219-0b338646619a.json; gcloud config set account kubernetes.certification@gmail.com; gcloud config set project consummate-atom-309219'


alias gv='export GOOGLE_APPLICATION_CREDENTIALS=/home/jantoth/.google-cloud-keys/wadzpay-dev-cdb0bf1613d2.json; gcloud config set account jan.toth@vacuumlabs.com; gcloud config set project wadzpay-dev'

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
# ------------------------------------------------------------------------------
# Customize PROMPT
# ------------------------------------------------------------------------------

precmd_vcs_info() {
  vcs_info
}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst

export PROMPT="%F{196}%B%(?..?%? )%b%f%F{117}%2~%f%F{245} %#%f %B\$vcs_info_msg_0_%f%b "
#export RPROMPT="%B\$vcs_info_msg_0_%f%b"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{240}%b%u %f %F{237}%r%f'
zstyle ':vcs_info:*' enable git

#
#
#zstyle ':completion:*' menu select completer _expand _complete _ignored _correct _approximate
#
#zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:*' check-for-changes true
## Format the vcs_info_msg_0_ variable
## zstyle ':vcs_info:git:*' formats '%b'
#zstyle ':vcs_info:git*' formats "%b(%a)%m%u%c"
#zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#+vi-git-untracked(){
#    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
#        # This will show the marker if there are any untracked files in repo.
#        # If instead you want to show the marker only if there are untracked
#        # files in $PWD, use:
#        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#        hook_com[staged]+='T'
#    fi
#}
#precmd() { vcs_info }
#setopt PROMPT_SUBST
#PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}_%{$fg[green]%}:%{$fg[blue]%}%2~ %{$fg[green]%}${vcs_info_msg_0_}%{$fg[red]%}]%{$fg[yellow]%}%(1j.%j.)%{$reset_color%} %b'
## PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}arch%{$fg[green]%}:%{$fg[blue]%}${PWD##*/}%{$fg[green]%} ${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%} %b'

# Kubernetes
source <(kubectl completion zsh)
alias k=kubectl
# complete -F __start_kubectl k

f(){ fzf | xargs -ro  $EDITOR ; }

fpath+=$HOME/.zsh/pure

if type rg &> /dev/null; then
      export FZF_DEFAULT_COMMAND='rg --files'
      export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export PATH=$PATH:/home/jatoth/.vim
export GOPATH=/home/jantoth/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# export JAVA_HOME=/usr/lib/jvm/default-runtime

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/usr/local/opt/openjdk/bin:$PATH:/usr/local/Cellar/w3m/0.5.3_7/bin"
export HOMEBREW_NO_INSTALL_CLEANUP=true

alias stopj='limactl shell k8s sudo nerdctl stop jenkins'
alias remj='limactl shell k8s sudo nerdctl rm jenkins'
alias runj='limactl shell k8s sudo nerdctl run --name jenkins -p 8080:8080 -v /home/saq4a.linux/jenkins-configuration-as-code-blog/blog2-code/controller-configuration-jobDSL-orig.yaml:/var/jenkins.yaml -d --env JENKINS_ADMIN_PASSWORD=password jenkins:poc-v1'

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"


function scw-destroy() {
    scw_id=$(scw instance server list name=scw-k8s-cmd -ojson | jq -r '.[].id')
    scw instance server stop ${scw_id}

    cc=100
    echo -n "Stopping might take up to 500 [s] "
    until [[ "$(scw instance server list name=scw-k8s-cmd -ojson | jq -r '.[].state')" == "stopped" ]]; do
        echo -n .
        sleep 5
        let cc--
        [[ cc -eq 0 ]] && {echo "Error timed out"; return 1;}
    done

    echo
    scw instance server delete ${scw_id} with-ip
}


alias scw-start="scw instance server create type=DEV1-S zone=fr-par-1 image=ubuntu_focal root-volume=l:20G name=scw-k8s-cmdx ip=new project-id=431d432b-1849-445f-a66b-7d1ccdf5d34a cloud-init=@/Users/${USER}/Documents/hugo/devopsinuse/hugo/install_master.sh"


# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export PATH="/Users/saq4a/.local/bin:$PATH"
export PATH="/Users/saq4a/.local/opt/gitea:$PATH"

