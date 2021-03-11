#!/bin/sh
set -e
# This script adds a user to the docker group with permissions to use docker
# Development Usage: ./add-user-to-docker-group.sh --username=myUsername
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== add-user-to-docker-group.sh script ===="
while [ $# -gt 0 ]; do
  case "$1" in
    --username=*)
      username="${1#*=}"
      ;;
    *)
      printf "* Error: Invalid argument.*\n"
      exit 1
  esac
  shift
done

echo $(date -u) "Creating docker group if not exists and adding user..."
sudo groupadd docker
sudo usermod -aG docker ${username}
sudo su ${username}
echo $(date -u) "${GREEN}Successfully joined docker group.${NC}"

echo $(date -u) "Testing hello-world access to docker"
if sudo docker run hello-world | grep -q "Hello from Docker!"; then
  echo $(date -u) "${GREEN}${username} has docker access.${NC}"
fi
