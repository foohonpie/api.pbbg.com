#!/bin/sh
set -e
# this script allows the backend container to startup but wait to run migrations until the Database is available
# Usage: ./runAfterDatabaseConnects.sh

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== runAfterDatabaseConnects.sh script ===="

echo $(date -u) "Running migrations ..."
php artisan migrate --force
echo $(date -u) "Finished running database migrations."

# If you do not specify host of 0.0.0.0 then the default (localhost or 127.0.0.1) will
# NOT be accessible from within the docker network and all /backend/xxx requests will 502
echo $(date -u) "Starting backend web server ..."
php artisan serve --host=0.0.0.0 --port=8000
echo $(date -u) "${GREEN}Backend running on internal container port 8000.${NC}"
