#!/usr/bin/env bash
set -euo pipefail

# Visual Studio Code installer for Ubuntu-based distributions
# Adds Microsoft repository safely, installs dependencies, and verifies installation.

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

if dpkg -s code >/dev/null 2>&1; then
  echo "Visual Studio Code is already installed. Skipping installation."
  exit 0
fi

log_step 1 "Updating package lists and installing prerequisites..."
${SUDO} apt update
${SUDO} apt install -y software-properties-common apt-transport-https wget gpg

log_step 2 "Importing Microsoft GPG key..."
${SUDO} install -m 0755 -d /etc/apt/keyrings
if ! curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | ${SUDO} gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg; then
  echo "Failed to download or import the Microsoft GPG key." >&2
  exit 1
fi
${SUDO} chmod a+r /etc/apt/keyrings/microsoft.gpg

log_step 3 "Adding Visual Studio Code repository..."
${SUDO} bash -c "echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main' > /etc/apt/sources.list.d/vscode.list"

log_step 4 "Installing Visual Studio Code..."
${SUDO} apt update
${SUDO} apt install -y code

log_step 5 "Verifying installation..."
if ! command -v code >/dev/null 2>&1; then
  echo "Visual Studio Code installation failed." >&2
  exit 1
fi

echo "Visual Studio Code installed successfully. Launch it with 'code'."
