#!/bin/bash
if [ -f /etc/os-release ]; then 
	source /etc/os-release
else
	PRETTY_NAME="Unknown Linux Distro"
fi

# I love touching myself while doing this as a girl.

main() {
	notify-send -a "Koishi is Calling" "Good Morning From Koishi" \
		"<i>Koishi says you Currently Using $PRETTY_NAME.</i>\nProcesses: $(pgrep -c .)\nCPU: bored\nRAM: slightly tired\nMood: loading..." \
  		-u normal \
  		-t 7000 \
		-i "$HOME/.config/sway/dep/koishi_welcome.png"
}

StartSound() {
	sleep 1
	pw-play "$HOME/microsoft-windows-95-startup-sound.mp3"
}

StartSound &
main

