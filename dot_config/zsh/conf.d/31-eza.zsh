(( $+commands[eza] )) || return

export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza

alias ls="eza --icons=auto --hyperlink=auto"
alias ll="eza --long --group --all --mounts --icons=auto --hyperlink=auto"
alias llt2="${aliases[ll]} --tree --level=2"
