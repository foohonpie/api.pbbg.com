#!/bin/sh
set -e
# This script builds images
# Usage (for development images): ./build-images.sh
# Usage (for production images): ./build-images.sh production

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

production=$1

echo "${GREEN}==== build-images.sh script ====${NC}"
echo "${GREEN}Stopping running containers...${NC}"
# Bring down containers
docker-compose down

echo "${GREEN}Deleting stopped containers...${NC}"
# Remove stopped containers
docker-compose rm

echo "${GREEN}Deleting existing images...${NC}"
# Delete current dev images for rebuild
if [ "$(docker ps -a | grep frontend)" ]; then
  docker rmi frontend:master frontend:release
fi
if [ "$(docker ps -a | grep backend)" ]; then
  docker rmi backend:master backend:release
fi
if [ "$(docker ps -a | grep proxy)" ]; then
  docker rmi proxy:master proxy:release
fi
if [ "$(docker ps -a | grep database)" ]; then
  docker rmi database:master database:release
fi

if [[ -n "$production" ]]; then
  echo "${CYAN}Building production images...${NC}"
  # Build new Production images
  docker-compose -f docker-compose.build.yml build --parallel
  echo "${GREEN}Successfully built production  images${NC}"
else
  echo "${YELLOW}Building development images...${NC}"
  # Build new Development images
  docker-compose build --parallel
  echo "${GREEN}Successfully built development images${NC}"
fi

