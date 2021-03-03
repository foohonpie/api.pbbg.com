#!/bin/sh
set -e
# This script installs Portainer as a standalone host in a DigitalOcean droplet
# Because it is standalone this creates the manager only (no agent)

# Initial password is bcrypt encrypted password 'admin' using one-time run of httpd:2.4-alpine container
password=docker run --rm httpd:2.4-alpine htpasswd -nbB admin "admin" | cut -d ":" -f 2

# Expose admin user interface on port 9000
docker volume create portainer_data
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce --admin-password=$password
