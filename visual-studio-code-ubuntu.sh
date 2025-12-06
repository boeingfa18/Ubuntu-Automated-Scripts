echo "Installing Visual Studio Code"
# Installing Required Dependencies
sudo apt update
sudo apt install software-properties-common apt-transport-https wget -y
# Imports MSFT GPG Key to System's trusted keys
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg
# Add the VSC repo to the package lists
echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
# Updates the package lists and installs VSC
sudo apt update
sudo apt install code -y
echo "Visual Studio Code finished installing"
