FROM dunglas/frankenphp:1.5-php8.4-alpine

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apk add --no-cache \
    git~=2.47 \
    curl~=8.12 \
    libpng-dev~=1.6 \
    libxml2-dev~=2.13 \
    zip~=3.0 \
    unzip~=6.0 \
    oniguruma-dev~=6.9 \
    icu-dev~=74.2

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create Caddy configuration
RUN echo "{\n\tauto_https off\n}\n\n:80 {\n\troot * /var/www/html/public\n\tphp_server\n}" > /etc/caddy/Caddyfile

# Set permissions for Laravel
RUN mkdir -p /var/www/html/storage/logs \
    && mkdir -p /var/www/html/storage/framework/sessions \
    && mkdir -p /var/www/html/storage/framework/views \
    && mkdir -p /var/www/html/storage/framework/cache \
    && mkdir -p /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Switch to non-root user
USER www-data

# Expose ports
EXPOSE 80
EXPOSE 443

# Start FrankenPHP
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]