#!/bin/bash
# Övervakar nedladdningsmappen för nya .vv-filer och öppnar dem automatiskt

WATCH_DIR="$HOME/Downloads"
inotifywait -m -e close_write --format '%w%f' "$WATCH_DIR" | while read FILE
do
  if [[ "$FILE" == *.vv ]]; then
    if grep -q "\[virt-viewer\]" "$FILE"; then
      echo "Detected new Proxmox VV file: $FILE"
      /usr/bin/remote-viewer "$FILE" &
    fi
  fi
done

