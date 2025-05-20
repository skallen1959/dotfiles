#!/usr/bin/env bash

# WireGuard custom menu script to manage NetworkManager WireGuard connections using wofi
# Install to the same directory as wireguard.sh
# Example usage: ~/bin/wireguard-wofi.sh
# Integrates with Waybar via on-click

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Hantera argument för toggling
if [[ $# != 0 ]]; then
    if [[ "$1" == "quit" ]]; then
        exit 0
    elif [[ "$1" != "reload" ]]; then
        connection=$(echo "$1" | cut -d: -f1)
        message="$($SCRIPT_DIR/wireguard.sh toggle "$connection")"
        if command -v notify-send >/dev/null 2>&1; then
            notify-send "WireGuard" "$message"
        fi
        exit 0
    fi
fi

# Hämta anslutningar från wireguard.sh
MENU=$($SCRIPT_DIR/wireguard.sh menu)

# Bygg Wofi-meny
ACTIVE=""
INACTIVE=""
while read -r state connection ip; do
    if [[ "$state" == "connected:" ]]; then
        if [[ -n "$ip" ]]; then
            ACTIVE="$ACTIVE$connection [$ip]\n"
        else
            ACTIVE="$ACTIVE$connection\n"
        fi
    elif [[ "$state" == "available:" ]]; then
        INACTIVE="$INACTIVE$connection\n"
    fi
done <<< "$MENU"

# Visa Wofi-meny
CHOICE=$(echo -e "${ACTIVE}${INACTIVE}reload\nquit" | wofi --dmenu --prompt "Select VPN" | awk '{print $1}')

# Hantera valet
if [[ -n "$CHOICE" ]]; then
    if [[ "$CHOICE" == "quit" ]]; then
        exit 0
    elif [[ "$CHOICE" == "reload" ]]; then
        $0 reload
    else
        echo "$CHOICE"
        $SCRIPT_DIR/wireguard.sh toggle "$CHOICE"
        if command -v notify-send >/dev/null 2>&1; then
            notify-send -t 3000 -a "WireGuard" "WireGuard" "$($SCRIPT_DIR/wireguard.sh toggle "$CHOICE")"
        fi
    fi
fi
