# +---------+
# | General |
# +---------+
#
# man zshcompsys

# Create ZSH cashe directory
[[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] && mkdir -p -- "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

## load completion functions
fpath=("/usr/local/share/zsh/site-functions" $fpath)
# Load more completions
fpath=("${ZDOTDIR}/completions" $fpath)

# Should be called before compinit
zmodload zsh/complist

# Load and initialize the completion system
local zdumpfile
zdumpfile="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-$ZSH_VERSION"
autoload -Uz compinit
if [[ -n "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-$ZSH_VERSION(#qN.mh+24)" ]]; then
  compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-$ZSH_VERSION"
else
  compinit -C -i -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump-$ZSH_VERSION"
fi
# Compile the completion dumpfile; significant speedup
if [[ ! ${zdumpfile}.zwc -nt ${zdumpfile} ]]; then
  zcompile ${zdumpfile}
fi

# Make it possible to use completion specifications and functions written for bash.
autoload -Uz bashcompinit
bashcompinit

_comp_options+=(globdots) # With hidden files

# +---------+
# | Options |
# +---------+

setopt ALWAYS_TO_END    # Always place the cursor to the end of the word completed.
setopt AUTO_MENU        # Display the completion menu after two use of the TAB key.
setopt AUTO_PARAM_SLASH # When a directory is completed, add a trailing slash instead of a space.
setopt COMPLETE_IN_WORD # Complete from both ends of a word
setopt GLOB_COMPLETE    # Trigger the completion after a glob * instead of expanding it.
# setopt LIST_PACKED       # The completion menu takes less space.
# setopt LIST_ROWS_FIRST   # Matches are sorted in rows instead of columns.
# setopt MENU_COMPLETE     # Automatically highlight first element of completion menu
setopt NO_LIST_BEEP # Don't beep on ambiguous completions.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Enable caching
zstyle ':completion:*' use-cache 'true'
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache-$ZSH_VERSION"

# Ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(-*|_*|pre(cmd|exec)|prompt_*)'

# Define completers
zstyle ':completion:*' completer _extensions _complete _expand _match _ignored
# Fuzzy match mistyped completions.
zstyle ':completion:*:match:*' original only
# Insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order 'all-expansions'

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete 'true'
zle -C alias-expension complete-word _generic
zstyle ':completion:alias-expension:*' completer _expand_alias

zstyle ':zle:up-line-or-beginning-search' leave-cursor 'false'
zstyle ':zle:down-line-or-beginning-search' leave-cursor 'false'

# Allow you to select in a menu, set to false to disable
zstyle ':completion:*:*:*:*:*' menu 'select'

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options 'true'

zstyle ':completion:*:matches' group 'true'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'true'

zstyle ':completion:::::' insert-tab 'pending'
zstyle ':completion:*:-tilde-:*' tag-order 'directory-stack' 'named-directories' 'users'
zstyle ':completion:*:*:-subscript-:*' tag-order 'indexes' 'parameters'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:paths' accept-exact-dirs 'true'
zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
zstyle ':completion:*' file-sort 'false'
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*' single-ignored 'show'
zstyle ':completion:*' squeeze-slashes 'true'
zstyle ':completion:*' verbose 'true'

# Friendly selection prompt
zstyle ':completion:*' list-prompt '%SAt %p: Hit Tab/Space/Enter for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Colors for files and directories
if (( ${+LS_COLORS} )); then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
  # Use same LS_COLORS definition from utility module, in case it was not set
  zstyle ':completion:*:default' list-colors \
          ${(s.:.):-di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}
fi

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order 'local-directories' 'directory-stack' 'path-directories'

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order 'aliases' 'builtins' 'functions' 'commands'

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# Fuzzy completion
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+r:|?=**'

zstyle ':completion:*' keep-prefix 'true'

# SSH Completion
zstyle ':completion:*:ssh:argument-1:' tag-order 'hosts' 'users'
zstyle ':completion:*:ssh:argument-1:*' sort 'true'
zstyle ':completion:*:scp:argument-rest:' tag-order 'hosts' 'files' 'users'
zstyle ':completion:*:scp:argument-rest:*' sort 'true'
zstyle ':completion:*:(ssh|scp|sftp|rdp):*:hosts' hosts

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line 'other'
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
zstyle ':completion:*:*:kill:*' force-list 'always'
zstyle ':completion:*:*:kill:*' insert-ids 'single'

# Git
zstyle ':completion:*:git-*:argument-rest:commit-objects' ignored-patterns '*'
zstyle ':completion:*:git-*:argument-rest:commits' ignored-patterns '*'
zstyle ':completion:*:git-*:argument-rest:heads-local' ignored-patterns '(FETCH_|ORIG_|)HEAD'
zstyle ':completion:*:git-*:argument-rest:heads-remote' ignored-patterns '*/HEAD'
zstyle ':completion:*:git-*:argument-rest:heads' ignored-patterns '(FETCH_|ORIG_|*/|)HEAD'
zstyle ':completion:*:git-*:argument-rest:recent-branches' ignored-patterns '*'
zstyle ':completion:*:parameters' ignored-patterns \
  '_(gitstatus|GITSTATUS|zsh_highlight|zsh_autosuggest|ZSH_HIGHLIGHT|ZSH_AUTOSUGGEST)*'

# complete manual by their section, from grml
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true

# Allows docker completion to recognize combined commands like -it
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# fg/bg use when completing jobs id
zstyle ':completion:*:jobs' verbose true
zstyle ':completion:*:jobs' numbers true

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm apache avahi avahi-autoipd backup bin clamav colord cups-pk-helper cupsys daemon dbus debian-tor dhcp \
  dnsmasq fetchmail firebird ftp fwupd-refresh games gdm geoclue git gnats haldaemon halt hplip http ident irc \
  junkbust kernoops klog ldap libvirt-dnsmasq libvirt-qemu list lp mail mailnull man messagebus mldonkey named news \
  nfsnobody nobody nscd ntp nvidia-persistenced openvpn operator pcap polkitd postfix postgres proxy pulse radvd rpc \
  rpcuser rpm rtkit saned sddm shutdown smtpd smtpq snap_daemon 'snapd*' snort squid sshd statd swtpm sync sys syslog \
  systemd-bus-proxy systemd-journal-gateway systemd-journal-remote systemd-journal-upload systemd-network \
  systemd-resolve systemd-timesync tcpdump transmission tss usbmux uucp uuidd vcsa whoopsie www-data xfs '_*'
