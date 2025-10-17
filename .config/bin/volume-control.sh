#!/bin/sh

if [ "$1" == 'raise' ]; then
	pactl set-sink-volume @DEFAULT_SINK@ +5%
elif [ "$1" == 'lower' ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -5%
elif [ "$1" == 'mute' ]; then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

cur_vol="$(pactl get-sink-volume @DEFAULT_SINK@)"
cur_vol="$(echo $cur_vol | grep -o -P '(?<=/ ).*?(?= )' | head -1)"

if [[ "$(pactl get-sink-mute @DEFAULT_SINK@)" =~ "yes" ]]; then
	notify-send 'Volume: '"$cur_vol"' (MUTED)'
else
	notify-send 'Volume: '"$cur_vol"
fi

