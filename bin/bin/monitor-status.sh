#!/bin/bash

# Parsa hyprctl monitors för att hitta aktiva skärmar
output=$(hyprctl monitors)

# Kolla status för eDP-1 och HDMI-A-1
EDP_ACTIVE=$(echo "$output" | grep -A18 "Monitor eDP-1" | grep -q "disabled: false" && echo "eDP-1" || echo "")
HDMI_ACTIVE=$(echo "$output" | grep -A18 "Monitor HDMI-A-1" | grep -q "disabled: false" && echo "HDMI-A-1" || echo "")

if [ -n "$EDP_ACTIVE" ] && [ -n "$HDMI_ACTIVE" ]; then
    TEXT="Both"
elif [ -n "$EDP_ACTIVE" ]; then
    TEXT="Int"
elif [ -n "$HDMI_ACTIVE" ]; then
    TEXT="Ext"
else
    TEXT="No screen"
fi

# Returnera enkel sträng
echo "$TEXT"
