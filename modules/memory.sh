#!/usr/bin/env bash
get_memory_info() {
    local total=0 free=0 avail=0 buffers=0 cached=0 swap_total=0 swap_free=0
    
    if [[ -f /proc/meminfo ]]; then
        total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
        free=$(awk '/^MemFree:/ {print $2}' /proc/meminfo)
        avail=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
        buffers=$(awk '/^Buffers:/ {print $2}' /proc/meminfo)
        cached=$(awk '/^Cached:/ {print $2}' /proc/meminfo)
        swap_total=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
        swap_free=$(awk '/^SwapFree:/ {print $2}' /proc/meminfo)
    fi

    local used=$((total - free - buffers - cached))
    local usage_pct=0
    if (( total > 0 )); then
        usage_pct=$(awk "BEGIN {printf \"%.1f\", ($used/$total) * 100}")
    fi

    MEM_TOTAL_MB=$((total / 1024))
    MEM_USED_MB=$((used / 1024))
    MEM_AVAIL_MB=$((avail / 1024))
    MEM_USAGE_PCT="$usage_pct"
    
    SWAP_TOTAL_MB=$((swap_total / 1024))
    SWAP_USED_MB=$(( (swap_total - swap_free) / 1024 ))
}
