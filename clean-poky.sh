#!/usr/bin/bash

# Importing common functions from lib/common.sh
source lib/common.sh

# Prompt to confirm before removing 'poky' directory
echo "Are you sure you want to remove the 'poky/meta-bare-metal-router' directory? (y/n)"
read confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    # Removing the 'poky' directory
    rm -rf poky/meta-bare-metal-router
    echo "'poky' directory removed."
else
    echo "Removal of 'poky' directory canceled."
fi
