#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

PASS=0
FAIL=0

assert_eq() {
    local desc="$1" expected="$2" actual="$3"
    if [[ "$expected" == "$actual" ]]; then
        echo -e "\033[0;32m[PASS]\033[0m $desc"
        ((PASS++))
    else
        echo -e "\033[0;31m[FAIL]\033[0m $desc (Expected: '$expected', Got: '$actual')"
        ((FAIL++))
    fi
}

# Test JSON escape
source "$PROJECT_DIR/lib/formatting.sh"
assert_eq "JSON escape quotes" 'hello \"world\"' "$(json_escape 'hello "world"')"
assert_eq "JSON escape backslash" 'path\\to\\file' "$(json_escape 'path\to\file')"

# Test Config Validation
source "$PROJECT_DIR/lib/validation.sh"
CPU_WARNING=70
CPU_CRITICAL=90
MEMORY_WARNING=70
MEMORY_CRITICAL=90
DISK_WARNING=80
DISK_CRITICAL=90
CHECK_INTERVAL=2
validate_config
assert_eq "Config validation passes" "0" "$?"

CPU_WARNING="abc"
validate_config || true
assert_eq "Config validation fails on string" "3" "$?"

echo ""
echo "Tests completed: $PASS passed, $FAIL failed."
(( FAIL == 0 )) || exit 1
