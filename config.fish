set -U FZF_LEGACY_KEYBINDINGS 0
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set XDG_CONFIG_HOME ~/.config

# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
export PYENV_ROOT=/usr/local/var/pyenv

# pyenvさんに自動補完機能を提供してもらう
#if which pyenv > /dev/null; then eval "(pyenv init -)"; end

# Load pyenv automatically by appending
# the following to ~/.config/fish/config.fish:

status --is-interactive; and source (pyenv init -|psub)

alias brew="env PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
#alias brew="env PATH={PATH/\/usr\/local\/var\/pyenv\/shims/} brew"
alias g git
alias d docker

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

function ghcr
 gh repo create $argv
 ghq get $argv[1]
 code (ghq list --full-path -e $argv[1])
end
