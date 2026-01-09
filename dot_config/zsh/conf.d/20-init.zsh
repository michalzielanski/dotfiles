export PAGER=less

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $prepath
  $path

  # keg only brew apps
  $HOMEBREW_PREFIX/opt/curl/bin(N)
  $HOMEBREW_PREFIX/opt/ruby/bin(N)
  $HOMEBREW_PREFIX/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)
