FROM mysql:8.0.23

# Install system dependencies
RUN apt-get update \
    && apt-get install -y curl

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 3306
