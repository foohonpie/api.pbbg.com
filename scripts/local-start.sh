#!/bin/sh
set -e
# This script is a quick way to stop, rebuild, and restart the docker containers

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "==== local-start.sh script ===="

echo "Bringing down running containers..."
docker-compose down
echo "${GREEN}Successfully stopped containers.${NC}"

echo "Building development images in parallel..."
docker-compose build --parallel
echo "${GREEN}Successfully built development images.${NC}"

echo "Starting containers..."
docker-compose up -d
echo "${GREEN}Successfully started containers.${NC}"

echo "${YELLOW}Containers have executed their final CMD, RUN, or ENTRYPOINT commands and may not have finished installing their own dependencies.${NC}"
echo "${GREEN}Proxy entry should be accessible on host machine at http://localhost${NC}"
