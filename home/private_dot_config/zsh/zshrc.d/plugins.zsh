## Plugins ---------------------------------------------------------------- {{{1
if command -v "fzf" >/dev/null 2>&1; then
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
fi

## fast-syntax-highlighting
## https://github.com/zdharma-continuum/fast-syntax-highlighting.git
if [[ -f "${XDG_DATA_HOME}/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]]; then
  source "${XDG_DATA_HOME}/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

## zsh-autosuggestions
## https://github.com/zsh-users/zsh-autosuggestions.git
if [[ -f "${XDG_DATA_HOME}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${XDG_DATA_HOME}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  bindkey '^ ' autosuggest-accept
  ## Default ZSH_AUTOSUGGEST_ACCEPT_WIDGETS
  ## (forward-char end-of-line vi-forward-char vi-end-of-line vi-add-eol)
  ## Default ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS
  ## (forward-word emacs-forward-word vi-forward-word vi-forward-word-end
  ## vi-forward-blank-word vi-forward-blank-word-end vi-find-next-char vi-find-next-char-skip)
  typeset -g ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    end-of-line
    vi-end-of-line
    vi-add-eol
  )
  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char vi-forward-char)
fi

## zsh-history-substring-search
## https://github.com/zsh-users/zsh-history-substring-search.git
if [[ -f "${XDG_DATA_HOME}/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "${XDG_DATA_HOME}/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey '^[[A' history-substring-search-up   # Up arrow
  bindkey '^[[B' history-substring-search-down # Down arrow
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  HISTORY_SUBSTRING_SEARCH_PREFIXED=true
fi
