#!/bin/sh
set -e
# This script builds images
# Usage (for development images): ./build-images.sh
# Usage (for production images): ./build-images.sh production

production=$1

# Bring down containers
docker-compose down

# Remove stopped containers
docker-compose rm

# Delete current prod images for rebuild
if [ "$(docker ps -a | grep pbbg-frontend)" ]; then
  docker rmi pbbg-frontend
fi
if [ "$(docker ps -a | grep pbbg-backend)" ]; then
  docker rmi pbbg-backend
fi
if [ "$(docker ps -a | grep pbbg-proxy)" ]; then
  docker rmi pbbg-proxy
fi
if [ "$(docker ps -a | grep pbbg-database)" ]; then
  docker rmi pbbg-database
fi

# Delete current dev images for rebuild
if [ "$(docker ps -a | grep frontend)" ]; then
  docker rmi frontend
fi
if [ "$(docker ps -a | grep backend)" ]; then
  docker rmi backend
fi
if [ "$(docker ps -a | grep proxy)" ]; then
  docker rmi proxy
fi
if [ "$(docker ps -a | grep database)" ]; then
  docker rmi database
fi

if [[ -n "$production" ]]; then
  # Build new Production images
  docker-compose -f docker-compose.build.yml build --parallel
else
  # Build new Development images
  docker-compose build --parallel
fi

