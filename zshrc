# Path to your oh-my-zsh installation.
export ZSH="/home/dn/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=30

#  case-sensitive completion.
CASE_SENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
    gitfast
	zsh-syntax-highlighting
	zsh-autosuggestions
    docker
)

source $ZSH/oh-my-zsh.sh

# init autocomplete
#autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# venv aliases
source ~/.scripts/venv_aliases.sh

# set bash prompt
source ~/.scripts/bash_prompt.sh

# a hisotrian
    HISTSIZE=10000000
HISTFILESIZE=10000000

for al in `git config --get-regexp alias | cut -d"." -f2 | cut -d" " -f1`; do
    alias g$al="git $al"
done

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
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

# ===================== Aliases =====================

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias l="ls -lAh -G --color=auto"
alias ll="ls -lh -G --color=auto"

alias v="f -e nvim"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

alias cdg="cd ~/github"
alias cdd="cd ~/github/dotfiles"

alias cat='bat'
alias run-ssh-agent='eval $(ssh-agent -s) ; ssh-add ~/.ssh/id_ed25519'

alias t='tmux -2 new-session -ADs dn'
