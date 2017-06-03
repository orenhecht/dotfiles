alias ll="ls -l"
alias la="ls -l -a"

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

alias g="git"

# mkvirtualenv
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
alias mkvirtualenv3="mkvirtualenv --python=\`which python3\`"

# fzf shell extension
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h:\[\033[32m\]\w\[\033[00m\]\[\033[36m\]\$(parse_git_branch)\[\033[00m\]$ "

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
