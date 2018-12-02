#!/bin/bash

# Screen and tablet configuration for the Wacom Cintiq Pro 13.
# This script limits the tablet touch input to only a single monitor and
# configures pen button 3 ("right click") to be mapped to ctrl + z.

on_error() {
  notify-send "Tablet configuration failed; error on line $1"
}
trap 'on_error $LINENO' ERR

export DISPLAY=":0"
export XAUTHORITY="/home/daisy/.Xauthority"

TABLET="Cintiq Pro 13"
MONITOR="DP-0"

# Limit tablet touch to work only on a single monitor.
echo "Querying touch device"
finger_touch=$(xinput | grep -e "$TABLET.*Touch" | cut -f 2 | cut -c 4-)
echo "Query result: $finger_touch"

if [[ $finger_touch ]]; then
  echo "Mapping to output"
  xinput map-to-output $finger_touch $MONITOR
  echo "Done with touch device"
fi

# Map pen button 3 to "ctrl + z".
echo "Querying stylus"
stylus=$(xinput | grep -e "$TABLET.*Pen stylus" | cut -f 2 | cut -c 4-)
echo "Query result: $stylus"

if [[ $stylus ]]; then
  echo "Configuring stylus button 3 as ctrl+z"
  xsetwacom set $stylus Button 3 "KEY ctrl + z"
  echo "Done with stylus"
fi

# Only notify-send if something was actually done.
if [[ $finger_touch ]] || [[ $stylus ]]; then
  notify-send "Tablet configured"
fi
