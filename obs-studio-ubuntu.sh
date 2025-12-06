echo "Installing OBS Studio"
# Updates package lists and installs package updates
sudo apt update
sudo apt update && sudo apt upgrade -y
# Installs OBS Studio
sudo apt install obs-studio -y
echo "OBS Studio is now installed"
