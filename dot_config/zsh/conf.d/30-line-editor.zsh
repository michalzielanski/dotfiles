# Created based on the zephyr editor plugin code.
# https://github.com/mattmc3/zephyr/blob/7327c6c/plugins/editor/editor.plugin.zsh
#
# https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html

[[ "$TERM" != 'dumb' ]] || return

#
# Variables
#

# Treat these characters as part of a word.
zstyle -s ':zsh-conf:line-editor' wordchars 'WORDCHARS' || \
  WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info

# Modifiers
key_info=(
  'Control' '\C-'
  'Escape'  '\e'
  'Meta'    '\M-'
)

# Basic keys
key_info+=(
  #'Backspace' "^?"
  'Backspace' "$terminfo[kbs]"
  #'Delete'    "^[[3~"
  'Delete'    "$terminfo[kdch1]"
  'F1'        "$terminfo[kf1]"
  'F2'        "$terminfo[kf2]"
  'F3'        "$terminfo[kf3]"
  'F4'        "$terminfo[kf4]"
  'F5'        "$terminfo[kf5]"
  'F6'        "$terminfo[kf6]"
  'F7'        "$terminfo[kf7]"
  'F8'        "$terminfo[kf8]"
  'F9'        "$terminfo[kf9]"
  'F10'       "$terminfo[kf10]"
  'F11'       "$terminfo[kf11]"
  'F12'       "$terminfo[kf12]"
  'Insert'    "$terminfo[kich1]"
  'Home'      "$terminfo[khome]"
  'End'       "$terminfo[kend]"
  'PageUp'    "$terminfo[kpp]"
  'PageDown'  "$terminfo[knp]"
  'Up'        "$terminfo[kcuu1]"
  'Left'      "$terminfo[kcub1]"
  'Down'      "$terminfo[kcud1]"
  'Right'     "$terminfo[kcuf1]"
  'BackTab'   "$terminfo[kcbt]" # Shift+Tab
)

# Apple Magic Keyboard with Touch ID
key_info+=(
  'F13' "$terminfo[kf13]"
  'F14' "$terminfo[kf14]"
  'F15' "$terminfo[kf15]"
  'F16' "$terminfo[kf16]"
  'F17' "$terminfo[kf17]"
  'F18' "$terminfo[kf18]"
  'F19' "$terminfo[kf19]"
)

# Mod plus another key
key_info+=(
  'AltLeft'         "${key_info[Escape]}${key_info[Left]} \e[1;3D"
  'AltRight'        "${key_info[Escape]}${key_info[Right]} \e[1;3C"
  'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
  'ControlPageUp'   '\e[5;5~'
  'ControlPageDown' '\e[6;5~'
  'AltDelete'       '\e[3;3~'
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    key_info[$key]='�'
  fi
done

#
# Functions
#

# Runs bindkey but for all of the keymaps. Running it with no arguments will
# print out the mappings for all of the keymaps.
function bindkey-all {
  local keymap=''
  for keymap in $(bindkey -l); do
    [[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
    bindkey -M "${keymap}" "$@"
  done
}

# Enables terminal application mode.
function zle-line-init {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[smkx] )); then
    # Enable terminal application mode.
    echoti smkx
  fi
}
zle -N zle-line-init

# Disables terminal application mode.
function zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[rmkx] )); then
    # Disable terminal application mode.
    echoti rmkx
  fi
}
zle -N zle-line-finish

# Resets the prompt when the keymap changes.
function zle-keymap-select {
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Expand aliases.
function glob-alias {
  local -a noexpand_aliases
  zstyle -a ':zsh-conf:line-editor:glob-alias' 'noexpand' 'noexpand_aliases' \
    || noexpand_aliases=()

  # Get last word to the left of the cursor:
  # (A) makes it an array even if there's only one element
  # (z) splits into words using shell parsing
  local word=${${(Az)LBUFFER}[-1]}
  if [[ $noexpand_aliases[(Ie)$word] -eq 0 ]]; then
    zle _expand_alias
    # zle expand-word
  fi
  zle self-insert
}
zle -N glob-alias

#
# Init
#

# Reset to default key bindings.
bindkey -d

#
# Keybinds
#

# Global keybinds
typeset -gA global_keybinds
global_keybinds=(
  "$key_info[Home]"    beginning-of-line     # Move to the beginning of the line.
  "$key_info[End]"     end-of-line           # Move to the end of the line.
  "$key_info[Delete]"  delete-char           # Delete the character under the cursor.
  "$key_info[BackTab]" reverse-menu-complete # Move to the previous completion.
)

# emacs and vi insert mode keybinds
typeset -gA viins_keybinds
viins_keybinds=(
  "$key_info[Backspace]" backward-delete-char # Delete the character behind the cursor.
  "$key_info[AltDelete]" kill-word            # Kill the current word.
)

# vi command mode keybinds
typeset -gA vicmd_keybinds
vicmd_keybinds=(
)

# Special case for ControlLeft and ControlRight because they have multiple
# possible binds.
for key in "${(s: :)key_info[ControlLeft]}" "${(s: :)key_info[AltLeft]}"; do
  bindkey -M emacs "$key" emacs-backward-word
  bindkey -M viins "$key" vi-backward-word
  bindkey -M vicmd "$key" vi-backward-word
done
for key in "${(s: :)key_info[ControlRight]}" "${(s: :)key_info[AltRight]}"; do
  bindkey -M emacs "$key" emacs-forward-word
  bindkey -M viins "$key" vi-forward-word
  bindkey -M vicmd "$key" vi-forward-word
done

# Bind all global and viins keys to the emacs keymap.
for key bind in ${(kv)global_keybinds} ${(kv)viins_keybinds}; do
  bindkey -M emacs "$key" "$bind"
done

# Bind all global, vi, and viins keys to the viins keymap.
for key bind in ${(kv)global_keybinds} ${(kv)viins_keybinds}; do
  bindkey -M viins "$key" "$bind"
done

# Bind all global, vi, and vicmd keys to the vicmd keymap.
for key bind in ${(kv)global_keybinds} ${(kv)vicmd_keybinds}; do
  bindkey -M vicmd "$key" "$bind"
done

# Expand aliases.
if zstyle -t ':zsh-conf:line-editor' glob-alias; then
  # space expands all aliases, including global
  bindkey -M emacs " " glob-alias
  bindkey -M viins " " glob-alias

  # control-space to make a normal space
  bindkey -M emacs "^ " magic-space
  bindkey -M viins "^ " magic-space

  # normal space during searches
  bindkey -M isearch " " magic-space
fi

#
# Layout
#

# Set the key layout.
zstyle -s ':zsh-conf:line-editor' key-bindings 'key_bindings'
if [[ "$key_bindings" == (emacs|) ]]; then
  bindkey -e
elif [[ "$key_bindings" == vi ]]; then
  bindkey -v
else
  print "line-editor: invalid key bindings: $key_bindings" >&2
fi

unset bind key{,_bindings} {vicmd,viins,global}_keybinds
