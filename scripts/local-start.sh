#!/bin/sh
set -e
# This script is a quick way to stop, rebuild, and restart the docker containers
# IMPORTANT: this does *NOT* use changes to any container Dockerfile.

docker-compose down
docker-compose build --parallel
docker-compose up -d
