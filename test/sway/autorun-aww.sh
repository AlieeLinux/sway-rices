#!/usr/bin/bash

awww-daemon --no-cache &

wallpaper="$HOME/.config/sway/wallpaper.sh"
image="$HOME/.cache/currentwallpaper.png"

if [[ -f "$image" ]]; then
    awww img -t wipe "$image"
else
    bash "$wallpaper"
fi


