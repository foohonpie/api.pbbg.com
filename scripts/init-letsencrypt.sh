#!/bin/bash
set -e
# This script will create Let's Encrypt certs
# Usage: ./lets-encrypt.sh
#             --domains=dev.pbbg.com
#             --email_address=swctholmeso@gmail.com
#             --nginx_container=proxy
#             --certbot_container=certbot
#             --data_path="./proxy/dev/certbot"
#             --compose_override=docker-compose.yml

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

echo $(date -u) "==== lets-encrypt.sh script ===="
while [[ $# -gt 0 ]]; do
  case "$1" in
    --domains=*)
      domains="${1#*=}"
      ;;
    --email_address=*)
      email_address="${1#*=}"
      ;;
    --nginx_container=*)
      nginx_container="${1#*=}"
      ;;
    --certbot_container=*)
      certbot_container="${1#*=}"
      ;;
    --data_path=*)
      data_path="${1#*=}"
      ;;
    --compose_override=*)
      compose_override="${1#*=}"
      ;;
    *)
      printf "* Error: Invalid argument.*\n"
      exit 1
  esac
  shift
done

rsa_key_size=4096

if [[ -d "${data_path}" ]]; then
  echo -e $(date -u) "${YELLOW}Existing data found for ${domains}. Assuming it is valid and exiting.${NC}"
  echo -e $(date -u) "${YELLOW}If you need to recreate SSL Certs anyway then delete the contents of ${NC}: ${data_path} ${YELLOW} and then re-run this script.${NC}"
  exit
fi

if [[ ! -e "${data_path}/conf/options-ssl-nginx.conf" ]] || [[ ! -e "${data_path}/conf/ssl-dhparams.pem" ]]; then
  echo -e $(date -u) "Downloading recommended TLS parameters ..."
  mkdir -p "${data_path}/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "${data_path}/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "${data_path}/conf/ssl-dhparams.pem"
  echo
fi


echo -e $(date -u) "Creating dummy certificate for ${domains} ..."
path="/etc/letsencrypt/live/${domains}"
mkdir -p "${data_path}/conf/live/${domains}"
docker-compose -f ${compose_override} run --rm --entrypoint "\
  openssl req -x509 -nodes -newkey rsa:${rsa_key_size} -days 1\
    -keyout '${path}/privkey.pem' \
    -out '${path}/fullchain.pem' \
    -subj '/CN=localhost'" ${certbot_container}
echo


echo -e $(date -u) "Starting nginx ..."
docker-compose -f ${compose_override} up --force-recreate -d ${nginx_container}
echo


echo -e $(date -u) "Deleting dummy certificate for ${domains} ..."
docker-compose -f ${compose_override} run --rm --entrypoint "\
  rm -Rf /etc/letsencrypt/live/${domains} && \
  rm -Rf /etc/letsencrypt/archive/${domains} && \
  rm -Rf /etc/letsencrypt/renewal/${domains}.conf" ${certbot_container}
echo


echo -e $(date -u) "Requesting Let's Encrypt certificate for ${domains} ..."
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="${domain_args} -d ${domain}"
done
docker-compose -f ${compose_override} run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    --email ${email_address} \
    ${domain_args} \
    --rsa-key-size ${rsa_key_size} \
    --agree-tos \
    --force-renewal" ${certbot_container}
echo


echo -e $(date -u) "Reloading nginx ..."
docker-compose -f ${compose_override} exec ${nginx_container} nginx -s reload
echo -e $(date -u) "${GREEN}Successfully created SSL certificate for ${domains}!${NC}"
