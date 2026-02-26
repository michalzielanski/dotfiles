alias ll='ls -lah'
alias ldot='ls -ld .*'
alias grep="${aliases[grep]:-grep} --exclude-dir={.git,.svn,.vscode,.idea}"

alias tarls='tar -tvf'

alias dl='curl --continue-at - --location --progress-bar --remote-name --remote-time'

alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'

alias print-fpath='for fp in $fpath; do echo $fp; done; unset fp'
alias print-opts='setopt | sed "s/^/ON  /"; unsetopt | sed "s/^/OFF /"'
alias print-default-opts='emulate -lLR zsh'
alias print-path='echo $PATH | tr ":" "\n"'
alias print-functions='print -l ${(k)functions[(I)[^_]*]} | sort'

