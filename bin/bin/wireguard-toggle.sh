#!/bin/bash

# Namn på WireGuard-anslutningen
CONNECTION="Istudios-Admin"

# Kontrollera status för anslutningen
STATUS=$(nmcli connection show --active | grep "$CONNECTION" | awk '{print $1}')

if [ "$1" = "toggle" ]; then
    if [ -n "$STATUS" ]; then
        # Anslutningen är aktiv, stäng av
        nmcli connection down "$CONNECTION" >/dev/null
    else
        # Anslutningen är inaktiv, aktivera
        nmcli connection up "$CONNECTION" >/dev/null
    fi
fi

# Uppdatera status efter toggle
STATUS=$(nmcli connection show --active | grep "$CONNECTION" | awk '{print $1}')

# Hämta IP-adress om ansluten
if [ -n "$STATUS" ]; then
    IP=$(nmcli connection show "$CONNECTION" | grep IP4.ADDRESS | awk '{print $2}')
    CLASS="connected"
    TEXT="🔒 $CONNECTION"
    TOOLTIP="WireGuard: Connected ($IP)"
else
    CLASS="disconnected"
    TEXT="🔓 $CONNECTION"
    TOOLTIP="WireGuard: Disconnected"
fi

# Returnera JSON för Waybar
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\", \"class\": \"$CLASS\"}"
