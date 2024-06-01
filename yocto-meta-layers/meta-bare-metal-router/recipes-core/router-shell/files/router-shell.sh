#!/usr/bin/env bash

# Description: Wrapper script to set up the environment and execute start.sh for RouterShell.
# Usage: This script is typically executed during system startup to initialize the RouterShell environment.

# Source system-wide profile settings to ensure consistent environment variables
source /etc/profile

# Change directory to the RouterShell installation directory
cd /etc/routershell || exit 1

# Execute the start.sh script to initialize RouterShell
./start.sh
