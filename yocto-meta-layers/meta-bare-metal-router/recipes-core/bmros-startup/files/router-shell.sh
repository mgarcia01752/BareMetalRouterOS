#!/usr/bin/env bash

# Description: Wrapper script to set up the environment and execute start.sh for RouterShell.
# Usage: This script is typically executed during system startup to initialize the RouterShell environment.

# Source system-wide profile settings to ensure consistent environment variables
source /etc/profile

# Change directory to the RouterShell installation directory
cd /usr/lib/routershell || exit 1

echo "RouterShell Start..........."

if [ -f "$FACTORY_START_FLAG_PATH" ]; then
    echo "Factory Reset of RouterShell"
    ./start.sh --factory-reset || { echo "start.sh --factory-reset -> failed, exiting"; exit 1; }
    rm $FACTORY_START_FLAG_PATH
    exit 0
fi  

# Execute the start.sh script to initialize RouterShell
./start.sh || { echo "start.sh -> failed, exiting"; exit 1; }

exit 0
