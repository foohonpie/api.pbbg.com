#!/bin/sh
set -e
# This script sets up default firewall rules on DO droplets

GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo $(date -u) "==== setup-firewall-rules.sh script ===="

echo $(date -u) "Setting basic firewall rules..."
sudo ufw disable
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw allow 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw allow 9000/tcp
sudo ufw enable

echo $(date -u) "${GREEN}Firewall setup!${NC}"
