if (( $+commands[hx] )); then
  export EDITOR=hx
elif (( $+commands[nvim] )); then
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  export EDITOR=vim
elif (( $+commands[vi] )); then
  export EDITOR=vi
elif (( $+commands[nano] )); then
  export EDITOR=nano
fi

if (( $+commands[cot] )); then
  export VISUAL=cot
elif (( $+commands[zed] )); then
  export VISUAL=zed
fi

export PAGER=less
