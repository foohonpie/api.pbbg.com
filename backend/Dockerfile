FROM php:8.0.2-fpm

# Set working directory
WORKDIR /var/www

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

# Copy backend source into working directory
COPY . ./

RUN composer update \
    && composer install \
    && composer dump-autoload

# For documentation to developers - EXPOSE command doesn't actually do anything, but tells what should be made open
EXPOSE 8000

RUN chmod 755 /var/www/runAfterDatabaseConnects.sh
CMD bash -c 'while !</dev/tcp/database/3306; do sleep 5; done; ./runAfterDatabaseConnects.sh'
