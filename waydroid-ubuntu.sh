#!/usr/bin/env bash
set -euo pipefail

# Waydroid installer for Ubuntu-based distributions
# Includes privilege checks, optional GAPPS initialization, and service verification.

if [[ $(id -u) -ne 0 ]]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "This script requires elevated privileges. Please run as root or install sudo." >&2
    exit 1
  fi
  SUDO="sudo"
else
  SUDO=""
fi

WITH_GAPPS="false"
if [[ ${1-} == "--gapps" ]]; then
  WITH_GAPPS="true"
fi

log_step() {
  echo "[${1}] $2"
}

log_step 1 "Updating system packages..."
${SUDO} apt update
${SUDO} apt upgrade -y

log_step 2 "Installing required packages..."
${SUDO} apt install -y curl ca-certificates lxc

log_step 3 "Adding Waydroid repository..."
if ! curl -s https://repo.waydro.id | ${SUDO} bash; then
  echo "Failed to add the Waydroid repository. Please check your network connection." >&2
  exit 1
fi

log_step 4 "Installing Waydroid..."
${SUDO} apt update
${SUDO} apt install -y waydroid

log_step 5 "Initializing Waydroid container..."
if [[ ${WITH_GAPPS} == "true" ]]; then
  ${SUDO} waydroid init -s GAPPS
else
  ${SUDO} waydroid init
fi

log_step 6 "Enabling Waydroid container service..."
${SUDO} systemctl enable --now waydroid-container
${SUDO} systemctl status --no-pager waydroid-container || true

cat <<INFO
--------------------------------------------------
✔ Waydroid installation finished!
To start a session: waydroid session start
To launch the full Android UI: waydroid show-full-ui
Re-run with '--gapps' to initialize with Google Apps support.
--------------------------------------------------
INFO
