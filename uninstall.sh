#!/usr/bin/env bash
set -Eeuo pipefail

read -p "Are you sure you want to uninstall? (y/N) " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 0
fi

rm -rf /usr/local/bin/system-health-monitor
rm -rf /etc/system-health-monitor
rm -f /usr/local/bin/system-health-monitor

echo "Uninstalled successfully."
