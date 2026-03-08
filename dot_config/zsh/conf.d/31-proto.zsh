(( $+commands[proto] )) \
  || [[ -x ${PROTO_HOME:-$XDG_DATA_HOME/proto}/bin/proto ]] \
  || return

export PROTO_HOME=${PROTO_HOME:-$XDG_DATA_HOME/proto}

__proto_bin_path=$PROTO_HOME/bin
__proto_shims_path=$PROTO_HOME/shims

__proto_path=()
if [[ -x ${__proto_bin_path}/proto ]] && (( ! $path[(Ie)$__proto_bin_path] )); then
  __proto_path=($__proto_bin_path)
fi

# https://moonrepo.dev/docs/proto/workflows
zstyle -s ':zsh-conf:proto' workflow '__proto_workflow' || __proto_workflow=shims
if [[ $__proto_workflow = "shims" ]]; then
  __proto_path[1,0]=($__proto_shims_path)

  if (( ! $__proto_path[(Ie)$__proto_bin_path] )); then
    __proto_path[2,0]=($__proto_bin_path)
  fi
elif [[ $__proto_workflow = "binarylinking" ]] && (( ! $__proto_path[(Ie)$__proto_bin_path] )); then
  __proto_path[1,0]=($__proto_bin_path)
elif [[ $__proto_workflow = "shellactivation" ]]; then
  eval "$(proto activate zsh)"
fi

[[ ! -z $__proto_path ]] && path=($__proto_path $path)

unset __proto_{bin_path,shims_path,path,workflow}
