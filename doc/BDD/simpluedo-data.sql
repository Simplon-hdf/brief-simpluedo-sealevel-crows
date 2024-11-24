-- Connexion à la BDD
\c simpluedo_db

-- Insertion de données dans la table "roles"
INSERT INTO roles (nom_roles) VALUES
 ('observateur'),
 ('utilisateur'),
 ('maitre du jeu');

-- Insertion de données dans la table "personnages"
INSERT INTO personnages (nom_personnages) VALUES
('Colonel Moutarde'),
('Docteur Olive'),
('Professeur Violet'),
('Madame Pervenche'),
('Mademoiselle Rose'),
('Madame Leblanc');

-- Insertion de données dans la table "utilisateurs" avec personnages associés
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles, id_personnages) VALUES
('MessaKami', 3, 1),
('GETAMAZIGHT', 2, 3),
('Srekaens', 2, 2),
('Kuro', 2, 5),
('Shotax', 2, 6),
('Jegoro', 2, 4);

-- Insertion de données dans la table "utilisateurs" sans personnages
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles) VALUES
('Martial', 1),
('Aurore', 1),
('Julien', 1),
('Boris', 1),
('Gabriel', 1),
('Yohan', 1),
('Franck', 1);

-- Insertion de données dans la table "salles"
INSERT INTO salles (nom_salles) VALUES
('Cuisine'),
('Grand Salon'),
('Petit Salon'),
('Bureau'),
('Bibliothèque'),
('Studio'),
('Hall'),
('Véranda'),
('Salle à manger');

-- Insertion de données dans la table "objets"
INSERT INTO objets (nom_objets, id_salles) VALUES
('Poignard', 4),
('Revolver', 6),
('Chandelier', 5),
('Corde', 4),
('Clé anglaise', 8),
('Matraque', 8);

-- Insertion de données dans la table "visiter"
INSERT INTO visiter (id_personnages, id_salles, heure_arrivee, heure_sortie) VALUES
(1, 1, '08:00', '08:30'),  
(2, 4, '08:15', '08:45'),
(3, 5, '08:30', '09:00'), 
(4, 1, '08:20', '08:50'),
(5, 3, '09:00', '09:30'), 
(6, 6, '09:15', '09:45');
