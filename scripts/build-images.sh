#!/bin/sh
set -e
# This script builds images
# Development Usage: ./build-images.sh
# Production  Usage: ./build-images.sh production

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

production=$1
devTag=master
prodTag=release

echo "==== build-images.sh script ===="
echo "Stopping running containers..."
docker-compose down

echo "Deleting stopped containers..."
docker-compose rm

echo "Deleting existing development images..."
if [ "$(docker image ls -a | grep frontend | grep $devTag)" ]; then
  docker rmi pbbg/frontend:$devTag
fi
if [ "$(docker image ls -a | grep backend | grep $devTag)" ]; then
  docker rmi pbbg/backend:$devTag
fi
if [ "$(docker image ls -a | grep database | grep $devTag)" ]; then
  docker rmi pbbg/database:$devTag
fi
if [ "$(docker image ls -a | grep proxy | grep $devTag)" ]; then
  docker rmi pbbg/proxy:$devTag
fi
echo "${YELLOW}Successfully deleted development images...${NC}"

echo "Deleting existing production images..."
if [ "$(docker image ls -a | grep frontend | grep $prodTag)" ]; then
  docker rmi pbbg/frontend:$prodTag
fi
if [ "$(docker image ls -a | grep backend | grep $prodTag)" ]; then
  docker rmi pbbg/backend:$prodTag
fi
if [ "$(docker image ls -a | grep database | grep $prodTag)" ]; then
  docker rmi pbbg/database:$prodTag
fi
if [ "$(docker image ls -a | grep proxy | grep $prodTag)" ]; then
  docker rmi pbbg/proxy:$prodTag
fi
echo "${CYAN}Successfully deleted production images...${NC}"

if [[ -n "$production" ]]; then
  echo "Building production images..."
  docker-compose -f docker-compose.build-for-prod.yml build --parallel
  echo "${CYAN}Successfully built production  images${NC}"
else
  echo "Building development images..."
  docker-compose build --parallel
  echo "${YELLOW}Successfully built development images${NC}"
fi

