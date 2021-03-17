#!/bin/sh
set -e
# This script is a quick way to stop, rebuild, and restart the docker containers

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo $(date -u) "==== Setting up Laravel ===="

echo $(date -u) "Running migrations..."
php artisan migrate --force
echo $(date -u) "${GREEN}Successfully migrated.${NC}"

echo $(date -u) "${GREEN}Laravel has been successfully set up.${NC}"
