## Plugins ---------------------------------------------------------------- {{{1

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
