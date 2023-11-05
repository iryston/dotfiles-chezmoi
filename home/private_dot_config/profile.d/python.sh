# $HOME/.profile.d/python.sh
#
# @file Configuration of the Python environment.

# (1) Python Package Manager ---------------------------------------------- {{{1

# if command -v "pip3" >/dev/null 2>&1; then
#   case "$SHELL_NAME" in
#   bash) eval "$(pip3 completion --bash)" ;;
#   zsh) source .config/zsh/completions/_pip ;;
#   esac
# fi

# (2) Python version management ------------------------------------------- {{{1

export PYTHON_CONFIGURE_OPTS="--enable-shared"

## PyEnv
# if [ -d "${HOME}/.pyenv/bin" ]; then
#   PATH="${HOME}/.pyenv/bin:$PATH"
#   export PYENV_ROOT="${HOME}/.pyenv"
# fi

# if command -v "pyenv" >/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# (3) pipx — Install and Run Python Applications in Isolated Environments - {{{1

if command -v "pipx" >/dev/null 2>&1; then
  # Overrides emoji behavior. Default value varies based on platform.
  export USE_EMOJI=0
  # Add shell completion
  eval "$(register-python-argcomplete pipx)"
fi

# (4) Python aliases ------------------------------------------------------ {{{1

alias py="python3"
# alias python="python3"

# vim:foldmethod=marker:foldlevel=2
