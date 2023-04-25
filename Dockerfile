FROM php:8.2-alpine3.16

# Arguments from docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apk update && apk add \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    shadow \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home /home/$user \
    --ingroup www-data \
    -u $uid \
    $user
RUN mkdir -p /home/$user/.composer
RUN chown -R www-data:www-data /home/$user && \
    chown -R www-data:www-data /var/www

# Set working directory
WORKDIR /var/www

USER $user
