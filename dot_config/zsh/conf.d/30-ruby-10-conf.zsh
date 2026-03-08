# ruby gems
# https://felipec.wordpress.com/2022/08/25/fixing-ruby-gems-installation/
# Use `gem env` to view the current RubyGems environment.
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem/specs}"
export GEMRC="${GEMRC:-$XDG_CONFIG_HOME/gemrc}"

# ruby bundler
# Use `bundle env` to view the current RubyGems environment.
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}"
