
### Options

setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef # Don't freeze on ctrl-s
zle_highight=('paste:none')

unsetopt BEEP # No sheepin' around here

bindkey -v



### Completions

autoload -Uz compinit
zstyle ':completion:*' menu select

zmodload zsh/complist

_comp_options+=(globdots)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

source "$ZDOTDIR/zsh-functions"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

### History ###

HISTFILE="$ZDOTDIR/history"
HISTSIZE=1000
SAVEHIST=1000


### Functions & Aliases ###

# cd automatically calls ls
function cdls { cd "$@" && ls -A -F --color=auto }
alias cd='cdls'

# Trash given files, else list trash
function dl {
	if [ $# -eq 0 ]; then
		trash-list
	else
		trash-put -v "$@"
	fi
}

alias ls='ls -A -F --color=auto' # Always show hidden files
alias grep='grep --color=auto'

alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' # Dotfiles git


# Always prompt before doing and show result
alias rm='rm -r -i -v'
alias cp='cp -i -v'
alias mv='mv -i -v'
alias mkd='mkdir -v'
alias mkf='touch'

alias hx='helix'
alias pac='sudo pacman'
alias q='exit'


### Fancy Stuff ###

# Prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

fastfetch # Good ol' neofetch
