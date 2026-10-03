#!/usr/bin/env bash
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${NAME:-Unknown}"
    else
        echo "Unknown"
    fi
}

check_command() {
    command -v "$1" >/dev/null 2>&1
}
