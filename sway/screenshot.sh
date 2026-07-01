home="$HOME/Pictures/screenshots"
namef="screenshot_$(date +%d%m%Y_%H%M%S).png"
masterdir="$home/$namef"

FullScreenz() {
	if [[ -n  "$1" ]]; then
		sleep 3
		grim -l 0 -c "$home/$namef"
		swappy -f "$masterdir"
	else
		sleep 3
	    grim -l 0 "$home/$namef"
		swappy -f "$masterdir"

	fi
}

ScreenSelect() {
	area="$(slurp)"
	if [[ -n "$1" ]]; then
    	sleep 3
	    grim -g "$area" -c "$home/$namef"
		swappy -f "$masterdir"

	else
		sleep 3
		grim -g "$area" "$home/$namef"
		swappy -f "$masterdir"

	fi
}

main() {
	jjj=$(echo "FullScreen|SelectScreen|FullScreen W Cursor|SelectScreen W Cursor" | rofi -dmenu -p "Take a screenshot 3 sec delay" -sep "|")
	case "$jjj" in
		FullScreen)
			FullScreenz
			;;
		SelectScreen)
			ScreenSelect
			;;
		"FullScreen W Cursor")
			FullScreenz 1
			;;
        "SelectScreen W Cursor")
			ScreenSelect 1
			;;
	esac
}

main





