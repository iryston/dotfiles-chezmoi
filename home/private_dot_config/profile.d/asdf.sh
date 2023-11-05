# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206
# asdf_core="${XDG_DATA_HOME:-$HOME/.local/share}/asdf/core"

# if [ ! -e $asdf ]; then
#   git clone --depth 1 https://github.com/asdf-vm/asdf.git $asdf_core
# fi

#/home/eagle/.config/asdf/tool-versions

export ASDF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf/core"
export ASDF_DATA_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/asdf"
export ASDF_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/asdf"

# Don't change ASDF_DEFAULT_TOOL_VERSIONS_FILENAME location
export ASDF_CONFIG_FILE="${ASDF_CONFIG_DIR}/asdfrc"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_DIR}/default-gems"
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_DIR}/default-go-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_DIR}/default-npm-packages"
export ASDF_PERL_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_DIR}/default-perl-modules"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_DIR}/default-python-packages"

if [ -f "${ASDF_DIR}/asdf.sh" ]; then
  source "${ASDF_DIR}/asdf.sh"
fi

[[ -n "$BASH_VERSION" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"
[[ -n "$ZSH_VERSION" ]]  && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# append completions to fpath
[[ -n "$ZSH_VERSION" ]]  && fpath=("${ASDF_DIR}/completions" $fpath)

# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(asdf list-all "$lang" | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        asdf install "$lang" "$version"
      done
    fi
  fi
}

# Remove one or more versions of specified language
# e.g. `vmc rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmc<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(asdf list "$lang" | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        asdf uninstall "$lang" "$version"
      done
    fi
  fi
}

# Per-Project Environments
# Once direnv is hooked into your system,
# use the `asdf direnv local` command on your project root directory
# to update your environment.
# e.g. `asdl nodejs` # => fzf
# if no plugin is supplied (e.g. `asdl<CR>`), fzf will list them for you
# Mnemonic [A]SDF [D]irenv [L]ocal
asdl() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(asdf list "$lang" | fzf)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        asdf direnv local "$lang" "$version"
      done
    fi
  fi
}

# Temporary environments for one-shot commands
# Once direnv is hooked into your system,
# use the `asdf direnv shell` command on your project root directory
# to execute a one-shot commmand under certain environment.
# e.g. `asds nodejs` # => fzf
# if no plugin is supplied (e.g. `asds<CR>`), fzf will list them for you
# Mnemonic [A]SDF [D]irenv [S]ell
asds() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions
    versions=$(asdf list "$lang" | fzf)
    if [[ $versions ]]; then
      for version in $(echo $versions); do
        asdf direnv shell "$lang" "$version"
      done
    fi
  fi
}
