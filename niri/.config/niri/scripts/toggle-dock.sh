#!/bin/bash
if pgrep -f "dock.jsonc" > /dev/null; then
    pkill -f "dock.jsonc"
else
    waybar -c /home/diego-xir/.config/waybar/dock.jsonc -s /home/diego-xir/.config/waybar/dock.css > /dev/null 2>&1 &
fi
