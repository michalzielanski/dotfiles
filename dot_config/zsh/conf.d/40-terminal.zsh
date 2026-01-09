case "${TERM_PROGRAM:l}" in
  apple_terminal)
    export SHELL_SESSIONS_DISABLE=1
    ;;
  ghostty)
    source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
    ;;
  vscode)
    # https://code.visualstudio.com/docs/terminal/shell-integration
    MY_HISTFILE=$HISTFILE
    source "$(code --locate-shell-integration-path zsh)"
    HISTFILE=$MY_HISTFILE
    unset MY_HISTFILE
    ;;
esac
