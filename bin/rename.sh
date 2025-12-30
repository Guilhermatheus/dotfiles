for filename in AudioCutter_*; do
	[ -f "$filename" ] || continue
	mv "$filename" "${filename//AudioCutter_/}"
done
