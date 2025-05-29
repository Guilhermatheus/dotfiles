#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd # Type name to access folder

### History ###

shopt -s histappend # Append history, don't overwrite

HISTCONTROL=ignoreboth # No repetition in history

HISTSIZE=1000 # More history
HISTFILESIZE=2000

### Aliases ###

alias ls='ls -a --color=auto'
alias grep='grep --color=auto'
alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

source ~/.config/lscolors.sh # Directly from https://github.com/trapd00r/LS_COLORS

PS1="{\[$(tput setaf 196)\]\A\[$(tput sgr0)\]} [\[$(tput setaf 46)\]\u\[$(tput setaf 48)\]@\[$(tput setaf 51)\]\h \[$(tput setaf 226)\]\w\[$(tput sgr0)\]]\n-> "

export EDITOR=helix



stty -ixon # No ctrl + q ctrl + s




fastfetch
