case "$-" in *i*) ;; *) return ;; esac # Don't execute when interactive


###############
### Options ###
###############

setopt extended_glob no_beep no_match menu_complete interactive_comments autocd
stty stop undef # Don't freeze on ctrl-s
zle_highlight=('paste:none')

bindkey -v


###########################
### Functions & Aliases ###
###########################


# Remember last cd and return to that folder
if [[ -f "$ZDOTDIR/.zsh_last_cd" ]]; then
	OLD_PATH=$(cat "$ZDOTDIR/.zsh_last_cd")
	cd "$OLD_PATH"
fi

# cd saves current folder for return, automatic ls
auto-cd-init-cd() {
	CURR_PWD=$(pwd)
	echo "$CURR_PWD" > "$ZDOTDIR/.zsh_last_cd"
	ls
}

if [[ ${chpwd_functions[(I)auto-cd-init-cd]} -eq 0 ]]; then
	chpwd_functions+=(auto-cd-init-cd)
fi


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


# Always prompt before doing, show result, convenience
alias rm='rm -riv'
alias cp='cp -riv'
alias mv='mv -iv'
alias mkdir='mkdir -vp'
alias ln='ln -s'
alias grep='grep --color=auto'

# Updated alternatives
alias cat='bat'
alias tree='eza --tree'
alias ls='eza -a'

# Shortcuts
alias oil="nvim '+:Oil'"
alias q='exit'



################
### Keybinds ###
################

fzf-history() { $(cat $ZDOTDIR/history | fzf) }
zle -N fzf-history
bindkey '^r' fzf-history


###################
### Completions ###
###################

autoload -Uz compinit
zstyle ':completion:*' menu select

zmodload zsh/complist

_comp_options+=(globdots)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


#########################
### Sources & Plugins ###
#########################

source "$ZDOTDIR/.zsh_functions"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


###############
### History ###
###############

HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=100000
HISTSIZE=$SAVEHIST
setopt hist_ignore_all_dups # No history duplicates


###################
### Fancy Stuff ###
###################

# Prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

fastfetch # Good ol' neofetch
