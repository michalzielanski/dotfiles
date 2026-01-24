#
# Antidote (https://antidote.sh).
#

_brewcmd="$(get-brew-cmd)" || { unset _brewcmd; return }
# Antidote is not installed with brew.
[[ -f "$(${_brewcmd} --prefix antidote)/share/antidote/antidote.zsh" ]] || { unset _brewcmd; return }

# ANTIDOTE_HOME is the location where antidote clones repositories.
# `antidote-home` command prints where antidote is cloning bundles.
# By default, in MacOS it is `~/Library/Caches/antidote`.
: ${ANTIDOTE_HOME:=${XDG_CACHE_HOME:-$HOME/.cache}/antidote}

zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:static' file ${ZSH_CACHE_DIR}/zsh_plugins.zsh
zstyle ':antidote:*' zcompile 'yes'

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZSH_CONFIG_DIR}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists.
[[ -f ${ZSH_CONFIG_DIR}/.zsh_plugins.txt ]] || touch ${ZSH_CONFIG_DIR}/.zsh_plugins.txt

# Lazy-load antidote from its functions directory.
fpath=($(${_brewcmd} --prefix antidote)/share/antidote/ $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

unset _brewcmd zsh_plugins
