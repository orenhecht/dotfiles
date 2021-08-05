#!/usr/bin/zsh

zinit wait lucid light-mode for \
      OMZ::lib/compfix.zsh \
      OMZ::lib/completion.zsh \
      OMZ::lib/git.zsh \
  atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
      OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh \
      OMZ::plugins/command-not-found/command-not-found.plugin.zsh \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  as"completion" \
      OMZ::plugins/docker/_docker

# Recommended Be Loaded Last.
zinit ice wait blockf lucid atpull'zinit creinstall -q .'
zinit load zsh-users/zsh-completions

