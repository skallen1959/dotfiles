#!/bin/bash

# Övervaka lockets tillstånd och ändra skärmkonfiguration i Hyprland
# Körs som en systemd user service eller fristående

LOGFILE="$HOME/.cache/lid-monitor.log"
NOTIFY_TIMEOUT=3000  # Notifikationstid i ms

# Logga till fil och konsol
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# Skicka notifikation om notify-send finns
notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -t "$NOTIFY_TIMEOUT" "Screen configuration" "$1"
    fi
}

# Konfigurera monitor med retries
configure_monitor() {
    local monitor="$1"
    local config="$2"
    local action="$3"  # enable/disable
    for i in {1..3}; do
        hyprctl keyword monitor "$monitor,$config" && {
            log "$monitor $action"
            return 0
        }
        log "Eroor at $action on $monitor, try $i"
        sleep 0.5
    done
    log "Failed with $action on $monitor after 3 tries"
    notify "Failure with $action $monitor"
    return 1
}

LAST_STATE=""
log "Starting lid-monitor.sh"

while true; do
    # Hantera oväntade formateringar
    CURRENT_STATE=$(cat /proc/acpi/button/lid/LID/state | grep -o "open\|closed" || echo "unknown")
    
    if [ "$CURRENT_STATE" != "$LAST_STATE" ] && [ "$CURRENT_STATE" != "unknown" ]; then
        log "Tillstånd ändrades till: $CURRENT_STATE"
        if [ "$CURRENT_STATE" = "closed" ]; then
            notify "Lid closed, inactivation internal screen"
            configure_monitor "eDP-1" "disable" "inactivated"
            configure_monitor "HDMI-A-1" "3840x2160@60,0x0,1.5" "configured"
        elif [ "$CURRENT_STATE" = "open" ]; then
            if hyprctl monitors | grep -q "HDMI-A-1"; then
                notify "Lid opened, activating both screens"
                configure_monitor "eDP-1" "1920x1080@60,0x0,1.5" "activated"
                configure_monitor "HDMI-A-1" "3840x2160@60,1280x0,1.5" "configured"
            else
                notify "Lid opened, activating only laptop screen"
                configure_monitor "eDP-1" "1920x1080@60,0x0,1.5" "activated"
                configure_monitor "HDMI-A-1" "disable" "inactivated"
            fi
        fi
        LAST_STATE="$CURRENT_STATE"
    fi

    sleep 1
done
