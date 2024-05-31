#!/usr/bin/env bash

source lib/common.sh

display_banner "YOCTO SETUP"

check_os

# Update and upgrade packages
display_banner "Updating and Upgrading Packages"
sudo apt update || handle_warning "Failed to update packages."
sudo apt upgrade -y || handle_warning "Failed to upgrade packages."
echo "Packages updated and upgraded successfully."
echo

# Check if OS is supported
display_banner "Checking Supported OS"
if ! check_os; then
  echo "Error: Unsupported operating system."
  echo "This script is intended to run on the following OS:"
  echo "- Ubuntu 20.04 (LTS)"
  echo "- Ubuntu 22.04 (LTS)"
  echo "- Fedora 38"
  echo "- CentOS Stream 8"
  echo "- Debian GNU/Linux 11 (Bullseye)"
  echo "- Debian GNU/Linux 12 (Bookworm)"
  echo "- OpenSUSE Leap 15.4"
  echo "- AlmaLinux 8"
  echo "- AlmaLinux 9"
  echo "- Rocky 9"
  exit 1
fi
echo "Supported operating system detected."
echo

# Install required packages
display_banner "Installing Required Packages"
sudo apt install -y gawk wget git diffstat unzip texinfo \
                    gcc build-essential chrpath socat cpio \
                    python3 python3-pip python3-pexpect xz-utils \
                    debianutils iputils-ping python3-git python3-jinja2 \
                    libegl1-mesa libsdl1.2-dev python3-subunit \
                    mesa-common-dev zstd liblz4-tool file locales libacl1 || handle_warning "Failed to install packages."
echo "Required packages installed successfully."
echo

# https://panamint.kcir.pwr.edu.pl/~jkozlowi/golemos/step-by-step-guide-extended/python-packages.html
display_banner "Installing Required Python Packages"
pip install pipoe
