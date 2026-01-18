#!/bin/sh

if [ ! -f d.json ]; then
	echo '{}' > d.json
fi

if [ $# -eq 3 ]; then
	jq ".\"$1\" += {\"$3\": {value: $2, date: \"$(date "+%D %T")\"}}" d.json > d.json.tmp
elif [ $# -eq 2 ]; then
	jq "del(.$1.$2)" d.json > d.json.tmp
elif [ $# -eq 1 ]; then
	jq "del(.$1" d.json > d.json.tmp
else
	keys=$(jq 'keys[]' d.json -r)

	for each in $keys; do
		echo -ne "\n$each: "
		jq "[.$each.[].value] | add" d.json
		jq ".$each" d.json
	done

	echo

	exit 0
fi

if [ $? -eq 0 ]; then
	mv -f d.json.tmp d.json
fi

exit 0
