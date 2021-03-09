#!/bin/bash
set -e
# This bash script creates a docker stack according to the docker-compose configuration
# Development Usage: ./create-stack.sh --databasename=someString --rootpassword=someString --username=someString
## Production Usage: ./create-stack.sh --databasename=someString --rootpassword=someString --username=someString --production=true



GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
NC="\033[0m"  # No Color

echo $(date -u) "==== create-stack.sh script ===="
while [[ $# -gt 0 ]]; do
  case "$1" in
    --databasename=*)
      databasename="${1#*=}"
      ;;
    --rootpassword=*)
      rootpassword="${1#*=}"
      ;;
    --username=*)
      username="${1#*=}"
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

echo -e $(date -u) "Setting environment variables..."
export MYSQL_DATABASE=${databasename}
export MYSQL_ROOT_PASSWORD=${rootpassword}
export MYSQL_PASSWORD=${rootpassword}
export MYSQL_USER=${username}

if [[ -n "$production" ]]; then
  echo -e $(date -u) "Creating ${CYAN}pbbg_production${NC} stack..."
  docker stack deploy -c <(docker-compose -f production-stack.yml config) pbbg_production
else
  echo -e $(date -u) "Creating ${YELLOW}pbbg_development${NC} stack..."
  docker stack deploy -c <(docker-compose -f development-stack.yml config) pbbg_development
fi

echo -e $(date -u) "Unsetting environment variables..."
export MYSQL_DATABASE=
export MYSQL_ROOT_PASSWORD=
export MYSQL_PASSWORD=
export MYSQL_USER=

echo -e $(date -u) "${GREEN}Successfully created stack!${NC}"
