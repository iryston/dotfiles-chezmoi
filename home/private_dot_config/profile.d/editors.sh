
## (5) Text Editors ------------------------------------------------------- {{{1

for cmd in "nvim" "vim" "vi" "nano"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    export EDITOR="$cmd"
    break
  fi
done

export VISUAL="$EDITOR"
