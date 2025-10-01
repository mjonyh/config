#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS, likely a laptop, display battery status
  # This assumes the tmux-battery plugin is installed and configured
  # We need to replicate the original tmux.conf formatting as much as possible
  # The original line was:
  # set -ga status-right "#{?#{e|>=:10,#{battery_percentage}},#{#[bg=#{@thm_red},fg=#{@thm_bg}]},#{#[bg=#{@thm_bg},fg=#{@thm_pink}]}} #{battery_icon} #{battery_percentage} "
  # We can't directly use tmux variables in a shell script, so we'll just output the raw battery info
  # and let tmux format it. Or, we can try to get the battery info directly.
  # For simplicity, let's assume the tmux-battery plugin provides a way to get raw values.
  # If not, we'd need to parse `pmset -g batt` on macOS.

  # A simpler approach is to just output the battery icon and percentage, and let tmux handle the colors.
  # However, the original line has conditional coloring based on percentage.
  # Let's try to get the raw percentage and icon from tmux-battery if possible.
  # If not, we'll use a basic shell command for battery status.

  # For now, let's output a placeholder that tmux can then format.
  # This will require the tmux-battery plugin to still be active.
  # The script will just decide *if* to show it.

  # Let's try to get the battery percentage and icon using pmset for macOS
  # and then format it similar to how tmux-battery would.
  # This is more robust than relying on tmux-battery's internal variables in a shell script.

  battery_info=$(pmset -g batt | grep -oE '[0-9]{1,3}%|charged')
  battery_percentage=$(echo "$battery_info" | grep -oE '[0-9]{1,3}' | head -1)
  battery_status=$(echo "$battery_info" | grep -oE 'charged|charging|discharging')

  battery_icon=""
  if [[ "$battery_status" == "charged" ]]; then
    battery_icon="󰁹" # Full battery icon
  elif [[ "$battery_status" == "charging" ]]; then
    battery_icon="󰂄" # Charging icon
  elif [[ "$battery_percentage" -ge 90 ]]; then
    battery_icon="󰁹"
  elif [[ "$battery_percentage" -ge 70 ]]; then
    battery_icon="󰁽"
  elif [[ "$battery_percentage" -ge 50 ]]; then
    battery_icon="󰁿"
  elif [[ "$battery_percentage" -ge 30 ]]; then
    battery_icon="󰂁"
  elif [[ "$battery_percentage" -ge 10 ]]; then
    battery_icon="󰂃"
  else
    battery_icon="󰂎" # Low battery icon
  fi

  # Output the formatted string that tmux can then color
  echo "${battery_icon} ${battery_percentage}%"
else
  # Not macOS, likely a desktop, hide battery status
  echo " "
fi
