
### History ###

HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -v

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
# Helix abbreviation
alias hx='helix'
# Pacman abbreviation, always sudoes
alias pac='sudo pacman'
# Remove recursive, confirmation, verbose
alias rm='rm -r -I -v'
# Quit
alias q='exit'

# Fancy prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

fastfetch # Good ol' neofetch
