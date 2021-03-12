FROM nginx:1.18.0-alpine

RUN apk add openssl;

# Set working directory
WORKDIR /etc/nginx/conf.d

RUN openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
# Expected Output
# Generating a RSA private key
# .......................................+++++
# ....+++++
# writing new private key to '/etc/ssl/private/nginx-selfsigned.key'
# -----

# Copy backend source into working directory
COPY . /etc/nginx/conf.d

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 80
EXPOSE 443
