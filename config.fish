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

# githubにリポジトリを作り、ghqで取得、vscodeでひらく
function ghcr
 gh repo create $argv
 ghq get $argv[1]
 code (ghq list --full-path -e $argv[1])
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# google cloud sdk
# ""の中に$()を入れてもそのコマンドが実行されない
# source "(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
