#!/bin/sh
set -e
# This script is a quick way to stop, rebuild, and restart the docker containers
# IMPORTANT: this does *NOT* use changes to any container Dockerfile.
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${GREEN}==== local-start.sh script ====${NC}"

echo "${GREEN}Bringing down running containers...${NC}"
docker-compose down
echo "${GREEN}Successfully stopped containers.${NC}"

echo "${GREEN}Building development images in parallel...${NC}"
docker-compose build --parallel
echo "${GREEN}Successfully built development images.${NC}"

echo "${GREEN}Starting containers...${NC}"
docker-compose up -d
echo "${GREEN}Successfully started containers.${NC}"

echo "${YELLOW}Containers have executed their final CMD, RUN, or ENTRYPOINT commands and may not have finished installing their own dependencies.${NC}"
echo "${GREEN}Stack should be accessible on host machine at http://localhost${NC}"
