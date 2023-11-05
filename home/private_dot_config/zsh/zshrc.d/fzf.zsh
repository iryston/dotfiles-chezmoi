# (1) FZF Setup --------------------------------------------------------- {{{1

# path+=("${HOME}/.fzf/bin")
[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

# (2) FZF Configuration ------------------------------------------------- {{{1

# A set of default options provided to the fzf binary.
export FZF_DEFAULT_OPTS="
  --info inline
  --min-height 62
  --height 62%
  --tabstop 4
  --layout reverse
  --bind '?:toggle-preview'
  --prompt '${PROMPT_SYMBOL:-❯} '
  --border
  --preview-window right:62%:hidden
  --preview 'file {}'
  --bind 'ctrl-a:preview-up,ctrl-z:preview-down'
"

export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='
  --tiebreak=chunk --preview "bat --color=always --line-range :200 {} 2>/dev/null || ls -1Av {} 2>/dev/null || head -200 {}"
'

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

export FZF_CTRL_R_OPTS='--no-sort --exact --preview "echo {}"'

## Command used to fetch the list of files.
if command -v "fd" >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
elif command -v "rg" >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-messages --no-ignore-vcs --glob ""'
elif command -v "ag" >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='ag --hidden --silent --skip-vcs-ignores -g ""'
else
  export FZF_DEFAULT_COMMAND='find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//'
fi

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='
  --preview "bat --color=always --line-range :200 {} 2>/dev/null || ls -1Av {} 2>/dev/null || head -200 {}"
'

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow'
export FZF_ALT_C_OPTS='
  --preview "
    eza -aT -L 1 --color=always {} 2>/dev/null || tree -aC -L 1 {} 2>/dev/null || ls -1Av {} 2>/dev/null
  "
'

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
