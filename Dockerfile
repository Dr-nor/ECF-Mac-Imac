FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl zip unzip libzip-dev nginx \
    && docker-php-ext-install pdo pdo_mysql zip

RUN pecl install mongodb && docker-php-ext-enable mongodb

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader --no-scripts \
    --ignore-platform-req=ext-mongodb

COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN php bin/console cache:clear --env=prod --no-warmup || true

EXPOSE 80

CMD service nginx start && php-fpm