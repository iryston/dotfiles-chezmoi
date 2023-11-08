# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206

# (1) FZF Setup --------------------------------------------------------- {{{1

if [ -n "$BASH_VERSION" ] && [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
fi
if [ -n "$ZSH_VERSION" ] && [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
fi

# (2) FZF Configuration ------------------------------------------------- {{{1
if command -v "fzf" >/dev/null 2>&1; then

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

fi
