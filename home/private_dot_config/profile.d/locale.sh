# shellcheck source=/dev/null shell=bash disable=SC2039,2086,2116,SC2166,2206
## (1) Locale ------------------------------------------------------------- {{{1

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_COLLATE="C"
export LC_NUMERIC="C"
export LC_MEASUREMENT="ru_RU.UTF-8"
export LC_MONETARY="ru_RU.UTF-8"
export LC_PAPER="ru_RU.UTF-8"
export LC_TIME="ru_RU.UTF-8"

[[ -L /etc/localtime ]] && export TZ=:/etc/localtime
