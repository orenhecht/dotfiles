# ===================== General Settings =====================


# bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
    . /usr/share/bash-completion/completions/git
fi

# fzf shell extension
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# nicer prompt
source ~/.scripts/bash_prompt.sh

# venv aliases
source ~/.scripts/venv_aliases.sh

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
    function_exists $complete_fnc && __git_complete g$al $complete_func  &>/dev/null
done



# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

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
alias run-ssh-agent='eval $(ssh-agent -s) ; ssh-add ~/.ssh/id_ed25519'

alias t='tmux -2 new-session -ADs dn'
