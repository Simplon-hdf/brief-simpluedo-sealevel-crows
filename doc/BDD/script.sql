/* Étapes pour créer la DATABASE pour Simpluedo */

/* Création de la base de données */
CREATE DATABASE simpluedo_db;

/* Création d'un utilisateur PostgreSQL pour la base de données */
CREATE USER simpluedo_user;

/* Renommage de l'utilisateur en simpluedo_admin */
ALTER USER simpluedo_user RENAME TO simpluedo_admin;

/* Définition d'un mot de passe pour simpluedo_admin */
ALTER USER simpluedo_admin WITH PASSWORD 'admin';

/* Création de la table "utilisateurs" avec un UUID unique comme clé primaire */
CREATE TABLE utilisateurs(
    uuid_utilisateurs UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    pesudo_utilisateurs VARCHAR(50) NOT NULL                     
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
    PRIMARY KEY (id_personnages, id_salles),                    
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

/* Accorder des droits d'insertion, de modification et de suppression à simpluedo_admin sur toutes les tables */
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO simpluedo_admin;
