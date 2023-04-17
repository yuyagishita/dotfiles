autoload -U compinit promptinit
compinit
promptinit

setopt correct

autoload predict-on
predict-on

prompt walters

# hisotry
HISTFILE="${ZDATADIR}/zsh_history"
HISTSIZE=10000
SAVEHIST=100000

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
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
# bindkey '^[s' fzf-ghq
bindkey '^g' fzf-ghq

# aliases
# ls
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

# git & docker & k8s
alias g=git
alias d=docker
alias k=kubectl

# Starship
eval "$(starship init zsh)"

# kubectl
source <(kubectl completion zsh)

# Haskell
[ -f "/home/yu/.ghcup/env" ] && source "/home/yu/.ghcup/env" # ghcup-env