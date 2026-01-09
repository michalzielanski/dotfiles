HISTSIZE=11000
SAVEHIST=10000

HISTORY_IGNORE="(history|clear|pwd|exit|logout|l[sl]|l[sl] *|man|ps|ps -A|kill *|killall *|top|[hb]top|mactop|mc|less *|ping *|* --help)"

setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove extra blanks from commands added to the history list.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.

alias eh='export HISTFILE=/dev/null'
alias history='history -n 1'
