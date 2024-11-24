# brief-simpluedo-sealevel-crows

psql -f /home/messa/sites/simplon/brief-simpluedo-sealevel-crows/doc/BDD/script.sql

pg_dump -U postgres -W -h localhost -p 5433 -d simpluedo_db -F p -f /home/messa/sites/simplon/brief-simpluedo-sealevel-crows/doc/BDD/sauvegardes/simpluedo_export.sql

sudo chown postgres:postgres /home/messa/sites/simplon/brief-simpluedo-sealevel-crows/doc/BDD/sauvegardes


select * from personnages;

select pseudo_utilisateurs, nom_personnages from utilisateurs
 INNER JOIN personnages 
 ON utilisateurs.id_personnages = personnages.id_personnages;

select nom_personnages from personnages
 INNER JOIN visiter 
 ON personnages.id_personnages = visiter.id_personnages
 INNER JOIN salles
 ON visiter.id_salles = salles.id_salles
 WHERE nom_salles = 'Cuisine'
 AND visiter.heure_arrivee BETWEEN '8:00' AND '9:00';

 SELECT nom_salles
FROM salles 
WHERE salles.id_salles NOT IN (
    SELECT DISTINCT visiter.id_salles
    FROM visiter 
);


SELECT nom_salles, COUNT(id_objets)
FROM salles 
LEFT JOIN objets ON salles.id_salles = objets.id_salles
GROUP BY salles.nom_salles;

INSERT INTO salles (nom_salles) VALUES ('Salle de musique');

UPDATE objets
SET nom_objets = 'Lampe antique'
WHERE id_objets = 1;

DELETE FROM salles WHERE id_salles = 10;