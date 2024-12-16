# Use PHP with Apache
FROM php:8.2-apache

# Install Node.js, Gulp, and required dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs git unzip libpng-dev libjpeg-dev libfreetype6-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy the app files into the container
COPY . /var/www/html

# Install Composer dependencies
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev

# Install Node.js dependencies
RUN npm install && npx gulp bundle

# Set permissions for Apache
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for Apache
EXPOSE 80

CMD ["apache2-foreground"]
