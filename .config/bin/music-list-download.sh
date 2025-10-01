alias downmus='yt-dlp -x --audio-format mp3 --audio-quality 6 --embed-metadata --convert-thumbnails jpg --embed-thumbnail'

function downlist {
	while read line; do
		char=$(echo "$line" | cut -c 1)
		if [ "$char" != "@" ]; then
			downmus $line
			if [ $? -eq 0 ]; then
				sed -i "s,$line,@&,g" $1
			fi
		fi
	done < $1
}