FROM nginx:1.18.0-alpine

RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev certbot certbot-nginx

# Set working directory
WORKDIR /etc/nginx/conf.d

# Copy backend source into working directory
COPY . /etc/nginx/conf.d

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 80
EXPOSE 443
