INSERT INTO menu (titre, description, nombre_personne_minimum, prix, quantite_restante, theme, regime) VALUES
('Menu Noel Prestige',   'Foie gras, dinde rotie, buche maison',        8,  45.00, 10, 'noel',      'classique'),
('Menu Mariage',         'Cocktail dinatoire, 3 plats, dessert buffet', 20,  55.00,  5, 'evenement', 'classique'),
('Menu Vegetarien',      '100% vegetarien, produits locaux bio',         4,  28.00, 15, 'classique', 'vegetarien'),
('Menu Paques',          'Agneau roti, gratin dauphinois, charlotte',    6,  38.00,  8, 'paques',    'classique'),
('Menu Entreprise',      'Repas affaires, 3 services, cafe inclus',     10,  65.00,  6, 'corporate', 'classique');

-- PLATS
INSERT INTO plat (nom, type, menu_id) VALUES
('Foie gras mi-cuit',      'entree',  1),
('Dinde rotie farcie',     'plat',    1),
('Buche chocolat maison',  'dessert', 1),
('Veloute de legumes',     'entree',  3),
('Risotto aux champignons','plat',    3);

-- HORAIRES
INSERT INTO horaire (jour, heure_ouv, heure_ferm, ferme) VALUES
('Lundi',    '09:00', '19:00', 0),
('Mardi',    '09:00', '19:00', 0),
('Mercredi', '09:00', '19:00', 0),
('Jeudi',    '09:00', '19:00', 0),
('Vendredi', '09:00', '19:00', 0),
('Samedi',   '10:00', '17:00', 0),
('Dimanche', '00:00', '00:00', 1);

-- COMMANDES
INSERT INTO commande (numero_commande, date_commande, date_prestation, adresse_livraison, nombre_personnes, prix_total, statut, user_id, menu_id) VALUES
('CMD-001', '2026-04-01 10:00:00', '2026-04-15', '12 rue des Fleurs Bordeaux',  5, 202.50, 'confirmee', 3, 1),
('CMD-002', '2026-04-05 14:00:00', '2026-04-20', '8 avenue du Parc Bordeaux',   3,  84.00, 'en_attente',4, 3),
('CMD-003', '2026-04-10 09:00:00', '2026-05-01', '25 rue Victor Hugo Bordeaux', 6, 228.00, 'livree',    5, 4);