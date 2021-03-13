FROM nginx:1.18.0-alpine

# Set working directory
WORKDIR /etc/nginx/conf.d

# Copy backend source into working directory
COPY . /etc/nginx/conf.d

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 80
EXPOSE 443

# Check every 6 hours for a new Let's Encrypt cert and auto-renew
CMD [ "/bin/sh", "-c", "while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"" ]
