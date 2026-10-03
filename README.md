# bash-system-health-monitor

A professional, production-quality Linux System Health Monitor built entirely in Bash. Designed for system administrators and DevOps engineers to continuously monitor system health, generate reports, and integrate into automated workflows.

## Features
- **Comprehensive Monitoring**: CPU, Memory, Disk, Network, Processes, Services, and Temperature.
- **Real-Time Dashboard**: Interactive TUI with `--watch`.
- **Multiple Output Formats**: Human-readable, JSON, and CSV.
- **Health Scoring**: Configurable thresholds for WARNING and CRITICAL states.
- **Robust Logging**: Structured logging with configurable levels.
- **Portable**: Works across Debian, Ubuntu, Fedora, Arch, Parrot, and Kali.
- **Secure**: Follows strict Bash security practices (`set -Eeuo pipefail`, no `eval`, safe temp files).

## Installation
```bash
git clone <repository-url>
cd bash-system-health-monitor
sudo ./install.sh
