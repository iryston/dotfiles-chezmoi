# (1) FZF Setup --------------------------------------------------------- {{{1

# path+=("${HOME}/.fzf/bin")
# [ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

# (2) FZF Configuration ------------------------------------------------- {{{1

if command -v "fd" >/dev/null 2>&1; then
  # Use fd (https://github.com/sharkdp/fd) instead of the default find
  # command for listing path candidates.
  # - The first argument to the function ($1) is the base path to start traversal
  # - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

# # export FZF_TMUX=1
# # export FZF_TMUX_OPTS='-p -w38% -h90% -xC -yC'

# # (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
#     export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
#     ssh)          fzf "$@" --preview 'dig {}' ;;
#     *)            fzf "$@" ;;
#   esac
# }

## Plugins ---------------------------------------------------------------- {{{1

## fzf-tab
## https://github.com/Aloxaf/fzf-tab.git
if [[ -f "${XDG_DATA_HOME}/zsh/fzf-tab/fzf-tab.plugin.zsh" ]]; then
  source "${XDG_DATA_HOME}/zsh/fzf-tab/fzf-tab.plugin.zsh"
  zstyle ':fzf-tab:complete:cd:*' fzf-preview \
    'eza -aT -L 1 --color=always $realpath || tree -aC -L 1 $realpath || ls -1Av $realpath'
  zstyle ":fzf-tab:*" fzf-flags --color=bg+:237
  zstyle ':fzf-tab:*' fzf-pad 4
  zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
fi

## fzf-tab-source
## https://github.com/Freed-Wu/fzf-tab-source.git
if command -v "lesspipe" >/dev/null 2>&1; then
  if [[ -f "${XDG_DATA_HOME}/zsh/fzf-tab-source/fzf-tab-source.plugin.zsh" ]]; then
    source "${XDG_DATA_HOME}/zsh/fzf-tab-source/fzf-tab-source.plugin.zsh"
  fi
fi
# Use tmux popup if available.
if [ -n "$TMUX" ] && [ "$TMUX_SUPPORT_POPUP" = 1 ]; then
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
fi
