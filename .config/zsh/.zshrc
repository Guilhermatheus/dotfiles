case "$-" in *i*) ;; *) return ;; esac # Don't execute when interactive

### Options

setopt extended_glob no_beep no_match menu_complete interactive_comments autocd
stty stop undef # Don't freeze on ctrl-s
zle_highlight=('paste:none')

bindkey -v

### Keybinds ###

function fzf-history() { $(cat ~/.config/zsh/history | fzf) }
zle -N fzf-history
bindkey '^r' fzf-history


### Completions ###

autoload -Uz compinit
zstyle ':completion:*' menu select

zmodload zsh/complist

_comp_options+=(globdots)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


### Sources & Plugins ###

source "$ZDOTDIR/zsh-functions"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

### History ###

HISTFILE="$ZDOTDIR/history"
SAVEHIST=100000
HISTSIZE=$SAVEHIST
setopt hist_ignore_all_dups # No history duplicates


### Functions & Aliases ###

alias grep='grep --color=auto'
alias ls='ls -A -F --color=auto' # Always show hidden files

# cd automatically calls ls
cd() {
	builtin cd "$@" && eza -a
}

# Trash given files, else list trash
tr() {
	if [ $# -eq 0 ]; then
		trash-list
	else
		trash-put -v "$@"
	fi
}

# Use paru if it exists, else use pacman like paru
pac() {
	if type paru > /dev/null; then
		paru "$@"
	else
		if [ $# -eq 0 ]; then
			sudo pacman -Syu
		else
			sudo pacman "$@"
		fi
	fi
}

alias dof='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME' # Dotfiles git


# Always prompt before doing and show result
alias rm='rm -riv'
alias cp='cp -riv'
alias mv='mv -iv'
alias mkdir='mkdir -vp'
alias cat='bat'
alias ls='eza -a'
alias tree='eza --tree'
alias ln='ln -s'

alias oil="nvim '+:Oil'"
alias q='exit'


### Fancy Stuff ###

# Prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

fastfetch # Good ol' neofetch
