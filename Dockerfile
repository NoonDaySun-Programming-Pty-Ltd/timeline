FROM dunglas/frankenphp:1.9.0-php8.4.11-alpine

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apk add --no-cache \
    git~=2.49 \
    curl~=8.14 \
    libpng-dev~=1.6 \
    libxml2-dev~=2.13 \
    zip~=3.0 \
    unzip~=6.0 \
    oniguruma-dev~=6.9 \
    icu-dev~=76.1

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
COPY . .
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=node:22.19.0-alpine3.22 /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22.19.0-alpine3.22 /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY resources/js/ ./resources/js/
COPY resources/css/ ./resources/css/
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    npm ci && \
    npm run build

USER www-data

# Start FrankenPHP
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]