#!/usr/bin/env bash
set -euo pipefail

# Docker/Winboat installer for Ubuntu-based distributions
# Installs Docker Engine, Compose plugin, and enables the daemon with basic safety checks.

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

if command -v docker >/dev/null 2>&1; then
  echo "Docker is already installed. Skipping installation steps."
else
  log_step 1 "Updating package lists and installing prerequisites..."
  ${SUDO} apt update
  ${SUDO} apt install -y ca-certificates curl gnupg

  log_step 2 "Adding Docker's official GPG key..."
  ${SUDO} install -m 0755 -d /etc/apt/keyrings
  if ! curl -fsSL https://download.docker.com/linux/ubuntu/gpg | ${SUDO} gpg --dearmor -o /etc/apt/keyrings/docker.gpg; then
    echo "Failed to download or import the Docker GPG key." >&2
    exit 1
  fi
  ${SUDO} chmod a+r /etc/apt/keyrings/docker.gpg

  log_step 3 "Adding Docker repository..."
  ${SUDO} bash -c "echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' > /etc/apt/sources.list.d/docker.list"

  log_step 4 "Installing Docker Engine and Compose plugin..."
  ${SUDO} apt update
  ${SUDO} apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

log_step 5 "Enabling and starting Docker service..."
${SUDO} systemctl enable --now docker
${SUDO} systemctl status --no-pager docker || true

cat <<'INFO'
--------------------------------------------------
Docker installation finished.
If you want to run Docker as a non-root user, add yourself to the docker group:
  sudo usermod -aG docker "$USER" && newgrp docker
Then log out and back in for the change to take effect.
--------------------------------------------------
INFO
