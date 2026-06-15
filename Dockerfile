# telechargement de l'image PHP officielle avec FPM pour exécuter le code backend
FROM php:8.2-fpm

# mise à jour des dépôts et installation des outils système, de nginx et des extensions PHP (PDO MySQL et zip)
RUN apt-get update && apt-get install -y \
    git curl zip unzip libzip-dev nginx \
    && docker-php-ext-install pdo pdo_mysql zip
    
# installation via PECL et activation de l'extension pour la base de données MongoDB
RUN pecl install mongodb && docker-php-ext-enable mongodb

# importation de Composer depuis son image officielle pour gérer les dépendances PHP
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# mkdir /var/www/html && cd
WORKDIR /var/www/html

# Copier le reste du code source du projet dans le conteneur
COPY . .

# installation des dépendances PHP avec Composer optimisées pour la production
RUN composer install --no-dev --optimize-autoloader --no-scripts \
    --ignore-platform-req=ext-mongodb

# importation de notre configuration nginx à la place de celle par defaut
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# j'ecoute sur le port 80
EXPOSE 80

# demarrer le serveur nginx et le processus php-fpm
CMD service nginx start && php-fpm
