#!/bin/bash
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the active virtualenv
#    * the branch/status of the current git repository
#    * the return value of the previous command
#    * the fact you just came from Windows and are used to having newlines in
#      your prompts.
#
# USAGE:
#
#   1. Save this file as ~/.bash_prompt
#   2. Add the following line to the end of your ~/.bashrc or ~/.bash_profile:
#        . ~/.bash_prompt
#
# LINEAGE:
#
#   Based on work by woods
#
#   https://gist.github.com/31967

# The various escape codes that we can use to color our prompt.
      GREEN="%F{green}"
     YELLOW="%F{yellow}"
       BLUE="%F{blue}"
       RED="%F{red}"
       CYAN="%F{cyan}"
 COLOR_NONE="%f"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your branch is (.*) of|by"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${match[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  SEPARATOR=$'\n'
  branch_pattern="^On branch ([^${SEPARATOR}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${match[1]}
  fi

  # Set the final branch string.
  BRANCH=" ${state}(${branch})${remote}${COLOR_NONE}"
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if [ "$1" -eq "0" ]; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${RED}\$${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if [ -z "${VIRTUAL_ENV}" ] ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}(`basename \"$VIRTUAL_ENV\"`)${COLOR_NONE}"
  fi

}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  # Set the bash prompt variable.
  #PS1="${PYTHON_VIRTUALENV}\u@\h:${CYAN}\w${COLOR_NONE}${BRANCH}${PROMPT_SYMBOL} "
  PROMPT="${PYTHON_VIRTUALENV}%n@%m:${CYAN}%~${COLOR_NONE}${BRANCH}${PROMPT_SYMBOL} "
# ${PYTHON_VIRTUALENV}${GREEN}\u@\h ${YELLOW}\w${COLOR_NONE} ${BRANCH}${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.

# for bash
#PROMPT_COMMAND=set_bash_prompt
#set_bash_prompt

precmd() { eval "set_bash_prompt" }
