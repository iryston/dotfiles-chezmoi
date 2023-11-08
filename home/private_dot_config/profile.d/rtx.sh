# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206

[[ -n "$BASH_VERSION" ]] && eval "$(rtx activate bash)"
[[ -n "$ZSH_VERSION" ]]  && eval "$(rtx activate zsh)"

export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/rtx/shims:$PATH"

export RTX_GO_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/rtx/default-go-packages"
export RTX_NODE_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/rtx/default-npm-packages"
export RTX_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/rtx/default-python-packages"
export RTX_RUBY_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/rtx/default-gems"

# Install one or more versions of specified language
# e.g. `vmi node` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$({ rtx plugins list -c; rtx plugins list; } | sort | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(rtx ls-remote "$lang" | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        rtx install "$lang"@"$version"
      done
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmc node` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmc<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$({ rtx plugins list -c; rtx plugins list; } | sort | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(rtx ls -i -p "$lang" | awk '{print $2}' | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        rtx uninstall "$lang"@"$version"
      done
    fi
  fi
}
