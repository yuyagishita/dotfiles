#!/usr/bin/env bash

# Get the currently focused monitor
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Set fuzzel width and font size based on monitor
if [[ "$monitor" == "DP-2" ]]; then
    # External display - larger size works well
    fuzzel --width=50 --font="Sans:size=13"
elif [[ "$monitor" == "eDP-1" ]]; then
    # Laptop display - smaller size and font
    fuzzel --width=25 --font="Sans:size=9"
else
    # Default fallback
    fuzzel --width=40 --font="Sans:size=12"
fi
