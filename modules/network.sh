#!/usr/bin/env bash
get_network_info() {
    NET_DATA=()
    if [[ -d /sys/class/net ]]; then
        for iface in /sys/class/net/*; do
            local name=$(basename "$iface")
            [[ "$name" == "lo" ]] && continue
            local state=$(cat "$iface/operstate" 2>/dev/null || echo "unknown")
            local rx=$(cat "$iface/statistics/rx_bytes" 2>/dev/null || echo 0)
            local tx=$(cat "$iface/statistics/tx_bytes" 2>/dev/null || echo 0)
            local ip=$(ip -4 addr show "$name" 2>/dev/null | awk '/inet/ {print $2}' | head -1)
            NET_DATA+=("${name}|${state}|${ip}|${rx}|${tx}")
        done
    fi
}
