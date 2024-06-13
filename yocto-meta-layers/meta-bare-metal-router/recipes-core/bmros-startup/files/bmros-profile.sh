#!/usr/bin/env bash

# Set environment variables
FLAG_FILE_DIR="/var/flags"
FACTORY_FLAG_FILE_NAME="bmros.FACTORY_START"
FACTORY_START_FLAG_PATH="${FLAG_FILE_DIR}/${FACTORY_FLAG_FILE_NAME}"

# Export variables to make them available to child processes
export  FLAG_FILE_DIR \
        FACTORY_START_FLAG_PATH
