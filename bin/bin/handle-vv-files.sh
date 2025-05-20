#!/bin/bash
# Tar emot en .vv-fil från Chrome och öppnar den med remote-viewer
FILE="$1"
if [[ "$FILE" == *.vv ]]; then
  /usr/bin/remote-viewer "$FILE"
else
  echo "Not a .vv file: $FILE" >&2
  exit 1
fi
