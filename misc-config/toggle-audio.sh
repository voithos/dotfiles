#!/bin/bash

# Script that switches from headphones to system audio, and back.

headphones_index=$(pacmd list-sinks | grep -B 1 "name:.*Razer" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
speaker_index=$(pacmd list-sinks | grep -B 1 "name:.*TX-Hifi" | tr "\n" ":" | tr -d "[[:space:]]" | tr -d "^\*" | cut -f 2 -d ":")
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
    notify-send --hint=int:transient:1 -t 1000 -u normal "Switched to speakers"
elif [ "$speaker_index" = "$current_index" ]; then
    echo "Switching to headphones"

    new_index=$headphones_index
    playback_streams=$(pacmd list-sink-inputs | grep "index" | cut -c 12-)
    readarray -t playback_streams <<<"$playback_streams"

    if [ "$playback_streams" != "" ]; then
        for stream in "${playback_streams[@]}"; do
            pacmd move-sink-input $stream $new_index
        done
    fi
    pacmd set-default-sink $new_index
    notify-send --hint=int:transient:1 -t 1000 -u normal "Switched to headphones"
else
    notify-send "Unknown current playback device index! '$current_index'"
    exit
fi
