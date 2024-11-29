# Correction par l'Équipe ARES

## Documentation 

- [X] : Règles de gestion
- [X] : Dictionnaire de données 
- [X] : MCD 
- [X] : MLD 
- [X] : MPD 
- [X] : Exactitude des relations

## Création de la base de données 

- [X] : Script de création de table 
- [X] : Script de peuplement 
- [X] : Exécution sans erreur
- [X] : Gestion RBAC
- [X] : Trigger

## Requêtes et procédures stockées 

### Requêtes 

- [X] Lister tous les personnages du jeu

- [X] Lister chaque joueur et son personnage associé

- [X] Afficher la liste des personnages présents dans la cuisine entre 08:00 et 09:00

- [X] Afficher les pièces où aucun personnage n'est allé

- [X] Compter le nombre d'objets par pièce

- [X] Ajouter une pièce

- [X] Modifier un objet

- [X] Supprimer une pièce

### Procédures stockés

- [X] Lister les Objets d'une salle

- [X] Ajouter un Objet dans une salle

## Environnement sous docker 

- [] : Mis en place et fonctionnel 

## Remarques 

Il est dommage de prévoir une colonne "taille" dans le dictionnaire de données mais de ne pas la remplir.
Aussi, les données des tables/entités doivent être au singulier.
La donnée "uuid-utilisateurs" est notée comme UUID dans le dictionnaire de données mais est notée INTEGER dans le MPD. Dans looping, le type de donnée UUID n'est pas disponible par défaut mais il est possible de l'ajouter en cliquant sur "Autres".

Concernant la table "position", son nom n'est pas très explécite, ça pourrait être la position des objets par exemple. "position-personnage" aurait été préférable.

Concernant le trigger, il fonctionne parfaitement mais la table "position" ne répond pas à sa fonction tant que les personnages n'ont pas bougé au moins une fois après peuplement de la table. 