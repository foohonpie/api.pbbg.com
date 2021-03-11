#!/bin/sh
set -e
# This script creates a new user for the docker swarm and build operation in Linux OS
# Development Usage: ./create-build-user.sh --username=myUsername --password=myPassword
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== create-build-user.sh script ===="
while [[ $# -gt 0 ]]; do
  case "$1" in
    --username=*)
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
adduser --disabled-password --gecos "" "${username}"
chpasswd <<<"${username}:${password}"
echo $(date -u) "${GREEN}Successfully created ${username} in the docker group.${NC}"

echo $(date -u) "Switching to use ${username} account..."
sudo su - ${username}
echo $(date -u) "${GREEN}Successfully switched to ${username}.${NC}"
