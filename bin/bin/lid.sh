#!/bin/bash
# ~/bin/lid.sh

case "$1" in
  open)
    # Lid open: Enable eDP-1, ensure BenQ is at 2560x1440@59.95
    hyprctl keyword monitor "eDP-1,1920x1080@60,2560x0,1"
    hyprctl keyword monitor "desc:BNQ BenQ PD2705Q F5L02335019,2560x1440@59.95,0x0,1"
    ;;
  close)
    # Lid closed: Disable eDP-1, ensure BenQ is at 2560x1440@59.95
    hyprctl keyword monitor "eDP-1,disable"
    hyprctl keyword monitor "desc:BNQ BenQ PD2705Q F5L02335019,2560x1440@59.95,0x0,1"
    ;;
esac
