#!/usr/bin/env bash
get_process_info() {
    local running=0 sleeping=0 zombie=0
    if [[ -f /proc/stat ]]; then
        running=$(awk '/^procs_running/ {print $2}' /proc/stat)
    fi
    
    # Using ps for detailed counts
    local ps_out
    ps_out=$(ps -eo stat= 2>/dev/null)
    sleeping=$(echo "$ps_out" | grep -c '^S' || true)
    zombie=$(echo "$ps_out" | grep -c '^Z' || true)
    
    TOP_CPU_PROC=$(ps -eo comm,pcpu --sort=-pcpu 2>/dev/null | awk 'NR==2 {printf "%s %.1f%%", $1, $2}')
    TOP_MEM_PROC=$(ps -eo comm,rss --sort=-rss 2>/dev/null | awk 'NR==2 {printf "%s %.1f MB", $1, $2/1024}')
    
    PROC_RUNNING="$running"
    PROC_SLEEPING="$sleeping"
    PROC_ZOMBIE="$zombie"
}
