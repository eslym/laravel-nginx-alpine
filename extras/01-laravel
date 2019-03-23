#!/bin/sh
cd /var/www/html

composer install --no-interaction --no-suggest

if [ "${LARAVEL_KEY_GENERATE}" = "true" ]; then
    if [ ! -f .env ]; then
	echo "Environment file not found, creating"
	cp .env.example .env
    fi
    php artisan key:generate
fi

if [ "${LARAVEL_MIGRATION}" = "true" ]; then
    if [ "LARAVEL_FORCE_MIGRATE" = "true" ]; then
	php artisan migrate --force
    else
	php artisan migrate
    fi
fi

if [ "${LARAVEL_LINK_STORAGE}" = "true" ]; then
    php artisan storage:link
fi

if [ "${LARAVEL_CACHE_ROUTE}" = "true" ]; then
    php artisan route:cache
fi

if [ "${LARAVEL_CACHE_CONFIG}" = "true" ]; then
    php artisan config:cache
fi

echo "Fixing file permissions..."
chown -R apache:apache /var/www/html

echo "Starting cron"
crond &