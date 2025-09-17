#!/bin/bash

# Check if Laravel is already installed; if not, install it
if [ ! -d "/var/www/html/vendor" ]; then
    # Install Laravel via Composer if not already installed
    composer create-project --prefer-dist laravel/laravel .
    cp .env.example .env

    # Configure .env for MySQL
    sed -i "s/DB_CONNECTION=sqlite/DB_CONNECTION=mysql/" .env
    sed -i "s/# DB_HOST=127.0.0.1/DB_HOST=${DB_HOST}/" .env
    sed -i "s/# DB_PORT=3306/DB_PORT=${DB_PORT}/" .env
    sed -i "s/# DB_DATABASE=laravel/DB_DATABASE=${DB_DATABASE}/" .env
    sed -i "s/# DB_USERNAME=root/DB_USERNAME=${DB_USERNAME}/" .env
    sed -i "s/# DB_PASSWORD=/DB_PASSWORD=${DB_PASSWORD}/" .env

    # Install Laravel dependencies
    composer install

    # Generate the Laravel app key
    php artisan key:generate

    # Run migrations
    php artisan migrate --force

    # Set appropriate permissions for storage and cache directories
    chmod -R 777 storage bootstrap/cache

fi

# Execute the passed command (like `php artisan serve`)
exec "$@"

