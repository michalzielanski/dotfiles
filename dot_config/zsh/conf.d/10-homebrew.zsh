# Homebrew configuration via environment variables is located in
# the `~/.homebrew/brew.env` file.

_brewcmd="$(get-brew-cmd)" || { unset _brewcmd; return }

# To check what code is executed by `eval`, run as:
# `PATH= HOMEBREW_PREFIX= /opt/homebrew/bin/brew shellenv zsh`.
eval "$(${_brewcmd} shellenv)"
unset _brewcmd

# Add keg-only completions to fpath.
# Source: https://github.com/mattmc3/zephyr/blob/ec2452e/plugins/homebrew/homebrew.plugin.zsh#L49
_kegonly=(curl ruby sqlite)
for _keg in $_kegonly; do
  fpath=($HOMEBREW_PREFIX/opt/${_keg}/share/zsh/site-functions(/N) $fpath)
done
unset _keg{,only}

# Handle brew on multi-user Apple silicon.
# Source: https://github.com/mattmc3/zephyr/blob/ec2452e/plugins/homebrew/homebrew.plugin.zsh#L70
if [[ "$HOMEBREW_PREFIX" == /opt/homebrew ]]; then
  # Check for GNU coreutils stat.
  if stat --version &>/dev/null; then
    _brew_owner="$(stat -c "%U" "$HOMEBREW_PREFIX" 2>/dev/null)"
  else
    _brew_owner="$(stat -f "%Su" "$HOMEBREW_PREFIX" 2>/dev/null)"
  fi
  if [[ -n "$_brew_owner" ]] && [[ "$(whoami)" != "$_brew_owner" ]]; then
    alias brew="sudo -Hu '$_brew_owner' brew"
  fi
  unset _brew_owner
fi

# https://docs.brew.sh/Command-Not-Found
if is-macos && zstyle -t ':zsh-conf:homebrew' 'enable-cmd-not-found'; then
  homebrew_command_not_found_handler="${HOMEBREW_REPOSITORY}/Library/Homebrew/command-not-found/handler.sh"
  [[ -f $homebrew_command_not_found_handler ]] && source $homebrew_command_not_found_handler
  unset homebrew_command_not_found_handler
fi
