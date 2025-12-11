#!/bin/sh

location=~/Pictures/Screenshot/$(date +%s).png


if [ "$1" == 'selection' ]; then
	input='-sou'
else
	input='-ou'
fi


maim "$input" "$location"


if [ "$?" -eq 0 ]; then
	xclip -selection clipboard -t image/png -i "$location"
	notify-send "Screenshot saved to $location"
else
	notify-send "Screenshot cancelled"
fi
