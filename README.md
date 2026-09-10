# Vite & Gourmand

Application web pour le traiteur événementiel Julie & José à Bordeaux. Cette application permet aux clients de consulter les menus, passer des commandes, et aux administrateurs de gérer le catalogue et suivre les statistiques.

## Environnement de développement

### Pré-requis
- PHP 8.2
- Composer
- Docker & Docker Compose
- Git

### Exécution du projet en local

**1. Cloner le repo :**
```bash
git clone git@github.com:Dr-nor/ECF-Mac-Imac.git
cd ECF-Mac-Imac
```

**2. Démarrer les conteneurs Docker :**
```bash
docker compose up -d
```

**3. Installer les dépendances :**
```bash
docker exec vite-et-gourmand-php-1 composer install
```

**4. Importer la base de données :**
```bash
docker exec -i vite-et-gourmand-mariadb-1 mysql -u root -proot vite_gourmand < database/database.sql
docker exec -i vite-et-gourmand-mariadb-1 mysql -u root -proot vite_gourmand < database/jeudedonnees.sql
```

**5. Accéder à l'application :**
- Application : http://localhost:8080
- phpMyAdmin : http://localhost:8081

### Données de connexion par défaut
- Email : `admin@vite-gourmand.fr`
- Password : `Password`

## Schéma base de données
Les fichiers SQL se trouvent dans le dossier `/database` :
- `database.sql` — Structure des tables
- `jeudedonnees.sql` — Données de test

## Liens
- 🔗 Dépôt GitHub : https://github.com/Dr-nor/ECF-Mac-Imac
- 🌐 Application en production : https://ecf-mac-imac-production.up.railway.app
