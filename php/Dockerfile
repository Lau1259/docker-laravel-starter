FROM php:8.4-fpm

# Instalar dependenciass
RUN apt-get update && apt-get install -y \
    zip unzip git curl libicu-dev libonig-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set workdir
WORKDIR /var/www/html

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["docker-entrypoint.sh"]

# Default command (this will be passed to the entrypoint)
CMD ["php-fpm"]

