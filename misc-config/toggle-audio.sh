#!/bin/bash

# Script that switches from finicky bluetooth headphones to system audio, and
# back. Requires the use of a2dp.py to avoid headset audio issues.

headphones_index=$(pacmd list-sinks | egrep -v "pci" | grep -B 1 "name:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
speaker_index=$(pacmd list-sinks | egrep -v "usb|pci.*extra" | grep -B 1 "name:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
current_index=$(pacmd list-sinks | grep "\*.*index:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")

if [ "$headphones_index" = "$current_index" ]; then
    new_index=$speaker_index
    playback_streams=$(pacmd list-sink-inputs | grep "index" | cut -c 12-)
    readarray -t playback_streams <<<"$playback_streams"

    if [ "$playback_streams" = "" ]; then
        pacmd set-default-sink $new_index
    else
        for stream in "${playback_streams[@]}"; do
            pacmd move-sink-input $stream $new_index
        done
        pacmd set-default-sink $new_index
    fi
    notify-send "Switched to speakers"
elif [ "$speaker_index" = "$current_index" ]; then
    # Using bluetooth headphones has some buggy subtleties; call a Python
    # script to set this up. Assume it's in the same directory as the script.
    $(dirname $0)/a2dp.py "00:19:5D:04:34:75"

    # Grab the headphones index again, in case it has changed.
    new_index=$(pacmd list-sinks | egrep -v "pci" | grep -B 1 "name:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
    playback_streams=$(pacmd list-sink-inputs | grep "index" | cut -c 12-)
    readarray -t playback_streams <<<"$playback_streams"

    if [ "$playback_streams" != "" ]; then
        for stream in "${playback_streams[@]}"; do
            pacmd move-sink-input $stream $new_index
        done
    fi
    pacmd set-default-sink $new_index
    notify-send "Switched to headphones"
else
    notify-send "Unknown current playback device index! '$current_index'"
    exit
fi
