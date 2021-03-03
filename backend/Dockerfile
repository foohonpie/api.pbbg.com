FROM php:8.0.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy backend source into working directory
COPY . /var/www

# If you do not specify host of 0.0.0.0 then the default (localhost or 127.0.0.1) will
# NOT be accessible from within the docker network and all /backend/xxx requests will 502
CMD bash -c "composer update && composer install && php artisan serve --host=0.0.0.0 --port=8000"
