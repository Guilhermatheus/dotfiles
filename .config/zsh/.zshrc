
### Options

setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef # Don't freeze on ctrl-s
zle_highight=('paste:none')

unsetopt BEEP # No sheepin' around here

bindkey -v




### History ###

HISTFILE="$ZDOTDIR/history"
HISTSIZE=1000
SAVEHIST=1000


### Functions & Aliases ###

# cd automatically calls ls
function cd { builtin cd "$@" && ls -A -F --color=auto }

# Trash given files, else list trash
function dl {
	if [ $# -eq 0 ]; then
		trash-list
	else
		trash -v "$@"
	fi
}

function mk {
	mkdir -v "$@"

	if [ $# -eq 1 ]; then
		cd "$1"
	fi
}

alias ls='ls -A -F --color=auto' # Always show hidden files
alias grep='grep --color=auto'

alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' # Dotfiles git

# Always prompt before doing and show result
alias rm='rm -r -i -v'
alias cp='cp -i -v'
alias mv='mv -i -v'

alias tc='touch'
alias hx='helix'
alias pac='sudo pacman'
alias q='exit'


### Fancy Stuff ###

# Prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

fastfetch # Good ol' neofetch
