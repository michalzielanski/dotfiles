(( $+commands[proto] )) || [[ -x ${PROTO_HOME:-$HOME/.proto}/bin/proto ]] || return

export PROTO_HOME=${PROTO_HOME:-$HOME/.proto}

function proto_exec_in_proto_home() {
  [[ -x ${PROTO_HOME}/bin/proto ]]
}

if proto_exec_in_proto_home; then
  export PATH="$PROTO_HOME/bin:$PATH"
fi

# https://moonrepo.dev/docs/proto/workflows
zstyle -s ':zsh-conf:proto' workflow '_proto_workflow' || _proto_workflow=shims
if [[ $_proto_workflow = "shims" ]]; then
  if proto_exec_in_proto_home; then
    export PATH="$PROTO_HOME/shims:$PATH"
  else
    export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
  fi
elif [[ $_proto_workflow = "binarylinking" ]] && ! proto_exec_in_proto_home; then
  export PATH="$PROTO_HOME/bin:$PATH"
elif [[ $_proto_workflow = "shellactivation" ]]; then
  eval "$(proto activate zsh)"
fi

unfunction proto_exec_in_proto_home
unset _proto_workflow
