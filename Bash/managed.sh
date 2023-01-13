#!/bin/bash
iwconfig
sleep 0.5

echo "Re Starting Conflicting Processes"
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service

echo "Setting $1 Mode Managed"
echo ""
sudo ip link set $1 down
sudo iw dev $1 set type managed
sudo ip link set $1 up

sleep 0.5
iwconfig 
