#!/usr/bin/env bash
log() {
    local level="$1"
    shift
    local msg="$*"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_file="${LOG_DIRECTORY}/monitor.log"
    
    mkdir -p "$(dirname "$log_file")"
    echo "${timestamp} [${level}] ${msg}" >> "$log_file"
    
    if [[ "$level" == "ERROR" ]]; then
        echo -e "${RED}[ERROR]${NC} ${msg}" >&2
    fi
}
