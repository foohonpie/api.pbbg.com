#!/bin/sh
set -e
#
#
#   DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                            DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                                            DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                    DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#     DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                               DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
# DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                 DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#
#                                 DO NOT RUN THIS ON YOUR DEVELOPMENT MACHINE
#

# This script adds all necessary configuration for running PBBG.com on a Digital Ocean droplet
# IMPORTANT - invoke this script from inside the /scripts/digitalocean/ directory
#
# PARAM username : the username of the to-be-created superuser
# PARAM password : the password of the to-be-created superuser
#
# Production Usage: ./initialize.sh --username=myUsername --password=myPassword

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== digital-ocean-initialize.sh script ===="

while [ $# -gt 0 ]; do
  case "$1" in
    --username=*)
      username="${1#*=}"
      ;;
    --password=*)
      password="${1#*=}"
      ;;
    *)
      printf "* Error: Invalid argument.*\n"
      exit 1
  esac
  shift
done

chmod 755 ./create-build-user.sh  && ./create-build-user.sh --username=${username} --password=${password}
chmod 755 ./setup-firewall-rules.sh && ./setup-firewall-rules.sh
chmod 755 ./setup-docker.sh  && ./setup-docker.sh
chmod 755 ./add-user-to-docker-group.sh && ./add-user-to-docker-group.sh --username=${username}
chmod 755 ./install-portainer.sh  && ./install-portainer.sh

echo $(date -u) "${GREEN}Server initialization script complete!${NC}"
