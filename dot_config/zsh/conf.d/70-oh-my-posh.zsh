(( $+commands[oh-my-posh] )) || return

# The standard Apple Terminal has issues displaying the ANSI characters correctly.
[[ $TERM_PROGRAM != "Apple_Terminal" ]] || return

# Configuration for oh-my-posh "endorphins.omp.json" theme.
export POSH_SHOW_SESSION_SEG=0

if [[ -f "${XDG_CONFIG_HOME}/oh-my-posh/endorphins.omp.json" ]]; then
  theme_config="${XDG_CONFIG_HOME}/oh-my-posh/endorphins.omp.json"
else
  theme_config="$(brew --prefix oh-my-posh)/themes/jandedobbeleer.omp.json)"
fi

# When customizing your configuration, you can enable live reloading
# of changes without cache by using the `oh-my-posh enable reload` command.
# You can restore the cache using the `oh-my-posh disable reload` command.
eval "$(oh-my-posh init zsh --config ${theme_config})"
unset theme_config

# https://ohmyposh.dev/docs/faq?shell=others#python-venv-prompt-changes-on-activating-virtual-environment
export VIRTUAL_ENV_DISABLE_PROMPT=1
