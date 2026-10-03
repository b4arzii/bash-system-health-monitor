#!/usr/bin/env bash
validate_config() {
    local vars=("CPU_WARNING" "CPU_CRITICAL" "MEMORY_WARNING" "MEMORY_CRITICAL" "DISK_WARNING" "DISK_CRITICAL" "CHECK_INTERVAL")
    for var in "${vars[@]}"; do
        if ! [[ "${!var}" =~ ^[0-9]+$ ]]; then
            log "ERROR" "Invalid integer for ${var} in config: ${!var}"
            return 3
        fi
    done
    return 0
}
