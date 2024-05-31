#!/usr/bin/env bash

source lib/common.sh

echo "Are you sure you want to remove the 'poky/meta-bare-metal-router' directory? (y/n)"
read confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    rm -rf poky/meta-bare-metal-router
    echo "'poky' directory removed."

else
    echo "Removal of 'poky' directory canceled."

fi
