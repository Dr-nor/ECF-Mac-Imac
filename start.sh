#!/bin/sh
composer install --no-dev --optimize-autoloader --no-scripts
php bin/console cache:clear --env=prod --no-debug
php bin/console cache:warmup --env=prod
php -S 0.0.0.0:8000 -t public/
