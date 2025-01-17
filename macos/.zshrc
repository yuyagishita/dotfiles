autoload -U compinit promptinit
compinit
promptinit

setopt correct

#autoload predict-on
#predict-on

prompt walters

#unsetopt auto_list
#unsetopt auto_menu
unsetopt promptcr

# aliases
## ls
alias la='ls -aF --color=auto'
alias lla='ls -alF --color=auto'
alias lal='ls -alF --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias l.='ls -d .[a-zA-Z]* --color=auto'
if type exa > /dev/null; then
  alias la='exa -aF --icons'
  alias lla='exa -alF --icons'
  alias lal='exa -alF --icons'
  alias ls='exa --icons'
  alias ll='exa -l --icons'
  alias l.='exa -d .[a-zA-Z]* --icons'
fi

## git & docker & k8s
alias g=git
alias d=docker
alias k=kubectl

# fzf
source <(fzf --zsh)
fzf-ghq() {
  local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs exa -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
  if [ -n "$repo" ]; then
    repo=$(ghq list --full-path --exact $repo)
    BUFFER="cd ${repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-ghq
bindkey '^g' fzf-ghq

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Starship
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#ZSH_AUTOSUGGEST_STRATEGY='completion'

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Google
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# k8s
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
