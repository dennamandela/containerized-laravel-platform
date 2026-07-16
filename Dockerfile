# ============================================
# Stage 1 - Build Dependencies
# ============================================
FROM composer:2 AS builder

WORKDIR /app

# Copy Composer manifest first (better cache utilization)
COPY composer.json composer.lock ./

# Install dependencies without dev packages
RUN composer install \
    --no-dev \
    --prefer-dist \
    --no-interaction \
    --optimize-autoloader

# Copy application source
COPY . .

# Optimize Laravel
RUN php artisan package:discover --ansi || true \
    && php artisan optimize || true


# ============================================
# Stage 2 - Production Runtime
# ============================================
FROM php:8.2-fpm

WORKDIR /var/www/html

# Install only runtime dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libpq-dev \
    unzip \
    tzdata \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        zip \
        bcmath \
        pdo_mysql \
        pdo_pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Timezone
ENV TZ=UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Copy application from builder
COPY --from=builder /app .

# Storage permissions
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Run as non-root user
USER www-data

# Healthcheck
HEALTHCHECK --interval=30s \
            --timeout=10s \
            --start-period=30s \
            --retries=3 \
CMD php-fpm -t || exit 1

EXPOSE 9000

CMD ["php-fpm"]