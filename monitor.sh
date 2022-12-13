#!/bin/bash
iwconfig
sleep 0.5

echo "Stopping Conflicting Processes"
sudo systemctl stop wpa_supplicant.service
sudo systemctl stop NetworkManager.service

echo "Setting $1 Mode Monitor"
echo ""
sudo ip link set $1 down
sudo iw dev $1 set type monitor
sudo ip link set $1 up

sleep 0.5
iwconfig 
