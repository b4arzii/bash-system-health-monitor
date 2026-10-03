#!/usr/bin/env bash
get_disk_info() {
    DISK_DATA=()
    while read -r fs size used avail pct mount; do
        local pct_num="${pct%\%}"
        DISK_DATA+=("${mount}|${pct_num}|${size}|${used}|${avail}|${fs}")
    done < <(df -h -x tmpfs -x devtmpfs -x squashfs 2>/dev/null | tail -n +2)
}
