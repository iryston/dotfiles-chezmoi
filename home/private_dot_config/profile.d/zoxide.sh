if command -v "zoxide" >/dev/null 2>&1; then
  export _ZO_ECHO='1'
  eval "$(zoxide init --cmd j zsh)"
fi
