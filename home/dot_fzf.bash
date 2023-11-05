# shellcheck source=/dev/null shell=bash disable=SC2039,SC2166

# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

# Auto-completion
# ---------------
source "${HOME}/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "${HOME}/.fzf/shell/key-bindings.bash"
