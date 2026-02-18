case "$-" in *i*) ;; *) return ;; esac # Don't execute when interactive


###############
### Options ###
###############

setopt extended_glob no_beep no_match menu_complete interactive_comments autocd
stty stop undef # Don't freeze on ctrl-s
zle_highlight=('paste:none')

bindkey -e


###############
### History ###
###############

HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=2000
HISTSIZE=$SAVEHIST
setopt hist_ignore_all_dups # No history duplicates


###########################
### Functions & Aliases ###
###########################

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



# cd saves current folder for return, automatic ls
on-cd() {
	echo "$PWD" > "$ZDOTDIR/.zsh_last_cd"
	ls
}

# Return to last cd folder if at home
if [[ -f "$ZDOTDIR/.zsh_last_cd" ]] && [[ "$PWD" = "$HOME" ]]; then
	cd "$(cat "$ZDOTDIR/.zsh_last_cd")"
elif [[ ! "$PWD" = "$HOME" ]]; then
	echo "$PWD" > "$ZDOTDIR/.zsh_last_cd"
fi

if [[ ${chpwd_functions[(I)on-cd]} -eq 0 ]]; then
	chpwd_functions+=(on-cd)
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


################
### Keybinds ###
################

# Ctrl-r fuzzy find history
fzf-history() { $(cat $HISTFILE | fzf) }
zle -N fzf-history
bindkey '^r' fzf-history

# Tab shows cd alternatives
first-tab() {
	if [[ $#BUFFER == 0 ]]; then
		BUFFER="cd "
		CURSOR=3
		zle list-choices
	else
		zle expand-or-complete
	fi
}
zle -N first-tab
bindkey '^I' first-tab


###############
### Plugins ###
###############

zsh_add_file() {
	[ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

zsh_add_plugin() {
	PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
	if [ ! -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
		git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
	fi
	zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
	zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
}

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


###################
### Fancy Stuff ###
###################

# Prompt with colors
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%2~%{$reset_color%} %%%{$reset_color%} "

# Good ol' neofetch
fastfetch
