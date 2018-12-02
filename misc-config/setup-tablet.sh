#!/bin/bash

# Screen and tablet configuration for the Wacom Cintiq Pro 13.
# This script limits the tablet touch input to only a single monitor.

on_error() {
  notify-send "Tablet configuration failed; error on line $1"
}
trap 'on_error $LINENO' ERR

# Limit tablet touch to work only on a single monitor.
TABLET="Cintiq Pro 13"
MONITOR="HDMI-0"

finger_touch=$(xinput | grep -e "$TABLET.*Touch" | cut -f 2 | cut -c 4-)
if [[ $finger_touch ]]; then
  xinput map-to-output $finger_touch $MONITOR
fi

# Map pen button 3 to "Ctrl+Z".
stylus=$(xinput | grep -e "$TABLET.*Pen stylus" | cut -f 2 | cut -c 4-)
if [[ $stylus ]]; then
  xsetwacom set $stylus Button 3 "KEY ctrl + z"
fi

notify-send "Tablet configured"
