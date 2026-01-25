(( $+commands[fzf] )) || return

# Setup fzf key bindings and fuzzy completion.
# Must be called after "30-line-editor.zsh".
source <(fzf --zsh)

