#!/bin/sh
composer install --no-dev --optimize-autoloader --no-scripts
php -S 0.0.0.0:8000 -t public/
