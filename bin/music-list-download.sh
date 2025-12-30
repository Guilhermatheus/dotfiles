
alias download-music='yt-dlp -x --audio-format mp3 --audio-quality 6  --download-archive download-archive.txt --convert-thumbnails jpg --exec "mp3gain -r -c {}"  --embed-metadata --embed-thumbnail'


if [ -f "$1" ]; then
	
	
	while read link; do
		
		download-music "$link"
		
		if [ $? -eq 0 ]; then
			grep -v "$link" "$1" > "$1".tmp
			mv -f "$1".tmp "$1"
		fi

	done < "$1"

	if [ ! -s "$1" ]; then
		rm -f "$1"
	fi


else
	echo 'ERROR: File not found'
fi
