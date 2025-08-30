#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


### History ###

# Overwrite when storing
shopt -u histappend

# Infinite history
HISTSIZE=-1
HISTFILESIZE=-1

# Erase duplicates, ignore duplicates, ignore starting with space
HISTCONTROL=ignoreboth:erasedups


### Functions & Aliases ###

# cd automatically calls ls
function cd {
	builtin cd "$@" && ls -A -F --color=auto
}

# ls always show hidden files and color
alias ls='ls -A -F --color=auto'
# grep color
alias grep='grep --color=auto'
# Dotfiles git
alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' # dotfiles git
# Helix abreviation
alias hx='helix'
# Pacman always sudoes
alias pacman='sudo pacman'
# Remove recursive, confirmation, verbose
alias rm='rm -r -I -v'
# Quit
alias q='exit'


### Other ###

# Playstations
PS1='\[\e[32m\]\u\[\e[90m\]@\[\e[36m\]\h\[\e[90m\]:\[\e[33m\]\w\[\e[0m\] \\$ '

# No ctrl + q, ctrl + s
stty -ixon

fastfetch # Good ol' neofetch
