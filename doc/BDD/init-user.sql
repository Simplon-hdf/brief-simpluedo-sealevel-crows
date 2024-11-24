/* Connexion à la BDD */
\c simpluedo_db

/* Définition d'un mot de passe pour simpluedo_admin */
CREATE USER simpluedo_admin WITH PASSWORD 'admin';

/* Accorder des droits d'insertion, de modification et de suppression à simpluedo_admin sur toutes les tables */
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;