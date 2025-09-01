#!/usr/bin/env bash

ITEMS="Lock\nReboot\nShutdown\n"

choice=$(echo -e ${ITEMS} | walker -d -H)

case $choice in 
  Lock)
    swaylock
    ;;

  Reboot)
    reboot
    ;;

  Shutdown)
    poweroff
    ;;
  *)
    echo "Choice was $choice"
    ;;
esac


