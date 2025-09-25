FROM composer:2.8.12 AS composer-deps
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-interaction


FROM dunglas/frankenphp:1.9.0-php8.4.11-alpine

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apk add --no-cache \
    curl~=8.14 \
    git~=2.49 \
    icu-dev~=76.1 \
    libpng-dev~=1.6 \
    libxml2-dev~=2.13 \
    oniguruma-dev~=6.9 \
    postgresql17-client~=17.6 \
    unzip~=6.0 \
    zip~=3.0

# Install PHP extensions
RUN apk add --no-cache --upgrade --virtual .build-deps \
        postgresql17-dev~=17.6 \
    && docker-php-ext-install \
    bcmath \
    exif \
    gd \
    intl \
    mbstring \
    pcntl \
    pdo_pgsql \
    && apk del -f .build-deps

# Install Composer
COPY --from=composer-deps /app/vendor ./vendor
COPY . .
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=node:22.19.0-alpine3.22 /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22.19.0-alpine3.22 /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY resources/js/ ./resources/js/
COPY resources/css/ ./resources/css/
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    if [ -f ./package-lock.json ]; then npm ci; else npm i; fi && \
    npm run build

# Start FrankenPHP
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
