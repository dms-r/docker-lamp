# Dockerfile
FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy custom vhost if needed (optional)

# Set working directory
WORKDIR /var/www/html

# RUN apt-get update && apt-get install -y \ # If need
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     && docker-php-ext-install gd mbstring curl
