#!/bin/sh
set -e
# This script adds all necessary configuration for running PBBG.com on a Digital Ocean droplet
# Development Usage: ./initialize.sh --user=myUsername --password=myPassword
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== digital-ocean-initialize.sh script ===="

chmod 755 ./scripts/create-build-user.sh  && ./scripts/create-build-user.sh --username=githubuser --password=password
chmod 755 ./scripts/setup-firewall-rules.sh && ./scripts/setup-firewall-rules.sh
chmod 755 ./scripts/setup-docker.sh  && ./scripts/setup-docker.sh
chmod 755 ./scripts/add-user-to-docker-group.sh && ./scripts/add-user-to-docker-group.sh --username=githubuser
chmod 755 ./scripts/install-portainer.sh  && ./scripts/install-portainer.sh

echo $(date -u) "${GREEN}Server initialization script complete!${NC}"
