#!/bin/sh
set -e
# This script updates the docker-compose.yml for the docker stack in Portainer
# Using a docker container from:  https://hub.docker.com/r/greenled/portainer-stack-utils/
# Development Usage: ./update-portainer-stack.sh --portainer_username=myUserName --portainer_password=myPassword
# Production Usage: ./update-portainer-stack.sh --portainer_username=myUserName --portainer_password=myPassword --production=true

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== update-portainer-stack.sh script ===="
while [ $# -gt 0 ]; do
  case "$1" in
    --portainer_username=*)
      portainer_username="${1#*=}"
      ;;
    --portainer_password=*)
      portainer_password="${1#*=}"
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

if [ -n "$production" ]; then
  COMPOSE_FILE='docker-compose.production.yml'
  URL="http://143.110.157.206:9000"
  STACK_NAME='pbbgproduction'
  OUTPUT_COLOR=${CYAN}
else
  COMPOSE_FILE='docker-compose.development.yml'
  URL="http://143.110.157.206:9000"
  STACK_NAME='pbbgdevelopment'
  OUTPUT_COLOR=${YELLOW}
fi

echo $(date -u) "Removing ${OUTPUT_COLOR}${STACK_NAME}${NC} Portainer stack via API..."
docker run -e ACTION="undeploy" -e PORTAINER_USER=${portainer_username} -e PORTAINER_PASSWORD=${portainer_password} -e PORTAINER_URL=${URL} -e PORTAINER_STACK_NAME=${STACK_NAME} greenled/portainer-stack-utils psu
echo $(date -u) "${GREEN}Successfully removed ${OUTPUT_COLOR}${STACK_NAME}${NC}${GREEN} stack.${NC}"

echo $(date -u) "Creating ${OUTPUT_COLOR}${STACK_NAME}${NC} Portainer stack via API..."
docker run -v $(pwd)/${COMPOSE_FILE}:/${COMPOSE_FILE} -e ACTION="deploy" -e PORTAINER_USER=${portainer_username} -e PORTAINER_PASSWORD=${portainer_password} -e PORTAINER_URL=${URL} -e PORTAINER_STACK_NAME=${STACK_NAME} -e DOCKER_COMPOSE_FILE=${COMPOSE_FILE} greenled/portainer-stack-utils psu
echo $(date -u) "${GREEN}Successfully created ${OUTPUT_COLOR}${STACK_NAME}${NC}${GREEN} stack.${NC}"
