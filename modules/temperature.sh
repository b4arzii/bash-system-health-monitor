#!/usr/bin/env bash
get_temperature_info() {
    TEMP_C="N/A"
    if [[ -d /sys/class/thermal ]]; then
        for zone in /sys/class/thermal/thermal_zone*/; do
            if [[ -f "${zone}temp" ]]; then
                local temp=$(cat "${zone}temp" 2>/dev/null)
                if [[ -n "$temp" ]]; then
                    TEMP_C=$(awk "BEGIN {printf \"%.1f\", $temp/1000}")
                    break
                fi
            fi
        done
    fi
}
