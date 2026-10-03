#!/usr/bin/env bash
get_cpu_info() {
    local usage=0 load_avg cores model freq
    
    # Usage from /proc/stat
    if [[ -f /proc/stat ]]; then
        local cpu_line
        read -r cpu_line < /proc/stat
        local user nice system idle iowait irq softirq
        read -r _ user nice system idle iowait irq softirq _ <<< "$cpu_line"
        local total=$((user + nice + system + idle + iowait + irq + softirq))
        local idle_total=$((idle + iowait))
        if (( total > 0 )); then
            usage=$(awk "BEGIN {printf \"%.1f\", (1 - $idle_total/$total) * 100}")
        fi
    fi

    # Load average
    if [[ -f /proc/loadavg ]]; then
        read -r load_avg _ < /proc/loadavg
    fi

    # Cores and Model
    if [[ -f /proc/cpuinfo ]]; then
        cores=$(grep -c '^processor' /proc/cpuinfo)
        model=$(grep '^model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)
        freq=$(grep '^cpu MHz' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)
    fi

    CPU_USAGE="$usage"
    CPU_LOAD="$load_avg"
    CPU_CORES="${cores:-N/A}"
    CPU_MODEL="${model:-Unknown}"
    CPU_FREQ="${freq:-N/A}"
}
