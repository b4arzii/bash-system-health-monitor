#!/usr/bin/env bash
format_bytes() {
    local bytes=$1
    if (( bytes >= 1073741824 )); then
        awk "BEGIN {printf \"%.2f GB\", $bytes/1073741824}"
    elif (( bytes >= 1048576 )); then
        awk "BEGIN {printf \"%.2f MB\", $bytes/1048576}"
    elif (( bytes >= 1024 )); then
        awk "BEGIN {printf \"%.2f KB\", $bytes/1024}"
    else
        echo "${bytes} B"
    fi
}

json_escape() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf "%s" "$s"
}
