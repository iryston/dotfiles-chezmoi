
## (2) XDG user directories ----------------------------------------------- {{{1

[[ -z "$XDG_APPLICATION_DIR" ]] && export XDG_APPLICATION_DIR="${HOME}/Applications"
[[ -z "$XDG_CACHE_HOME" ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z "$XDG_DESKTOP_DIR" ]] && export XDG_DESKTOP_DIR="${HOME}/Desktop"
[[ -z "$XDG_DOCUMENTS_DIR" ]] && export XDG_DOCUMENTS_DIR="${HOME}/Documents"
[[ -z "$XDG_DOWNLOAD_DIR" ]] && export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
[[ -z "$XDG_MUSIC_DIR" ]] && export XDG_MUSIC_DIR="${HOME}/Music"
[[ -z "$XDG_PICTURES_DIR" ]] && export XDG_PICTURES_DIR="${HOME}/Pictures"
[[ -z "$XDG_PUBLICSHARE_DIR" ]] && export XDG_PUBLICSHARE_DIR="${HOME}/Public"
[[ -z "$XDG_STATE_HOME" ]] && export XDG_STATE_HOME="${HOME}/.local/state"
[[ -z "$XDG_TEMPLATES_DIR" ]] && export XDG_TEMPLATES_DIR="${HOME}/Templates"
[[ -z "$XDG_VIDEOS_DIR" ]] && export XDG_VIDEOS_DIR="${HOME}/Videos"
