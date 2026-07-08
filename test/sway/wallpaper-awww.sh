#!/bin/bash

#By Troyyy and Myself

wallpaper_dir="$(ls ~/Pictures/wallpaper)"
wallpaper="$HOME/.cache/currentwallpaper.png"
wallpaperblurred="$HOME/.cache/bluredcurrentwallpaper.png"

# Show the menu using Rofi

SelectWallpaper() {
    chosen=$(echo -e "$wallpaper_dir" |  PREVIEW=true rofi -show filebrowser -filebrowser-command 'echo' -filebrowser-directory ~/Pictures/wallpaper -modes filebrowser )
}

RandomWallpaper() {
    chosen=$(echo "$wallpaper_dir" | shuf -n 1 )
}

# sets the wallpaper and put the blur and wallpaper image on ~/.cache
main() {
	# refuses to run if no wallpaper picked
    notify-send "setting the wallpaper"
    if [[ -z "$chosen" ]]; then
	    notify-send "you didn't pick any wallpaper"
	    return 1
    else
		# configure the color
#		 PREVIEW=true rofi -theme fullscreen-preview.rasi -show filebrowser -filebrowser-command 'ls' -filebrowser-directory ~/Pictures/wallpaper
	    wal -b 000000 -i "$chosen" --cols16 darken -n --saturate 0.2
#	    wal -i "$chosen" -n

		# kill aka reload the waybar
		sleep 3s

		# sets the wallpaper
#		waypaper --wallpaper -- "$path" 
		awww img -t wipe "$path"
		swaync-client -rs &
	    cp "$chosen" "$wallpaper"
		rm "$wallpaperblurred"
#		magick "$chosen" -blur 0x20 "$wallpaperblurred"
		pkill waybar
		waybar &
fi
}

if [[ "$1" == "login" ]]; then
	exit
fi

if [[ -n $@ ]]; then
	RandomWallpaper
    path="$HOME/Pictures/wallpaper/$chosen"

	main
else
	SelectWallpaper
    path="$chosen"

	main
fi

