#!/bin/sh
set -e
# This script installs all the dependencies needed for docker on a DigitalOcean droplet

GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo $(date -u) "==== setup-docker.sh script ===="
echo $(date -u) "${GREEN}Updating apt-get...${NC}"
sudo apt-get update

echo $(date -u) "${GREEN}Enabling docker repository over https...${NC}"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo $(date -u) "${GREEN}Adding Docker's official GPG key...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo $(date -u) "${GREEN}Verify the key with fingerprint matching 0EBFCD88...${NC}"
if sudo apt-key fingerprint 0EBFCD88 | grep -q "Docker Release"; then
  echo $(date -u) "${GREEN}Fingerprint confirmed!${NC}"
fi

echo $(date -u) "${GREEN}Setup stable docker repository...${NC}"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo $(date -u) "${GREEN}Installing docker engine from stable repository...${NC}"
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo $(date -u) "${GREEN}Setting docker to start automatically on server boot...${NC}"
sudo systemctl enable --now docker

echo $(date -u) "${GREEN}Verifying docker installation...${NC}"
if sudo docker run hello-world | grep -q "Hello from Docker!"; then
  echo $(date -u) "${GREEN}Installation successful!${NC}"
fi

echo $(date -u) "${GREEN}Installing Docker-Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo $(date -u) "${GREEN}Applying executable permissions to the Docker-Compose binary...${NC}"
sudo chmod +x /usr/local/bin/docker-compose

echo $(date -u) "${GREEN}Adding bash completion to bash for docker-compose...${NC}"
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.28.5/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

echo $(date -u) "${GREEN}Test Docker-Compose installation...${NC}"
if sudo docker-compose --version | grep -q "docker-compose version"; then
  echo $(date -u) "${GREEN}Installation successful!${NC}"
fi
