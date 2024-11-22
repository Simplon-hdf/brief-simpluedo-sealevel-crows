-- Pour se connecter à la DB avec l'utilisateur 
-- pgcli -U simpluedo_admin -p 5433 -d simpluedo_db

\c simpluedo_db

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
('MessaKami', 3, 1),
('GETAMAZIGHT', 2, 3),
('Srekaens', 2, 2),
('Kuro', 2, 5),
('Shotax', 2, 6),
('Jegoro', 2, 4);

/* Insertion de données dans la table utilisateurs */
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles) VALUES
('Martial', 1),
('Aurore', 1),
('Julien', 1),
('Boris', 1),
('Gabriel', 1),
('Yohan', 1),
('Franck', 1);
