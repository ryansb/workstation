zstyle -a ':prezto:module:custom' hackmode 'hackmodes'
if (( $#hackmodes > 0 )); then
  source ~/.dotfiles/zsh/custom/zaw/zaw.zsh
  bindkey '^R' zaw-history
  bindkey -M filterselect '^R' down-line-or-history
  bindkey -M filterselect '^E' up-line-or-history

  zstyle ':filter-select:highlight' matched fg=green
  zstyle ':filter-select' max-lines 5
  zstyle ':filter-select' case-insensitive yes
fi
unset hackmodes
