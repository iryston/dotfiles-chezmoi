
## (4) Pagers ------------------------------------------------------------- {{{1

## Configure less as default pager
## -i = ignore case
## -m = long prompt
## -w = temporarily highlight line after movement
## -F = quit if one screen
## -R = raw control chars
## -X = don’t clear screen on exit
export LESS="-imwFRX"
export LESSHISTFILE="${XDG_DATA_HOME}/less/history"

export PAGER="less -X"
export MANPAGER="$PAGER"
