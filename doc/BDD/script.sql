/* Étapes pour créer la DATABASE pour Simpluedo */
\c postgres

/* Supprimer le base de données si elel existe déjà pour éviter une erreur pour le script */
DROP DATABASE IF EXISTS simpluedo_db;

/* Création de la base de données */
CREATE DATABASE simpluedo_db;

/* Connection à la database */
\c simpluedo_db

/* Supprimer les tables si elles existent déjà */
DROP TABLE IF EXISTS utilisateurs CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS personnages CASCADE;
DROP TABLE IF EXISTS salles CASCADE;
DROP TABLE IF EXISTS objets CASCADE;
DROP TABLE IF EXISTS visiter CASCADE;

/* Création de la table "utilisateurs" avec un UUID unique comme clé primaire */
CREATE TABLE utilisateurs(
    uuid_utilisateurs UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    pseudo_utilisateurs VARCHAR(50) NOT NULL                     
);

/* Création de la table "roles" pour gérer les rôles des utilisateurs */
CREATE TABLE roles(
    id_roles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    nom_roles VARCHAR(50) NOT NULL                            
);

/* Création de la table "personnages" pour stocker les personnages du jeu */
CREATE TABLE personnages(
    id_personnages INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    nom_personnages VARCHAR(50) NOT NULL                            
);

/* Création de la table "salles" pour stocker les salles du jeu */
CREATE TABLE salles(
    id_salles INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    nom_salles VARCHAR(50) NOT NULL                            
);

/* Création de la table "objets" pour stocker les objets du jeu */
CREATE TABLE objets(
    id_objets INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    nom_objets VARCHAR(50) NOT NULL                           
);

/* Création de la table "visiter" pour gérer les visites des personnages dans les salles */
CREATE TABLE visiter(
    id_personnages INTEGER,                                    
    id_salles INTEGER,                                          
    heure_arrivee TIME,                                         
    heure_sortie TIME,                                          
    PRIMARY KEY (id_personnages, id_salles, heure_arrivee),                    
    FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages), 
    FOREIGN KEY (id_salles) REFERENCES salles(id_salles)        
);

/* Ajout d'une colonne pour associer les utilisateurs aux rôles */
ALTER TABLE utilisateurs ADD COLUMN id_roles INTEGER,
ADD CONSTRAINT utilisateurs_id_roles_fkey
FOREIGN KEY (id_roles) REFERENCES roles(id_roles);

/* Ajout d'une colonne pour associer les utilisateurs aux personnages */
ALTER TABLE utilisateurs ADD COLUMN id_personnages INTEGER,
ADD CONSTRAINT utilisateurs_id_personnages_fkey
FOREIGN KEY (id_personnages) REFERENCES personnages(id_personnages);

/* Ajout d'une colonne pour associer les objets aux salles */
ALTER TABLE objets ADD COLUMN id_salles INTEGER,
ADD CONSTRAINT objets_id_salles_fkey
FOREIGN KEY (id_salles) REFERENCES salles(id_salles); 


