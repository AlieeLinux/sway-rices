#!/bin/bash

STATE_FILE="$HOME/.countdown_state"
TOTAL_DAYS=103

if [[ ! -f "$STATE_FILE" ]]; then
    END_DATE=$(date -d "+$TOTAL_DAYS days" +%s)
    echo "$END_DATE" > "$STATE_FILE"
fi

END_DATE=$(cat "$STATE_FILE")
NOW=$(date +%s)

# Compute remaining days
REMAIN=$(( (END_DATE - NOW) / 86400 ))

if [[ $REMAIN -le 0 ]]; then
    echo "Countdown finished! Time to die and leave on this cruel world"
    exit 0
fi

notify-send "Days left to live: $REMAIN"
