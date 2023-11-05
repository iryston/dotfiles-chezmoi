## Keybinding  ------------------------------------------------------------ {{{1

# Delete all existing keymaps and reset to the default state.
# bindkey -d

## emacs mode
bindkey -e

## give us access to ^Q, ^S
# stty -ixon

##### Keybindings #####
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

# home/end/del keybinds
# urxvt
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[3~" delete-char
# alacritty
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# bindkey "^[[Z" reverse-menu-complete             # Shift+Tab to complete in reverse order
bindkey "$terminfo[kcbt]" reverse-menu-complete # [Shift-Tab] - move backwards through completions
bindkey '^X^E' edit-command-line                # [Ctrl-X-Ctrl-E] - edit the current command in $EDITOR
bindkey '^X^V' copy-prev-shell-word             # [Ctrl-X-Ctrl-V] - copy previous shell word, useful for renaming files
