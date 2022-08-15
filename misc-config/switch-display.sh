#!/bin/bash

# Script that switches display inputs via DDC.

LEFT_MONITOR=/dev/i2c-6
RIGHT_MONITOR=/dev/i2c-7

DP_VAL=15
HDMI1_VAL=17
HDMI2_VAL=18

TARGET=$1

case $TARGET in
  DP)
    ddccontrol -r 0x60 -w $DP_VAL dev:$LEFT_MONITOR
    ddccontrol -r 0x60 -w $DP_VAL dev:$RIGHT_MONITOR
    ;;
  HDMI1)
    ddccontrol -r 0x60 -w $HDMI1_VAL dev:$LEFT_MONITOR
    ddccontrol -r 0x60 -w $HDMI1_VAL dev:$RIGHT_MONITOR
    ;;
  HDMI2)
    ddccontrol -r 0x60 -w $HDMI2_VAL dev:$LEFT_MONITOR
    ddccontrol -r 0x60 -w $HDMI2_VAL dev:$RIGHT_MONITOR
    ;;
  *)
    echo "Usage: switch-display.sh (DP|HDMI1|HDMI2)"
    exit 1
    ;;
esac
