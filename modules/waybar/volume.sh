#!/bin/sh

if systemctl --user is-active --quiet pipewire-pulse.service; then
    output=$(pw-volume status)
    if [ $? -eq 0 ]; then
        echo "$output"
    else
        echo '{"percentage": 0, "status": "mute", "text": "Err"}'
    fi
else
  echo '{"percentage": 0, "text": "Offline", "status": "mute"}'
fi
