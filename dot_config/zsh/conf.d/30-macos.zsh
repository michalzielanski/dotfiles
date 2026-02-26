# Created based on the zephyr macos plugin code.
# https://github.com/mattmc3/zephyr/tree/35b5e56/plugins/macos

[[ is-macos ]] || return

# Load functions.
0=${(%):-%N}
fpath=(${0:a:h}/macos_functions $fpath)
autoload -Uz ${0:a:h}/macos_functions/*(.:t)

# Flush the DNS cache.
alias flushdns='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
# Show hidden dotfiles in Finder.
alias finder-hiddenfiles-show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
# Hide hidden dotfiles in Finder.
alias finder-hiddenfiles-hide='defaults delete com.apple.finder AppleShowAllFiles && killall Finder'

