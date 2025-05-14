#!/bin/bash
if pgrep pasystray; then
    killall pasystray
else
    pasystray &
fi
