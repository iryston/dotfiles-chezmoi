# $HOME/.profile.d/homebrew.sh
#
# @file Configuration of the Homebrew environment.

# (1) Set Homebrew environment -------------------------------------------- {{{1

# Disable Homebrew telemetry
# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

# Set PATH, MANPATH, etc., for Homebrew.
#path=(/opt/local/bin /opt/homebrew/bin $path)
if [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "~/.linuxbrew/bin/brew" ]; then
  eval "$(~/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/usr/local}"
#export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications --fontdir=/Library/Fonts"

# vim:foldmethod=marker:foldlevel=2
