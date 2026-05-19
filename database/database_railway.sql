
-- TABLE USER
CREATE TABLE user (
  id       INT AUTO_INCREMENT PRIMARY KEY,
  email    VARCHAR(180) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  nom      VARCHAR(100) NOT NULL,
  prenom   VARCHAR(100) NOT NULL,
  actif    TINYINT DEFAULT 1,
  role_id  INT DEFAULT 2
);

-- TABLE MENU
CREATE TABLE menu (
  id                      INT AUTO_INCREMENT PRIMARY KEY,
  titre                   VARCHAR(100) NOT NULL,
  description             LONGTEXT,
  nombre_personne_minimum INT NOT NULL,
  prix                    DECIMAL(10,2) NOT NULL,
  quantite_restante       INT DEFAULT 10,
  theme                   VARCHAR(50) DEFAULT 'classique',
  regime                  VARCHAR(50) DEFAULT 'classique'
);

-- TABLE PLAT
CREATE TABLE plat (
  id      INT AUTO_INCREMENT PRIMARY KEY,
  nom     VARCHAR(100) NOT NULL,
  type    VARCHAR(50) NOT NULL,
  photo   VARCHAR(255),
  menu_id INT NOT NULL,
  FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE CASCADE
);

-- TABLE COMMANDE
CREATE TABLE commande (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  numero_commande   VARCHAR(50) NOT NULL UNIQUE,
  date_commande     DATETIME NOT NULL,
  date_prestation   DATE NOT NULL,
  adresse_livraison VARCHAR(255) NOT NULL,
  nombre_personnes  INT NOT NULL,
  prix_total        DECIMAL(10,2) NOT NULL,
  statut            VARCHAR(20) DEFAULT 'en_attente',
  user_id           INT NOT NULL,
  menu_id           INT NOT NULL,
  FOREIGN KEY (user_id)  REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (menu_id)  REFERENCES menu(id) ON DELETE CASCADE
);

-- TABLE HORAIRE
CREATE TABLE horaire (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  jour       VARCHAR(20) NOT NULL,
  heure_ouv  TIME NOT NULL,
  heure_ferm TIME NOT NULL,
  ferme      TINYINT DEFAULT 0
);