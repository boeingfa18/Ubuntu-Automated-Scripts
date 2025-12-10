#!/usr/bin/env bash
set -euo pipefail

# OBS Studio installer for Ubuntu-based distributions
# Provides clear status output, privilege checks, and basic idempotency.

if [[ $(id -u) -ne 0 ]]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "This script requires elevated privileges. Please run as root or install sudo." >&2
    exit 1
  fi
  SUDO="sudo"
else
  SUDO=""
fi

log_step() {
  echo "[${1}] $2"
}

if dpkg -s obs-studio >/dev/null 2>&1; then
  echo "OBS Studio is already installed. Skipping installation."
  exit 0
fi

log_step 1 "Updating package lists and upgrading system packages..."
${SUDO} apt update
${SUDO} apt upgrade -y

log_step 2 "Installing OBS Studio..."
${SUDO} apt install -y obs-studio

log_step 3 "Verifying installation..."
if ! command -v obs >/dev/null 2>&1 && ! command -v obs-studio >/dev/null 2>&1; then
  echo "OBS Studio installation failed. Please check your network connection and package sources." >&2
  exit 1
fi

echo "OBS Studio installation completed successfully. You can launch it from your application menu or by running 'obs'."
