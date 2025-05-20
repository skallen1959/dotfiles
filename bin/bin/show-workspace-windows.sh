#!/bin/bash

# Hämta aktuell arbetsyta
CURRENT_WORKSPACE=$(hyprctl activewindow -j | jq -r .workspace.id)

# Hämta alla fönster på denna arbetsyta
WINDOWS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $CURRENT_WORKSPACE) | \"\(.address): \(.class) - \(.title)\"")

# Visa lista med wofi
SELECTED=$(echo "$WINDOWS" | wofi --dmenu --prompt "Windows on Workspace $CURRENT_WORKSPACE:" --width 800 --height 400 --cache-file /dev/null)

# Extrahera fönster-ID
WINDOW_ID=$(echo "$SELECTED" | cut -d':' -f1)

# Aktivera valt fönster
if [ -n "$WINDOW_ID" ]; then
    hyprctl dispatch focuswindow address:$WINDOW_ID
fi
