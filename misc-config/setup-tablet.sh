#!/bin/bash

# Screen and tablet configuration for the Huion 1060 Plus drawing tablet.
# This script limits the tablet to only a single monitor, in order to make the
# most use of its drawing space, and also modifies some of the pad and stylus
# buttons.

set -e

# Limit tablet to work only on a single monitor.
MONITOR="DVI-I-1"
pen_input=$(xinput | grep -e 'Huion.*Pen.*stylus' | cut -f 2 | cut -c 4-)
xinput map-to-output $pen_input $MONITOR

# Setup stylus button mapping (switch pan/right-click).
xsetwacom --set 'Huion Tablet HA60-F400 Pen stylus' Button 2 "button +3"
xsetwacom --set 'Huion Tablet HA60-F400 Pen stylus' Button 3 "button +2"

# Setup pad button mappings.
xsetwacom --set 'Huion Tablet HA60-F400 Pad pad' Button 1 "key +ctrl +z -z -ctrl"
xsetwacom --set 'Huion Tablet HA60-F400 Pad pad' Button 2 "key +ctrl +shift +z -z -shift -ctrl"
xsetwacom --set 'Huion Tablet HA60-F400 Pad pad' Button 3 "key e"

notify-send "Tablet configured"
