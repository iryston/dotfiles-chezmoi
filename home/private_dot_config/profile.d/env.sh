# shellcheck shell=bash disable=SC1091,SC2039,SC2166
## (1) Environment variables ---------------------------------------------- {{{1

GPG_TTY=$(tty)
export GPG_TTY
# if [[ -n "$SSH_CONNECTION" ]] ;then
#   export PINENTRY_USER_DATA="USE_CURSES=1"
# fi

if [[ -n "$SSH_CONNECTION" || -n "$TMUX" ]] ;then
#if [ -n "$SSH_CONNECTION" -o -n "$TMUX" ] ;then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# Control bearer backend polling timers.
# Scanning/updating networks can cause transmission jitters every 10 seconds.
# Setting QT_BEARER_POLL_TIMEOUT, in milliseconds will set polling timer
# for those bearer backends that require polling, such as generic and windows.
export QT_BEARER_POLL_TIMEOUT=-1

## Ripgrep config file location
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"

## Set ddev in noniteractive mode
## https://github.com/drud/ddev/issues/1220
export DRUD_NONINTERACTIVE=true
## Set ddev instrumentation_opt_in=false
export DDEV_NO_INSTRUMENTATION=true
