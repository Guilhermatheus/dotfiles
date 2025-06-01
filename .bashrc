#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### History ###

shopt -s histappend # Append history, don't overwrite

HISTCONTROL=ignoreboth # No repetition in history

# Increase history size

HISTSIZE=1000
HISTFILESIZE=2000

### Functions & Aliases ###

function cd {
  builtin cd "$@" && ls -a -F --color=auto
  } # cd automatically calls ls

alias ls='ls -a -F --color=auto' # ls always show hidden files and color
alias grep='grep --color=auto'
alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' # dotfiles git
alias hx='helix'
alias yz='yazi'
alias rm='rm -v -i -r'
alias cl='clear'

### Other ###

PS1="{\[$(tput setaf 196)\]\A\[$(tput sgr0)\]} [\[$(tput setaf 46)\]\u\[$(tput setaf 48)\]@\[$(tput setaf 51)\]\h \[$(tput setaf 226)\]\w\[$(tput sgr0)\]]\n-> " # Some PS1 decoration

stty -ixon # No ctrl + q ctrl + s

fastfetch # Good ol' neofetch
