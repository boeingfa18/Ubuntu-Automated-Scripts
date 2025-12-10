# Ubuntu Automated Scripts

A collection of installation helpers for popular tools on Ubuntu-based distributions. Each script uses fail-fast settings, privilege checks, and basic idempotency so you can re-run them safely.

## Prerequisites
- Ubuntu or an Ubuntu-based distribution with `apt`
- Internet connectivity
- Ability to run commands with elevated privileges (root or `sudo`)

## Scripts
### `obs-studio-ubuntu.sh`
Installs OBS Studio.
- Updates package lists and upgrades installed packages.
- Installs OBS Studio from the default repositories.
- Skips installation if OBS Studio is already present.

Run:
```bash
bash obs-studio-ubuntu.sh
```

### `visual-studio-code-ubuntu.sh`
Installs Visual Studio Code from the official Microsoft repository.
- Imports the Microsoft GPG key and adds the VS Code repository.
- Installs dependencies and Visual Studio Code.
- Skips installation if VS Code is already present.

Run:
```bash
bash visual-studio-code-ubuntu.sh
```

### `waydroid-ubuntu.sh`
Installs and initializes Waydroid. Add `--gapps` to initialize with Google Apps.
- Adds the Waydroid repository and installs Waydroid.
- Initializes the Waydroid container (optionally with GAPPS).
- Enables and reports the status of the `waydroid-container` service.

Run:
```bash
bash waydroid-ubuntu.sh [--gapps]
```

### `winboat-ubuntu.sh`
Installs Docker Engine and the Compose plugin, then enables the Docker service.
- Adds Docker's official repository and installs Docker plus Compose.
- Enables and starts Docker; prints guidance for using Docker without `sudo`.
- Skips installation if Docker is already present.

Run:
```bash
bash winboat-ubuntu.sh
```

## Notes
- Scripts are idempotent where possible but will update your system packages.
- For non-root users, the scripts rely on `sudo`; install it first if missing.
