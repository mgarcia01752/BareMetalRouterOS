#!/usr/bin/env bash

# Set environment variables
FLAG_FILE_DIR="/var/flags"
FACTORY_FLAG_FILE_NAME="bmros.FACTORY_START"
FACTORY_START_FLAG_PATH="${FLAG_FILE_DIR}/${FACTORY_FLAG_FILE_NAME}"

PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# Export variables to make them available to child processes
export  FLAG_FILE_DIR \
        FACTORY_START_FLAG_PATH \
        PATH

printdbg () {
        if [ -e "${FLAG_FILE_DIR}/bmros.DEBUG" ]; then 
                echo -e "\033[0;32m${1}\033[0m"
        fi
}

printerr () {
    if [ -e "${FLAG_FILE_DIR}/bmros.DEBUG" ]; then 
        echo -e "\033[0;31m${1}\033[0m"
    fi
}

alias cli='/usr/lib/routershell/router-shell.sh'
