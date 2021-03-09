#!/bin/sh
set -e
# This script creates a new user in Linux OS and adds it to the docker group with permissions to use docker
# Development Usage: ./add-user-to-docker-group.sh --user=myUsername --password=myPassword
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== add-user-to-docker-group.sh script ===="
while [[ $# -gt 0 ]]; do
  case "$1" in
    --user=*)
      user="${1#*=}"
      ;;
    --password=*)
      password="${1#*=}"
      ;;
    *)
      printf "* Error: Invalid argument.*\n"
      exit 1
  esac
  shift
done


echo $(date -u) "Creating new user..."
adduser --disabled-password --gecos "" "${user}"
chpasswd <<<"${user}:${password}"
echo $(date -u) "${GREEN}Successfully created ${user} in the docker group.${NC}"

echo $(date -u) "Switching to use ${user} account..."
sudo su - ${user}
echo $(date -u) "${GREEN}Successfully switched to ${user}.${NC}"

echo $(date -u) "Creating docker group if not exists and adding user..."
sudo groupadd docker
sudo usermod -aG docker ${user}
sudo su ${user}
echo $(date -u) "${GREEN}Successfully joined docker group.${NC}"

echo $(date -u) "Testing hello-world access to docker"
if sudo docker run hello-world | grep -q "Hello from Docker!"; then
  echo $(date -u) "${GREEN}${user} has docker access.${NC}"
fi

echo $(date -u) "Enabling user 666 access to /var/run/docker.sock..."
sudo chmod 666 /var/run/docker.sock
echo $(date -u) "${GREEN}${user} has 666 access to docker.sock.${NC}"
