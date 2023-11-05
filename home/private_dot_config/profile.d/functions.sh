# $HOME/.profile.d/functions.sh
#
# @file Utilitiy functions used in interactive shells

#
# Recursively create directory and cd in it
#
# usage: mkd DIR1/DIR2
#
function mkd() {
  [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" || return;
}

#
# Switch to the given directory starting from the root the current git
# repository.
#
# usage: cdr [<path>]
#
cdr() {
  local base
  base="$(git rev-parse --show-toplevel)"

  if [[ -d "$base" ]]; then
    builtin cd -- "$base/$*"
  fi
}

#
# Display cheatsheets from cheat.sh.
#
# usage: cheat [<command>]
#
cheat-sh() {
  curl cheat.sh/"${1}"
}

#
# Move a file to the trash.
#
# usage: del <file>
#
del() {
  local dir="${TRASH_DIR:-${HOME}/.Trash}"

  if [[ ! -d "${dir}" ]]; then
    mkdir -p "${dir}"
  fi

  mv "$@" "${dir}"
}

#
# Load a given file to the ~/Downloads folder.
#
# usage: download <url>
#
download() {
  local user_agent="${CURL_USER_AGENT:-Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:70.0) Gecko/20100101 Firefox/70.0}"
  local target_dir="${XDG_DOWNLOAD_DIR:-${HOME}/Downloads}"

  wget \
    --directory-prefix="${target_dir}" \
    --user-agent="${user_agent}" \
    --random-wait \
    --no-verbose \
    --show-progress \
    --continue \
    --content-disposition \
    --xattr \
    "$@"
}

#
# Find files whose name matches a given pattern.
#
# usage: ff <pattern>
#
ff() {
  find . -type f -iname '*'"$*"'*' -exec ls "${ls_options[@]}" -- {} \;
}

#
# Get an overview of the current network addresses.
#
# usage: myip
#
myip() {
  printf "\033[0;34m%s\033[0;m\n" "INTERNAL IP:"
  ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'

  printf "\033[0;34m\n%s\033[0;m\n" "EXTERNAL IPv4:"
  dig @resolver4.opendns.com myip.opendns.com +short -4

  printf "\033[0;34m\n%s\033[0;m\n" "EXTERNAL IPv6:"
  dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6
}

#
# Start a web server on the given local address and port.
#
# usage: serve [<directory>]
serve() {
  local port="${1:-8080}"
  # TODO: Check php node python etc. and use
  php -S localhost:${port}
}

#
# Supress output of a given command and run it in the background. Does not
# supress error messages.
#
# usage: silent <command>
#
silent() {
  "$@" >/dev/null &
}

#
# Display the weather for a given city.
#
# usage: weather [<city>]
#
weather() {
  curl "wttr.in/~${1:-Vladikavkaz}"
}

#
# CD to Project directory.
#
# usage: p
#
p() {
  if [[ -d "$1" ]] || [[ -n "$PROJECTS_DIR" && -d "$PROJECTS_DIR" ]]; then
    cd -P $(find -L ${1:-$PROJECTS_DIR} -maxdepth 5 -type d | fzf)
  else
    cd -P $(find -L . -maxdepth 5 -type d | fzf)
  fi
}

# Generate authentication keys for SSH.
#
# usage: gen-ssh-keygen-rsa <path/to/key/file> <comment>
#
ssh-keygen-gen-rsa() {
  ssh-keygen -t rsa -o -a 64 -b 4096 -f ~/.ssh/keys/$1 -C "$2"
}

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# Extracts the archive file
#
# usage: extract <filename>
#
extract() {
  setopt localoptions noautopushd

  if (( $# == 0 )); then
    cat >&2 <<'EOF'
Usage: extract [-option] [file ...]

Options:
    -r, --remove    Remove archive after unpacking.
EOF
  fi

  local remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  local pwd="$PWD"
  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" >&2
      shift
      continue
    fi

    local success=0
    local extract_dir="${1:t:r}"
    local file="$1" full_path="${1:A}"
    case "${file:l}" in
      (*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$file" | tar xv } || tar zxvf "$file" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$file" ;;
      (*.tar.xz|*.txz)
        tar --xz --help &> /dev/null \
        && tar --xz -xvf "$file" \
        || xzcat "$file" | tar xvf - ;;
      (*.tar.zma|*.tlz)
        tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$file" \
        || lzcat "$file" | tar xvf - ;;
      (*.tar.zst|*.tzst)
        tar --zstd --help &> /dev/null \
        && tar --zstd -xvf "$file" \
        || zstdcat "$file" | tar xvf - ;;
      (*.tar) tar xvf "$file" ;;
      (*.tar.lz) (( $+commands[lzip] )) && tar xvf "$file" ;;
      (*.tar.lz4) lz4 -c -d "$file" | tar xvf - ;;
      (*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$file" ;;
      (*.gz) (( $+commands[pigz] )) && pigz -dk "$file" || gunzip -k "$file" ;;
      (*.bz2) bunzip2 "$file" ;;
      (*.xz) unxz "$file" ;;
      (*.lrz) (( $+commands[lrunzip] )) && lrunzip "$file" ;;
      (*.lz4) lz4 -d "$file" ;;
      (*.lzma) unlzma "$file" ;;
      (*.z) uncompress "$file" ;;
      (*.zip|*.war|*.jar|*.ear|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$file" -d "$extract_dir" ;;
      (*.rar) unrar x -ad "$file" ;;
      (*.rpm)
        command mkdir -p "$extract_dir" && builtin cd -q "$extract_dir" \
        && rpm2cpio "$full_path" | cpio --quiet -id ;;
      (*.7z) 7za x "$file" ;;
      (*.deb)
        command mkdir -p "$extract_dir/control" "$extract_dir/data"
        builtin cd -q "$extract_dir"; ar vx "$full_path" > /dev/null
        builtin cd -q control; extract ../control.tar.*
        builtin cd -q ../data; extract ../data.tar.*
        builtin cd -q ..; command rm *.tar.* debian-binary ;;
      (*.zst) unzstd "$file" ;;
      (*.cab) cabextract -d "$extract_dir" "$file" ;;
      (*.cpio) cpio -idmvF "$file" ;;
      (*)
        echo "extract: '$file' cannot be extracted" >&2
        success=1 ;;
    esac

    (( success = success > 0 ? success : $? ))
    (( success == 0 && remove_archive == 0 )) && rm "$full_path"
    shift

    # Go back to original working directory in case we ran cd previously
    builtin cd -q "$pwd"
  done
}

# vim:foldmethod=marker:foldlevel=2
