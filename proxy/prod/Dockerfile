FROM nginx:1.18.0-alpine

# Set working directory
WORKDIR /etc/nginx/conf.d

# Copy backend source into working directory
COPY . /etc/nginx/conf.d

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 80
EXPOSE 443
