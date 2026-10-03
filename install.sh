#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_DIR="/usr/local/bin/system-health-monitor"
CONFIG_DIR="/etc/system-health-monitor"

echo "Installing bash-system-health-monitor..."
mkdir -p "$INSTALL_DIR" "$CONFIG_DIR"

cp -r modules lib "$INSTALL_DIR/"
cp monitor.sh "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/monitor.sh"

cp config/monitor.conf "$CONFIG_DIR/"

ln -sf "$INSTALL_DIR/monitor.sh" /usr/local/bin/system-health-monitor

echo "Installation complete. Run 'system-health-monitor' to start."
