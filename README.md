---

# Base de Données Simpluedo

Ce projet contient toutes les requêtes SQL nécessaires pour créer et manipuler la base de données **Simpluedo**. Ce fichier est structuré en plusieurs sections pour faciliter la compréhension.

---

## Sommaire

- [Structure de la Base de Données](#structure-de-la-base-de-données)
  - [1. Création des Tables](#1-création-des-tables)
  - [2. Insertion des Données](#2-insertion-des-données)
- [Triggers](#triggers)
  - [Mise à Jour de la Position des Personnages](#mise-à-jour-de-la-position-des-personnages)
- [Procédures Stockées](#procédures-stockées)
  - [1. Lister les Objets d'une Salle](#1-lister-les-objets-dune-salle)
  - [2. Ajouter un Objet dans une Salle](#2-ajouter-un-objet-dans-une-salle)
- [Requêtes Demandées](#requêtes-demandées)
  - [1. Lister tous les Personnages du Jeu](#1-lister-tous-les-personnages-du-jeu)
  - [2. Lister chaque Joueur et son Personnage Associé](#2-lister-chaque-joueur-et-son-personnage-associé)
  - [3. Afficher les Personnages dans une Salle à une Heure Donnée](#3-afficher-les-personnages-dans-une-salle-à-une-heure-donnée)
  - [4. Afficher les Pièces non Visitées](#4-afficher-les-pièces-non-visitées)
  - [5. Compter les Objets par Pièce](#5-compter-les-objets-par-pièce)
  - [6. Ajouter une Pièce](#6-ajouter-une-pièce)
  - [7. Modifier un Objet](#7-modifier-un-objet)
  - [8. Supprimer une Pièce](#8-supprimer-une-pièce)
- [Sauvegarder la Base de Données](#sauvegarder-la-base-de-données)

---

## Structure de la Base de Données

### 1. Création des Tables

Le script suivant crée la base de données et toutes les tables nécessaires au fonctionnement du jeu Simpluedo.

```sql
/* Étapes pour créer la DATABASE pour Simpluedo */

/* Connexion sur la postgres */
\c postgres

/* Supprimer la base de données si elle existe déjà pour éviter une erreur pour le script */
DROP DATABASE IF EXISTS simpluedo_db;

/* Création de la base de données */
CREATE DATABASE simpluedo_db;

/* Connexion à la database */
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

/* Création de la table position */
CREATE TABLE position (
    id_personnages INTEGER NOT NULL,
    id_salles INTEGER NOT NULL,
    heure_arrivee TIME NOT NULL,
    PRIMARY KEY (id_personnages),
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
```

### 2. Insertion des Données

Le script suivant insère les données initiales dans les tables précédemment créées.

```sql
-- Pour se connecter à la DB avec l'utilisateur 
-- pgcli -U simpluedo_admin -p 5433 -d simpluedo_db

/* Connexion à la BDD */
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

/* Insertion de données dans la table utilisateurs avec personnages associés */
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles, id_personnages) VALUES
('MessaKami', 3, 1),
('GETAMAZIGHT', 2, 3),
('Srekaens', 2, 2),
('Kuro', 2, 5),
('Shotax', 2, 6),
('Jegoro', 2, 4);

/* Insertion de données dans la table utilisateurs sans personnages */
INSERT INTO utilisateurs (pseudo_utilisateurs, id_roles) VALUES
('Martial', 1),
('Aurore', 1),
('Julien', 1),
('Boris', 1),
('Gabriel', 1),
('Yohan', 1),
('Franck', 1);

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

/* Insertion de données dans la table visiter avec heures d'arrivée et de sortie */
INSERT INTO visiter (id_personnages, id_salles, heure_arrivee, heure_sortie) VALUES
(1, 1, '08:00', '08:30'),  -- Colonel Moutarde visite la Cuisine de 08:00 à 08:30
(2, 4, '08:15', '08:45'),  -- Docteur OLIVE visite le Bureau de 08:15 à 08:45
(3, 5, '08:30', '09:00'),  -- Professeur VIOLET visite la Bibliothèque de 08:30 à 09:00
(4, 1, '08:20', '08:50'),  -- Madame PERVENCHE visite la Cuisine de 08:20 à 08:50
(5, 3, '09:00', '09:30'),  -- Mademoiselle ROSE visite le Petit Salon de 09:00 à 09:30
(6, 6, '09:15', '09:45');  -- Madame LEBLANC visite le Studio de 09:15 à 09:45
```

---

## Triggers

### Mise à Jour de la Position des Personnages

Le trigger ci-dessous met automatiquement à jour la position d'un personnage lorsqu'il visite une salle.

```sql
/* Création de la fonction du trigger */
CREATE OR REPLACE FUNCTION maj_position_trigger()
RETURNS TRIGGER AS $$
BEGIN
    -- Complète l'heure de sortie dans visiter
    UPDATE visiter
    SET heure_sortie = NEW.heure_arrivee
    WHERE id_personnages = NEW.id_personnages
      AND heure_sortie IS NULL
      AND heure_arrivee < NEW.heure_arrivee;

    -- Met à jour ou insère dans position
    INSERT INTO position (id_personnages, id_salles, heure_arrivee)
    VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee)
    ON CONFLICT (id_personnages)
    DO UPDATE SET id_salles = EXCLUDED.id_salles, heure_arrivee = EXCLUDED.heure_arrivee;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* Création du trigger */
CREATE TRIGGER trigger_maj_position
AFTER INSERT OR UPDATE ON visiter
FOR EACH ROW
EXECUTE FUNCTION maj_position_trigger();
```

---

## Procédures Stockées

### 1. Lister les Objets d'une Salle

Cette fonction retourne la liste des objets présents dans une salle donnée.

```sql
CREATE OR REPLACE FUNCTION lister_objet(nom_salle VARCHAR)
 RETURNS TABLE(nom_objets VARCHAR)
 LANGUAGE sql
 AS $$
    SELECT nom_objets
    FROM objets
    INNER JOIN salles ON salles.id_salles = objets.id_salles
    WHERE nom_salles = nom_salle;
 $$;
```

**Exemple d'utilisation :**

```sql
SELECT * FROM lister_objet('Cuisine');
```

### 2. Ajouter un Objet dans une Salle

Cette procédure ajoute un objet dans une salle spécifiée par son nom. Si la salle n'existe pas, une exception est levée.

```sql
CREATE OR REPLACE PROCEDURE ajout_objet(var_nom_objets VARCHAR, var_nom_salles VARCHAR)
 LANGUAGE plpgsql
 AS $$
 BEGIN
     INSERT INTO objets (nom_objets, id_salles)
     SELECT var_nom_objets, salles.id_salles
     FROM salles
     WHERE salles.nom_salles = var_nom_salles;

     IF NOT FOUND THEN
         RAISE EXCEPTION 'La salle "%" n''existe pas.', var_nom_salles;
     END IF;
 END;
 $$;
```

**Exemple d'utilisation :**

```sql
CALL ajout_objet('Statue en marbre', 'Hall');
```

---

## Requêtes Demandées

### 1. Lister tous les Personnages du Jeu

```sql
SELECT * FROM personnages;
```

Affiche la liste complète des personnages disponibles dans le jeu.

### 2. Lister chaque Joueur et son Personnage Associé

```sql
SELECT pseudo_utilisateurs, nom_personnages 
FROM utilisateurs
INNER JOIN personnages ON utilisateurs.id_personnages = personnages.id_personnages;
```

Montre chaque utilisateur associé au personnage qu'il a choisi.

### 3. Afficher les Personnages dans une Salle à une Heure Donnée

**Exemple : Personnages présents dans la "Cuisine" entre 08:00 et 09:00**

```sql
SELECT nom_personnages
FROM personnages
INNER JOIN visiter ON personnages.id_personnages = visiter.id_personnages
INNER JOIN salles ON visiter.id_salles = salles.id_salles
WHERE nom_salles = 'Cuisine' AND visiter.heure_arrivee <= '09:00' AND visiter.heure_sortie >= '08:00';
```

Identifie les personnages présents dans la "Cuisine" pendant l'heure spécifiée.

### 4. Afficher les Pièces non Visitées

```sql
SELECT nom_salles
FROM salles
WHERE id_salles NOT IN (
    SELECT DISTINCT id_salles FROM visiter
);
```

Liste les salles qui n'ont été visitées par aucun personnage.

### 5. Compter les Objets par Pièce

```sql
SELECT nom_salles, COUNT(id_objets) AS nombre_objets
FROM salles
LEFT JOIN objets ON salles.id_salles = objets.id_salles
GROUP BY nom_salles;
```

Affiche le nombre d'objets présents dans chaque salle.

### 6. Ajouter une Pièce

**Exemple : Ajouter la "Salle de musique"**

```sql
INSERT INTO salles (nom_salles) VALUES ('Salle de musique');
```

Ajoute une nouvelle salle appelée "Salle de musique" au jeu.

### 7. Modifier un Objet

**Exemple : Renommer l'objet avec `id_objets = 1` en "Lampe antique"**

```sql
UPDATE objets
SET nom_objets = 'Lampe antique'
WHERE id_objets = 1;
```

Renomme un objet pour le rendre plus intrigant.

### 8. Supprimer une Pièce

**Exemple : Supprimer la salle avec `id_salles = 10`**

```sql
DELETE FROM salles
WHERE id_salles = 10;
```

Supprime une salle du jeu pour épurer l'environnement.

---

## Sauvegarder la Base de Données

Pour sauvegarder la base de données **simpluedo_db**, exécutez la commande suivante :

```bash
pg_dump -U postgres -W -h localhost -p 5433 -d simpluedo_db -F p -f /chemin/vers/sauvegarde/simpluedo_export.sql
```

- `-U postgres` : Nom d'utilisateur PostgreSQL.
- `-W` : Demande le mot de passe de l'utilisateur.
- `-h localhost` : Adresse de l'hôte (utilisez localhost si la base est locale).
- `-p 5433` : Port utilisé par PostgreSQL (5433 dans cet exemple).
- `-d simpluedo_db` : Nom de la base de données à sauvegarder.
- `-F p` : Format de la sauvegarde (p pour plain text).
- `-f /chemin/vers/sauvegarde/simpluedo_export.sql` : Chemin et nom du fichier de sauvegarde.

---