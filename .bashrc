#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

source ~/.config/lscolors.sh

PS1="{\[$(tput setaf 196)\]\A\[$(tput sgr0)\]} [\[$(tput setaf 46)\]\u\[$(tput setaf 48)\]@\[$(tput setaf 51)\]\h \[$(tput setaf 226)\]\w\[$(tput sgr0)\]]\n-> "

export EDITOR=helix

fastfetch
