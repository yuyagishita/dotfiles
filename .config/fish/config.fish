starship init fish | source
set -U FZF_LEGACY_KEYBINDINGS 0

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

set XDG_CONFIG_HOME ~/.config

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-interactive; and pyenv init --path | source
pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias brew="env PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
#alias brew="env PATH={PATH/\/usr\/local\/var\/pyenv\/shims/} brew"
alias g git
alias d docker
if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

eval (gh completion -s fish| source)

function attach_tmux_session_if_needed
    set ID (tmux list-sessions)
    if test -z "$ID"
        tmux new-session
        return
    end

    set new_session "Create New Session" 
    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
    if test "$ID" = "$new_session"
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end
 
 if test -z $TMUX && status --is-login
     attach_tmux_session_if_needed
 end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# google cloud sdk
# ""の中に$()を入れてもそのコマンドが実行されない
# source "(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# flutter
set PATH ~/development/flutter/bin $PATH

# Volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
