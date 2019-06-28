# ===================== General Settings =====================

# mkvirtualenv
export WORKON_HOME=$HOME/.virtualenvs
mkdir -p $WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6
source $HOME/.local/bin/virtualenvwrapper.sh
alias mkvirtualenv3="mkvirtualenv --python=\`which python3.6\`"

# bash-completion
if [ "$(uname)" == "Darwin" ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
else
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
        . /usr/share/bash-completion/completions/git
    fi
fi

# fzf shell extension
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# nicer prompt
source ~/.scripts/bash_prompt.sh

# autojump
source /usr/share/autojump/autojump.bash

# a hisotrian
    HISTSIZE=10000000
HISTFILESIZE=10000000

# load all git aliases to g<alias>
function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `git config --get-regexp alias | cut -d"." -f2 | cut -d" " -f1`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done



# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


# ===================== Functions =====================

function g() {
    if [[ $# > 0 ]]; then
        # if there are arguments, send them to git
        git $@
    else
        # otherwise, run git status
        git status
    fi
}

# Create a new directory and enter it
function md() {
    mkdir -p "$@" && cd "$@"
}



# ===================== Aliases =====================

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias l="ls -lAh -G --color=auto"
alias ll="ls -lh -G --color=auto"

alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

alias cdg="cd ~/github"
alias cdd="cd ~/github/dotfiles"

alias cat='bat'
alias run-ssh-agent='eval $(ssh-agent -s) ; ssh-add ~/.ssh/id_rsa'

alias t='tmux attach -d'
