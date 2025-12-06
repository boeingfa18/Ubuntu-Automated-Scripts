echo "Starting install for Winboat and it's required dependencies"

echo "Installing required dependencies:"
echo "Starting install for Docker Engine"
# Updates package lists
sudo apt update
# Installs required dependencies for Docker Engine
sudo apt install ca-certificates curl gnupg -y
# Downloads Docker GPG Key and imports into System's trusted keys
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Adds the Docker Repository to the System's package list
echo \
  "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
# Updates System package lists and installs Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
# Enables and starts the Docker System Service
sudo systemctl enable --now docker
