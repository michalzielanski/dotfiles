(( $+commands[bat] )) || return

#export MANPAGER="bat --plain --language=man"

alias -g -- -h='-h 2>&1 | bat --plain --paging=never --language=help'
alias -g -- --help='--help 2>&1 | bat --plain --paging=never --language=help'

