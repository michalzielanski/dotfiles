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

[[ -f ${ZSH_CONFIG_DIR}/.zsh_plugins.txt ]] || touch ${ZSH_CONFIG_DIR}/.zsh_plugins.txt

# Load antidote
source "$(${_brewcmd} --prefix antidote)/share/antidote/antidote.zsh"
antidote load ${ZSH_CONFIG_DIR}/.zsh_plugins.txt

unset _brewcmd
