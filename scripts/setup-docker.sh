#!/bin/sh
set -e
# This script installs all the dependencies needed for docker on a DigitalOcean droplet

GREEN='\033[1;32m'

echo -e "${GREEN}Updating apt-get..."
sudo apt-get update

echo -e "${GREEN}Enabling docker repository over https..."
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo -e "${GREEN}Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "${GREEN}Verify the key with fingerprint matching 0EBFCD88..."
if sudo apt-key fingerprint 0EBFCD88 | grep -q "Docker Release"; then
  echo -e "${GREEN}Fingerprint confirmed!"
fi

echo -e "${GREEN}Setup stable docker repository..."
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo -e "${GREEN}Installing docker engine from stable repository..."
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo -e "${GREEN}Setting docker to start automatically on server boot..."
sudo systemctl enable --now docker

echo -e "${GREEN}Verifying docker installation..."
if sudo docker run hello-world | grep -q "Hello from Docker!"; then
  echo -e "${GREEN}Installation successful!"
fi

echo -e "${GREEN}Installing Docker-Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo -e "${GREEN}Applying executable permissions to the Docker-Compose binary..."
sudo chmod +x /usr/local/bin/docker-compose

echo -e "${GREEN}Adding bash completion to bash for docker-compose..."
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

echo -e "${GREEN}Test Docker-Compose installation..."
if sudo docker-compose --version | grep -q "docker-compose version"; then
  echo -e "${GREEN}Installation successful!"
fi
