# shellcheck shell=bash disable=SC1091,SC2039,SC2166
# $HOME/.profile.d/golang.sh
#
# @file Configuration of the Golang environment.

# (1) Environment variables ----------------------------------------------- {{{1

# export PATH="$PATH":/usr/local/go/bin
# export PATH="$PATH":"${GOPATH}/bin"

# (2) Golang version management ------------------------------------------- {{{1

# Set GOROOT on shell's initialization
if command -v "asdf" >/dev/null 2>&1; then
  case "$SHELL_NAME" in
  zsh) source "${ASDF_DATA_DIR}/plugins/golang/set-env.zsh" ;;
  esac
fi


# vim:foldmethod=marker:foldlevel=2
