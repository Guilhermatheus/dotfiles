
alias download-music='yt-dlp -x --audio-format mp3 --audio-quality 6  --download-archive download-archive.txt --convert-thumbnails jpg --exec "mp3gain -r {}"  --embed-metadata --embed-thumbnail'

read -p "Music links file path: " path

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


else
	echo 'ERROR: File not found'
fi
