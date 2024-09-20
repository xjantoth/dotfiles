HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory

autoload -U +X compinit && compinit

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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
# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git*' formats "%b(%a)%m%u%c"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
setopt PROMPT_SUBST

# PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}arch%{$fg[green]%}:%{$fg[blue]%}${PWD/#$HOME/~}%{$fg[green]%} ${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%} %b'
PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}arch%{$fg[green]%}:%{$fg[blue]%}${PWD##*/}%{$fg[green]%} ${vcs_info_msg_0_}%{$fg[red]%}]%{$reset_color%} %b'

# Kubernetes
source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k

f(){ fzf | xargs -ro  $EDITOR ; }

#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh

fpath+=$HOME/.zsh/pure

if type rg &> /dev/null; then
      export FZF_DEFAULT_COMMAND='rg --files'
      export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export PATH=$PATH:/home/jatoth/.vim
export GOPATH=/home/jantoth/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/Applications/flameshot.app/Contents/MacOS/

# export JAVA_HOME=/usr/lib/jvm/default-runtime

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
alias lll='alias | sort | grep "^l"'

alias c='pbcopy <<<$(echo " ¯\_(ツ)_/¯")'
alias p='lvim ~/.config/nvim/lua/plugins/example.lua'
alias z='lvim ~/.zshrc'
alias t='lvim ~/.tmux.conf'
alias dev='cd ~/Documents/work/devopsinuse/'
alias v='lvim'
alias s='source ~/.zshrc'
