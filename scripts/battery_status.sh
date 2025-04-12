#!/bin/bash
#
# Show battery status as a popup notification
# Dependencies: acpi, notify-send

# Get battery information using acpi
if ! command -v acpi &> /dev/null; then
    notify-send "Battery Status" "Error: acpi command not found. Please install acpi package."
    exit 1
fi

# Get battery information
battery_info=$(acpi -b)

if [ $? -ne 0 ] || [ -z "$battery_info" ]; then
    notify-send "Battery Status" "No battery detected or error retrieving battery information."
    exit 1
fi

# Extract battery percentage
percentage=$(echo "$battery_info" | grep -oP '[0-9]+(?=%)')

# Extract charging status
charging_status=""
if echo "$battery_info" | grep -q "Charging"; then
    charging_status="Charging"
elif echo "$battery_info" | grep -q "Discharging"; then
    charging_status="Discharging"
elif echo "$battery_info" | grep -q "Full"; then
    charging_status="Fully Charged"
else
    charging_status="Unknown Status"
fi

# Extract remaining time if available
remaining_time=""
if echo "$battery_info" | grep -q "[0-9]\+:[0-9]\+:[0-9]\+"; then
    remaining_time=$(echo "$battery_info" | grep -o "[0-9]\+:[0-9]\+:[0-9]\+")
    
    if [ "$charging_status" = "Discharging" ]; then
        remaining_time="Time remaining: $remaining_time"
    elif [ "$charging_status" = "Charging" ]; then
        remaining_time="Time until charged: $remaining_time"
    fi
fi

# Determine icon and urgency based on battery level
icon="battery-good"
urgency="normal"

if [ "$charging_status" = "Charging" ]; then
    icon="battery-good-charging"
elif [ "$percentage" -le 20 ]; then
    icon="battery-low"
    urgency="critical"
elif [ "$percentage" -le 40 ]; then
    icon="battery-caution"
    urgency="normal"
fi

# Create message
message="Status: $charging_status\nLevel: $percentage%"

if [ -n "$remaining_time" ]; then
    message="$message\n$remaining_time"
fi

# Send notification
notify-send -u "$urgency" -i "$icon" "Battery Status" "$message"

exit 0