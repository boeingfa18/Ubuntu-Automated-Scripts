#!/bin/bash
set -e

echo "--------------------------------------------------"
echo "   Waydroid Installer for Zorin OS 18 Pro"
echo "--------------------------------------------------"

# 1. Update system
echo "[1/7] Updating system..."
sudo apt update && sudo apt upgrade -y

# 2. Install dependencies
echo "[2/7] Installing required packages..."
sudo apt install -y curl ca-certificates lxc

# 3. Add Waydroid repository
echo "[3/7] Adding Waydroid repository..."
curl -s https://repo.waydro.id | sudo bash

# 4. Install Waydroid
echo "[4/7] Installing Waydroid..."
sudo apt install -y waydroid

# 5. Initialize Waydroid
echo "[5/7] Initializing Waydroid container..."
sudo waydroid init

# If you want GAPPS automatically, replace above line with:
# sudo waydroid init -s GAPPS

# 6. Enable container service
echo "[6/7] Enabling Waydroid container service..."
sudo systemctl enable --now waydroid-container

# 7. Start session
echo "[7/7] Starting Waydroid session..."
waydroid session start &

echo "--------------------------------------------------"
echo "  ✔ Waydroid installation finished!"
echo "  To launch full Android UI: waydroid show-full-ui"
echo "--------------------------------------------------"
