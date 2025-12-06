#!/bin/bash
set -e

echo "----------------------------------------------------------"
echo "   Waydroid Installer for Ubuntu / Ubuntu Based Distro"
echo "----------------------------------------------------------"

# 1. Update system
echo "[1/6] Updating system..."
sudo apt update && sudo apt upgrade -y

# 2. Install dependencies
echo "[2/6] Installing required packages..."
sudo apt install -y curl ca-certificates lxc

# 3. Add Waydroid repository
echo "[3/6] Adding Waydroid repository..."
curl -s https://repo.waydro.id | sudo bash

# 4. Install Waydroid
echo "[4/6] Installing Waydroid..."
sudo apt install -y waydroid

# 5. Initialize Waydroid
echo "[5/6] Initializing Waydroid container..."
sudo waydroid init

# If you want GAPPS automatically, replace above line with:
# sudo waydroid init -s GAPPS

# 6. Enable container service
echo "[6/6] Enabling Waydroid container service..."
sudo systemctl enable --now waydroid-container

echo "--------------------------------------------------"
echo "  ✔ Waydroid installation finished!"
echo "  To launch start a Waydrioid session: waydroid session start"
echo "  To launch full Android UI: waydroid show-full-ui"
echo "--------------------------------------------------"
