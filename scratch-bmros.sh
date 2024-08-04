#!/usr/bin/env bash

# Variables
INTERFACE="enx3c8cf8f943a2"
IP_ADDRESS="192.168.0.2/24"
BMROS_IP="192.168.0.1"

INTERFACE1="eno1"
IP_ADDRESS1="192.168.4.2/24"
BMROS_IP1="192.168.4.1"

# Set up the network interface
sudo ip link set dev "$INTERFACE" up
sudo ip addr add "$IP_ADDRESS" dev "$INTERFACE"

sudo ip link set dev "$INTERFACE1" up
sudo ip addr add "$IP_ADDRESS1" dev "$INTERFACE1"

# Wait for a ping reply from BMROS_IP
echo "Waiting for ping reply from $BMROS_IP..."
while ! ping -c 1 "$BMROS_IP" &> /dev/null; do
    sleep 1
done

echo "Ping reply received. Connecting to $BMROS_IP via telnet..."
telnet "$BMROS_IP"
