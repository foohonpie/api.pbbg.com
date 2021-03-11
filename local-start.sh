#!/bin/sh
set -e
# This script is a quick way to stop, rebuild, and restart the docker containers

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo $(date -u) "==== local-start.sh script ===="

echo $(date -u) "Bringing down running containers..."
docker-compose -f docker-compose.local.yml down
echo $(date -u) "${GREEN}Successfully stopped containers.${NC}"

echo $(date -u) "Building development images in parallel..."
docker-compose -f docker-compose.local.yml build --parallel
echo $(date -u) "${GREEN}Successfully built development images.${NC}"

echo $(date -u) "Starting containers..."
docker-compose -f docker-compose.local.yml up
echo $(date -u) "${GREEN}Successfully started containers.${NC}"

echo $(date -u) "${YELLOW}Containers have executed their final CMD, RUN, or ENTRYPOINT commands and may not have finished installing their own dependencies.${NC}"
echo $(date -u) "${GREEN}Proxy entry should be accessible on host machine at http://localhost${NC}"
