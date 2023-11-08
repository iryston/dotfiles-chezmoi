# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206
# (1) Command abbreviations ----------------------------------------------- {{{1

alias e='${EDITOR}'  # Open file in default editor
alias h='history'    # Easily access the command history

# (3) Error prevention ---------------------------------------------------- {{{1

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
# (4) List directory contents --------------------------------------------- {{{1

# Test whether the ls command supports a given option
# dot::ls_supports() {
#   command ls "$@" >/dev/null 2>&1
# }

# declare -a ls_options

# if dot::ls_supports --color=auto; then
#   ls_options+=(--color=auto)
# elif dot::ls_supports -G; then
#   ls_options+=(-G)
# fi

# alias ls="command ls ${ls_options[*]}"

if command -v 'lsd' >/dev/null 2>&1; then
  alias l='lsd -l'
  alias ll='lsd -Al'
  alias lt='lsd --tree --depth=2'
else
  alias l='ls -lhF'   # Short list, human readable sizes
  alias l1='ls -1'    # Short list, one entry per row
  alias ll='ls -AlhF' # Long list, human readable sizes
  alias la='ll -A'    # Long list including hidden files
  alias lt='ll -t'    # By date, most recent first
  alias lz='ll -S'    # By size, largest first
fi

alias tree='tree -CF'
alias t='tree -a --noreport --dirsfirst -I ".git|node_modules|.DS_Store"'

# (5) File pattern searching ---------------------------------------------- {{{1

# Test whether grep supports a given option
# dot::grep_supports() {
#   grep "$1" "?" <(echo "?" 2>&1) >/dev/null 2>&1
# }

# declare -a grep_options

# if dot::grep_supports --color=auto; then
#   grep_options+=(--color=auto)
# fi

# alias grep="grep ${grep_options[*]}"
# alias fgrep="fgrep ${grep_options[*]}"
# alias egrep="egrep ${grep_options[*]}"

alias rg='rg --hidden --smart-case'
alias ag='ag --hidden --smart-case'

if command -v 'fdfind' >/dev/null 2>&1; then
  alias fd='fdfind'
fi

## Compare directories
alias diff-dir='diff --ignore-file-name-case -qys'

case "$EDITOR" in
*nvim) alias vimdiff='nvim -dR'
  alias v='nvim'
  alias vn='nvim -u NONE -U NONE -i NONE -N -n' ;;
*vim) alias v='vim'
  alias vn='vim -u NONE -U NONE -i NONE -N -n' ;;
esac

# (7) Software specific aliases ------------------------------------------- {{{1

## TMUX create new session or attach if exists
# alias tms='tmux -u new-session -A -s "$(hostname -s)"'
alias tms='tmux -f "${XDG_CONFIG_HOME}/tmux/tms.conf" -u new-session -A -s "$(hostname -s)"'

alias ncdu="ncdu --color dark"

## MC slow startup workaround
alias mc="mc --nosubshell"

## Git UI in terminal
for cmd in "gitui" "lazygit" "tig"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    alias gui='$cmd'
    break
  fi
done

alias yt='yt-dlp --windows-filenames --compat-options filename-sanitization --trim-filenames 120 --continue --format "bv*[ext=mp4][height<=?720][fps<=?30]+ba[ext=m4a]/b[ext=mp4]"'
alias yt-stream='yt-dlp --windows-filenames --compat-options filename-sanitization --trim-filenames 120 --downloader ffmpeg --hls-use-mpegts'

# Pretty print the path
alias ppp='echo $PATH | tr -s ":" "\n"'

## Remove OS X 'junk' files
#alias rmds='find . -depth -type f -name ".DS_Store" -exec rm -i {} \;' # Interactive mode
alias rmds='find . -depth -type f -name ".DS_Store" -delete'

# Turn off screen on KDE
alias turn-off-screen='sleep 0.5; xset dpms force off'
alias turn-off-screen-wayland='/bin/sleep 0.5 && /bin/dbus-send --session --print-reply --dest=org.kde.kglobalaccel /component/org_kde_powerdevil org.kde.kglobalaccel.Component.invokeShortcut string:"Turn Off Screen"'

## Open root shell in current directory
alias godmode='su - root -c "cd `pwd`; bash"'
