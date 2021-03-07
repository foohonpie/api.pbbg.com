#!/bin/sh
set -e
# IMPORTANT: this script is intended to be used during the Github Actions build steps (using secret credentials)
# This script pushes existing images to Docker Hub
# Development Usage: ./push-images.sh --username=myUserName --password=myPassword
# Production Usage: ./push-images.sh --username=myUserName --password=myPassword --production=true

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== push-images.sh script ===="
while [ $# -gt 0 ]; do
  case "$1" in
    --username=*)
      username="${1#*=}"
      ;;
    --password=*)
      password="${1#*=}"
      ;;
    --production=*)
      production="${1#*=}"
      ;;
    *)
      printf "* Error: Invalid argument.*\n"
      exit 1
  esac
  shift
done

echo $(date -u) "Logging into PBBG.com Docker Hub"
echo $password | docker login -u $username --password-stdin

if [ -n "$production" ]; then
  echo $(date -u) "${CYAN}Pushing production images to PBBG.com Docker Hub${NC}"
  docker-compose -f docker-compose.build-for-prod.yml push
else
  echo $(date -u) "${YELLOW}Pushing development images to PBBG.com Docker Hub${NC}"
  docker-compose push
fi

echo $(date -u) "${GREEN}Successfully pushed images to Docker Hub.${NC}"
