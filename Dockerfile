# Use an official PHP image as the base
FROM php:8.2-apache

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html

# Install PHP dependencies via Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev

# Install Node.js dependencies and build assets
RUN npm install --production

# Set permissions for Apache
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]







# # Use an official PHP image as the base
# FROM php:8.2-apache

# # Install required packages
# RUN apt-get update && \
#     apt-get install -y \
#     git \
#     unzip \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install gd \
#     && docker-php-ext-install mysqli

# # Enable Apache mod_rewrite
# RUN a2enmod rewrite

# # Install Node.js and npm
# RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
#     apt-get install -y nodejs

# # Set working directory
# WORKDIR /var/www/html

# # Copy application files
# COPY . /var/www/html

# # Install PHP dependencies via Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# RUN composer install

# # Install Node.js dependencies and build assets
# RUN npm install


# # Set permissions for Apache
# RUN chown -R www-data:www-data /var/www/html

# # Expose port 80
# EXPOSE 80

# # Start Apache server
# CMD ["apache2-foreground"]
