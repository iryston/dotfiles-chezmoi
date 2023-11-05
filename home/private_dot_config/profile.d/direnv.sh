# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206
if command -v "direnv" >/dev/null 2>&1; then
  export DIRENV_LOG_FORMAT=""
  [[ -n "$BASH_VERSION" ]] && eval "$(direnv hook bash)"
  [[ -n "$ZSH_VERSION" ]]  && eval "$(direnv hook zsh)"
fi
