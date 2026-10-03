#!/usr/bin/env bash
get_system_info() {
    SYS_HOSTNAME=$(hostname 2>/dev/null || echo "unknown")
    SYS_DISTRO=$(detect_distro)
    SYS_KERNEL=$(uname -r)
    SYS_ARCH=$(uname -m)
    SYS_UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' || uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')
    SYS_USERS=$(who 2>/dev/null | wc -l)
}
