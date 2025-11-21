#!/bin/sh

if [ "$1" == 'whole' ]; then
	maim -ou | tee ~/.local/share/Trash/files/$(date +%s).png | xclip -selection clipboard -t image/png
elif [ "$1" == 'selection' ]; then
	maim -sou | tee ~/.local/share/Trash/files/$(date +%s).png | xclip -selection clipboard -t image/png
fi
