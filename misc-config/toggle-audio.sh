#!/bin/bash

# Script that switches from finicky bluetooth headphones to system audio, and
# back. Requires the use of a2dp.py to avoid headset audio issues.

headphones_index=$(pacmd list-sinks | egrep -v "pci" | grep -B 1 "name:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
speaker_index=$(pacmd list-sinks | egrep -v "usb|pci.*extra" | grep -B 1 "name:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
current_index=$(pacmd list-sinks | grep "\*.*index:" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")

echo "Headphones index: $headphones_index"
echo "Speakers index: $speaker_index"
echo "Current index: $current_index"

if [ "$headphones_index" = "$current_index" ]; then
    echo "Switching to speakers"

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
    echo "Switching to headphones"

    # Using bluetooth headphones has some buggy subtleties; call a Python
    # script to set this up. Assume it's in the same directory as the script.
    # First, we need the MAC address of our headphones.
    mac_address=$(pacmd list-sinks | sed -e "/index: $headphones_index/,/device.string/!d" | grep 'device.string' | grep -o '".*"' | tr -d '"')
    $(dirname $0)/a2dp.py "$mac_address"

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
