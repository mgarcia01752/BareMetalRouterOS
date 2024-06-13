#!/usr/bin/env bash

# Description: Wrapper script to set up the environment and execute start.sh for RouterShell.
# Usage: This script is typically executed during system startup to initialize the RouterShell environment.

# Source system-wide profile settings to ensure consistent environment variables
source /etc/profile

# Change directory to the RouterShell installation directory
cd /usr/lib/routershell || exit 1

printdbg "RouterShell Wrapper Script Start"

if [ -f "$FACTORY_START_FLAG_PATH" ]; then
    
    printdbg "Start Factory Reset of RouterShell"
    ./start.sh --factory-reset || { printerr "start.sh --factory-reset -> failed, exiting"; exit 1; }
    
    printdbg "Removing ${FACTORY_START_FLAG_PATH}"
    rm $FACTORY_START_FLAG_PATH
    exit 0
fi  

# Execute the start.sh script to initialize RouterShell
printdbg "Starting Main RouterShell Script"
./start.sh || { printerr "start.sh -> failed, exiting"; exit 1; }

exit 0
