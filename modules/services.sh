#!/usr/bin/env bash
get_service_info() {
    SVC_FAILED=0
    SVC_FAILED_LIST=""
    if check_command systemctl; then
        SVC_FAILED=$(systemctl --failed --no-legend --no-pager 2>/dev/null | wc -l)
        if (( SVC_FAILED > 0 )); then
            SVC_FAILED_LIST=$(systemctl --failed --no-legend --no-pager 2>/dev/null | awk '{print $2}' | tr '\n' ', ' | sed 's/,$//')
        fi
    else
        log "WARN" "systemd not detected, skipping service monitoring"
    fi
}
