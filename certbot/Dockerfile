FROM certbot/certbot

# Check if cert is expired every 12 hours, per Let's Encrypt's recommendation
ENTRYPOINT [ "/bin/sh", "-c", "trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;" ]
