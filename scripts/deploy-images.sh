#!/bin/sh
set -e
# This script builds and deploys images to Docker Hub
# Development Usage: ./deploy-images.sh -username myUserName -password myPassword
# Production Usage: ./deploy-images.sh -username myUserName -password myPassword -production true

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo "${YELLOW}==== deploy-images.sh script ====${NC}"
while [[ $# -gt 0 ]]; do
    case "$1" in
    -username)
        username=$2
        shift
        ;;
    -password)
        password=$2
        shift
        ;;
    -production)
        production=$2
        shift
        ;;
    *)
        echo "Invalid argument: $1"
        exit 1
    esac
    shift
done

echo "${GREEN}Logging into PBBG.com Docker Hub${NC}"
docker login --username $username --password $password

if [[ -n "$production" ]]; then
  echo "${CYAN}Pushing production images to PBBG.com Docker Hub${NC}"
  docker-compose -f docker-compose.build.yml push
else
  echo "${YELLOW}Pushing development images to PBBG.com Docker Hub${NC}"
  docker-compose push
fi

echo "${GREEN}Successfully pushed images to Docker Hub.${NC}"
