#!/usr/bin/env bash
 
#Exit service if client-only mode is enabled
SOUND_SUPERVISOR="$(ip route | awk '/default / { print $3 }'):3000"
MODE=$(curl --silent "$SOUND_SUPERVISOR/mode")
if [[ $MODE == "MULTI_ROOM_CLIENT" ]]; then
  exit 0
fi

if [[ -z "$DEVICE_NAME" ]]; then
  DEVICE_NAME=$(printf "balenaSound UPnP %s" $(hostname | cut -c -4))
fi

exec /usr/bin/gmediarender \
  --friendly-name "$DEVICE_NAME" \
  --port=49494
