(( $+commands[eza] )) || return

export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza

alias ls="eza --icons --hyperlink"
alias ll="eza --long --group --all --mounts --icons --hyperlink"
alias llt2="${aliases[ll]} --tree --level=2"
