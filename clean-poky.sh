#!/usr/bin/env bash

source lib/common.sh

echo "Are you sure you want to remove the 'poky/meta-bare-metal-router' directory? (y/n)"
read confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    rm -rf poky/meta-bare-metal-router
    rm -rf poky/build-bmros/tmp

else
    echo "Removal of 'poky/meta-bare-metal-router' directory canceled."
fi
