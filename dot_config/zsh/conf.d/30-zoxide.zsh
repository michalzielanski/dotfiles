(( $+commands[zoxide] )) || return

# Specifies the directory in which the database is stored.
export _ZO_DATA_DIR=${_ZO_DATA_DIR:=${XDG_DATA_HOME:-$HOME/.local/share}/zoxide}
# Prevents the specified directories from being added to the database.
# This is provided as a list of globs, separated by ":".
export _ZO_EXCLUDE_DIRS="${HOME}"

eval "$(zoxide init zsh)"

