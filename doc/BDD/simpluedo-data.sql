-- Pour se connecter à la DB avec l'utilisateur 
-- pgcli -U simpluedo_admin -p 5433 -d simpluedo_db

/* Insertion de données dans la table rôles */
INSERT INTO roles (nom_roles) VALUES
 ('observateur'),
 ('utilisateur'),
 ('maitre du jeu');

/* Insertion de données dans la table personnages */
INSERT INTO personnages (nom_personnages) VALUES
('Colonel Moutarde'),
('Docteur OLIVE'),
('Professeur VIOLET'),
('Madame PERVENCHE'),
('Mademoiselle ROSE'),
('Madame LEBLANC');

/* Insertion de données dans la table salles */
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

/* Insertion de données dans la table objets */
INSERT INTO objets (nom_objets, id_salles) VALUES
('Poignard', 4),
('Revolver', 6),
('Chandelier', 5),
('Corde', 4),
('Clé anglaise', 8),
('Matraque', 8);

/* Insertion de données dans la table utilisateurs */
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles, id_personnages) VALUES
('MessaKami', 9, 1),
('GETAMAZIGHT', 8, 3),
('Srekaens', 8, 2),
('Kuro', 8, 5),
('Shotax', 8, 6),
('Jegoro', 8, 4),

/* Insertion de données dans la table utilisateurs */
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles) VALUES
('Martial', 10),
('Aurore', 10),
('Julien', 10),
('Boris', 10),
('Gabriel', 10),
('Yohan', 10),
('Franck', 10);
