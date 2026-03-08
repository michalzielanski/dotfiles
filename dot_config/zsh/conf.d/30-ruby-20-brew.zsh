(( $+commands[brew] )) || return

zstyle -s ':zsh-conf:ruby' brew-ver _ruby_brew_ver || _ruby_brew_ver=''

_keg_ver=${_ruby_brew_ver:+@$_ruby_brew_ver}
_gem_ver=${_ruby_brew_ver:-}

path=(
  $HOMEBREW_PREFIX/opt/ruby${_keg_ver}/bin(/N)
  $GEM_HOME/bin(/N)
  $HOME/.gem/ruby/${_gem_ver}*/bin(/N)
  $HOMEBREW_PREFIX/lib/ruby/gems/${_gem_ver}*/bin(/N)
  $path
)

fpath=(
  $HOMEBREW_PREFIX/opt/ruby${_keg_ver}/share/zsh/site-functions(/N)
  $fpath
)

manpath=(
  $HOMEBREW_PREFIX/opt/ruby${_keg_ver}/share/man(/N)
  $manpath
)

# compilers
[[ -d /opt/homebrew/opt/ruby${_keg_ver}/lib ]] \
  && export LDFLAGS="-L/opt/homebrew/opt/ruby${_keg_ver}/lib"
[[ -d /opt/homebrew/opt/ruby${_keg_ver}/include ]] \
  && export CPPFLAGS="-I/opt/homebrew/opt/ruby${_keg_ver}/include"

unset _ruby_brew_ver _keg_ver _gem_ver
