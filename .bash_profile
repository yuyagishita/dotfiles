# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
export PYENV_ROOT=/usr/local/var/pyenv
 
# pyenvさんに自動補完機能を提供してもらう
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

eval "$(pyenv init -)"
 
#export GOPATH=$(go env GOPATH)
#export PATH=$PATH:$(go env GOPATH)/bin

alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
#alias brew="env PATH=${PATH/\/usr\/local\/var\pyenv\/shims/:/} brew"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/yu.yagishita/.sdkman"
[[ -s "/Users/yu.yagishita/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/yu.yagishita/.sdkman/bin/sdkman-init.sh"
. "$HOME/.cargo/env"
