
alias download-music='yt-dlp -x --audio-format mp3 --audio-quality 6  --download-archive download-archive.txt --convert-thumbnails jpg  --embed-metadata --embed-thumbnail'

read -p "File path: " path

if [ -f "$path"]; then
	
	
	while read link; do
		
		download-music "$link"
		
		if [ $? -eq 0 ]; then
			grep -v "$link" $path > $path.tmp
			mv -f $path.tmp $path
		fi

	done < $path

	if [ ! -s $path ]; then
		rm -f $path
	fi

	for music in *.mp3; do
		[ -f "$music" ] || break
		mp3gain -r "$music"
	done


else
	echo 'ERROR: File not found'
fi
