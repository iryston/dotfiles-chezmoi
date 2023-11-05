# $HOME/.profile.d/variables.sh
#
# @file NNN configuration

# export NNN_COLORS='2641'
# optional args:
#  -a    auto NNN_FIFO
#  -A    no dir auto-enter during filter
#  -b key  open bookmark key (trumps -s/S)
#  -B    use bsdtar for archives
#  -c    cli-only NNN_OPENER (trumps -e)
#  -C    8-color scheme
#  -d    detail mode
#  -D    dirs in context color
#  -e    text in $VISUAL/$EDITOR/vi
#  -E    internal edits in EDITOR
#  -f    use readline history file
#  -F val  fifo mode [0:preview 1:explore]
#  -g    regex filters
#  -H    show hidden files
#  -i    show current file info
#  -J    no auto-advance on selection
#  -K    detect key collision
#  -l val  set scroll lines
#  -n    type-to-nav mode
#  -o    open files only on Enter
#  -p file selection file [-:stdout]
#  -P key  run plugin key
#  -Q    no quit confirmation
#  -r    use advcpmv patched cp, mv
#  -R    no rollover at edges
#  -s name load session by name
#  -S    persistent session
#  -t secs timeout to lock
#  -T key  sort order [a/d/e/r/s/t/v]
#  -u    use selection (no prompt)
#  -U    show user and group
#  -V    show version
#  -x    notis, selection sync, xterm title
#  -h    show help

if command -v "nnn" >/dev/null 2>&1; then
  export NNN_OPTS="aceEHioUQ"

  #export NNN_PLUG='u:getplugs;p:preview-tui;g:gitroot;i:imgview;d:dragdrop;f:fzplug;s:suedit'

  export NNN_OPENER="${HOME}/.config/nnn/plugins/nuke"
  export NNN_PLUG='u:getplugs;o:fzopen;v:imgview;s:suedit'
  export GUI=1

  n() {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
      echo "nnn is already running"
      return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #   NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
      source "$NNN_TMPFILE"
      rm -f "$NNN_TMPFILE" >/dev/null
    fi
  }
fi
