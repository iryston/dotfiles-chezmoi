
## (3) Command History ---------------------------------------------------- {{{1

## History environment variables
export HISTFILE="${XDG_STATE_HOME}/.zsh_history" # Location of the zsh history file
export HISTSIZE=10000                            # Number of lines saved in memory (> than $SAVEHIST for HIST_EXPIRE_DUPS_FIRST to work)
export SAVEHIST=8000                             # Enable/disable the command history
## /!\ Needs "setopt extendedglob"
## "#" means optional. Ex: "vim#( *)#" matches "vi", "vim", "vim .*", "vi .* "
local ignore_system_cmd='[bf]g *|l[alsh]#( *)#|cd( *)#|git add *|git reset *|mc( *)#|pwd|exit|date|*--help|vault*'
local ignore_user_cmd='e( *)#|d( *)#|g( *)#|gui|j( *)#|ji|mkd( *)#|n( *)#|p( *)#'
export HISTORY_IGNORE="($ignore_system_cmd\|$ignore_user_cmd)"
unset ignore_system_cmd ignore_user_cmd

setopt APPEND_HISTORY         # append zsh sessions history list to the history file, rather than replace it
setopt HIST_EXPIRE_DUPS_FIRST # trim the oldest history event that has a duplicate before a unique event from the list
setopt HIST_FCNTL_LOCK        # better performance, in particular avoiding history corruption on NFS
setopt HIST_FIND_NO_DUPS      # do not display duplicates of a line previously found
setopt HIST_IGNORE_ALL_DUPS   # do not put duplicated command into history list
setopt HIST_IGNORE_SPACE      # remove command lines from the history when the first character on the line is a space
setopt HIST_NO_STORE          # remove the history (fc -l) command from the history list when invoked
setopt HIST_REDUCE_BLANKS     # remove unnecessary blanks
setopt HIST_SAVE_NO_DUPS      # do not save duplicated command
