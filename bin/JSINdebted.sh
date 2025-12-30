#!/bin/sh

if [ ! -f d.json ]; then
	echo '{}' > d.json
fi

if [ $# -eq 3 ]; then
	jq ".\"$(echo $1 | iconv -t ASCII//TRANSLIT)\" += {\"$(echo $3 | iconv -t ASCII//TRANSLIT)\": {value: $2, date: \"$(date "+%D %T")\"}}" d.json > d.json.tmp
elif [ $# -eq 2 ]; then
	jq "del(.$(echo $1 | iconv -t ASCII//TRANSLIT).$(echo $2 | iconv -t ASCII//TRANSLIT))" d.json > d.json.tmp
elif [ $# -eq 1 ]; then
	jq "del(.$(echo $1 | iconv -t ASCII//TRANSLIT))" d.json > d.json.tmp
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

mv -f d.json.tmp d.json

exit 0
