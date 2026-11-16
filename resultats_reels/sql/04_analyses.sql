-- Analyses des résultats réels des JO de Paris 2024 (base jo_paris_2024_resultats).
-- Usage : mysql -t jo_paris_2024_resultats < resultats_reels/sql/04_analyses.sql
-- Les résultats commentés dans le README ont été obtenus avec ces requêtes.

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------------
-- A1. Classement officiel (à l'or) et classement au nombre total de médailles.
--     Le rang à l'or est recalculé à partir des médailles par épreuve et comparé
--     au rang publié ; le second classement montre l'effet de la convention choisie.
-- ---------------------------------------------------------------------------
WITH totaux AS (
  SELECT n.id_nation, n.nom,
         SUM(m.type_medaille = 'Or')     AS nb_or,
         SUM(m.type_medaille = 'Argent') AS nb_argent,
         SUM(m.type_medaille = 'Bronze') AS nb_bronze,
         COUNT(*)                        AS nb_total
  FROM medaille m
  JOIN nation n ON n.id_nation = m.id_nation
  GROUP BY n.id_nation, n.nom
),
classements AS (
  SELECT t.*, o.rang AS rang_publie,
         RANK() OVER (ORDER BY nb_or DESC, nb_argent DESC, nb_bronze DESC) AS rang_or,
         RANK() OVER (ORDER BY nb_total DESC)                              AS rang_total
  FROM totaux t
  JOIN tableau_officiel o ON o.id_nation = t.id_nation
  WHERE o.rang IS NOT NULL   -- les Athlètes individuels neutres ne sont pas classés
)
SELECT rang_publie, rang_or, rang_total,
       CAST(rang_or AS SIGNED) - CAST(rang_total AS SIGNED) AS gain_places_au_total,
       nom, nb_or, nb_argent, nb_bronze, nb_total
FROM classements
WHERE rang_or <= 15 OR rang_total <= 15
ORDER BY rang_or;

-- ---------------------------------------------------------------------------
-- A2. Concentration des médailles : combien de nations totalisent 25 %, 50 %,
--     75 % et 90 % des médailles ? (part cumulée, nations triées par total)
-- ---------------------------------------------------------------------------
WITH par_nation AS (
  SELECT id_nation, COUNT(*) AS nb_total
  FROM medaille
  GROUP BY id_nation
),
cumul AS (
  SELECT id_nation, nb_total,
         ROW_NUMBER() OVER (ORDER BY nb_total DESC, id_nation) AS position,
         SUM(nb_total) OVER (ORDER BY nb_total DESC, id_nation) / SUM(nb_total) OVER () AS part_cumulee
  FROM par_nation
),
seuils AS (
  SELECT 0.25 AS seuil UNION ALL SELECT 0.50 UNION ALL SELECT 0.75 UNION ALL SELECT 0.90
)
SELECT CONCAT(ROUND(s.seuil * 100), ' %') AS part_des_medailles,
       MIN(c.position) AS nb_nations_necessaires,
       (SELECT COUNT(*) FROM par_nation) AS nb_nations_medaillees,
       CONCAT(ROUND(100 * MIN(c.position) / (SELECT COUNT(*) FROM par_nation), 1), ' %') AS part_des_nations
FROM seuils s
JOIN cumul c ON c.part_cumulee >= s.seuil
GROUP BY s.seuil
ORDER BY s.seuil;

-- ---------------------------------------------------------------------------
-- A3. Sport le plus rémunérateur de chacune des 15 premières nations (au total),
--     et part de ce sport dans leurs médailles.
-- ---------------------------------------------------------------------------
WITH par_sport AS (
  SELECT m.id_nation, e.id_sport,
         COUNT(*) AS nb_medailles,
         SUM(m.type_medaille = 'Or') AS nb_or
  FROM medaille m
  JOIN epreuve e ON e.id_epreuve = m.id_epreuve
  GROUP BY m.id_nation, e.id_sport
),
classe AS (
  SELECT p.*,
         SUM(nb_medailles) OVER (PARTITION BY id_nation) AS total_nation,
         ROW_NUMBER() OVER (PARTITION BY id_nation ORDER BY nb_medailles DESC, nb_or DESC, id_sport) AS rn
  FROM par_sport p
),
top_nations AS (
  SELECT id_nation, RANK() OVER (ORDER BY COUNT(*) DESC) AS rang_total
  FROM medaille GROUP BY id_nation
)
SELECT t.rang_total, n.nom AS nation, c.total_nation, s.nom_fr AS sport_principal,
       c.nb_medailles, c.nb_or,
       CONCAT(ROUND(100 * c.nb_medailles / c.total_nation, 1), ' %') AS part_du_total
FROM classe c
JOIN top_nations t ON t.id_nation = c.id_nation
JOIN nation n ON n.id_nation = c.id_nation
JOIN sport s  ON s.id_sport  = c.id_sport
WHERE c.rn = 1 AND t.rang_total <= 15
ORDER BY t.rang_total, n.nom;

-- ---------------------------------------------------------------------------
-- A4. Nation dominante de chaque sport : plus grand nombre de titres
--     (ex aequo affichés ensemble), et part des titres du sport.
-- ---------------------------------------------------------------------------
WITH titres AS (
  SELECT e.id_sport, m.id_nation, COUNT(*) AS nb_or
  FROM medaille m
  JOIN epreuve e ON e.id_epreuve = m.id_epreuve
  WHERE m.type_medaille = 'Or'
  GROUP BY e.id_sport, m.id_nation
),
classe AS (
  SELECT t.*,
         SUM(nb_or) OVER (PARTITION BY id_sport) AS titres_du_sport,
         RANK() OVER (PARTITION BY id_sport ORDER BY nb_or DESC) AS rang
  FROM titres t
)
SELECT s.nom_fr AS sport, c.titres_du_sport,
       GROUP_CONCAT(n.nom ORDER BY n.nom SEPARATOR ', ') AS nation_dominante,
       MAX(c.nb_or) AS nb_or,
       CONCAT(ROUND(100 * MAX(c.nb_or) / c.titres_du_sport), ' %') AS part_des_titres
FROM classe c
JOIN sport s  ON s.id_sport  = c.id_sport
JOIN nation n ON n.id_nation = c.id_nation
WHERE c.rang = 1
GROUP BY s.id_sport, s.nom_fr, c.titres_du_sport
ORDER BY MAX(c.nb_or) / c.titres_du_sport DESC, c.titres_du_sport DESC;

-- ---------------------------------------------------------------------------
-- A5. Diversité et dépendance : nombre de sports médaillés et part du premier
--     sport, pour les nations ayant au moins 10 médailles.
-- ---------------------------------------------------------------------------
WITH par_sport AS (
  SELECT m.id_nation, e.id_sport, COUNT(*) AS nb_medailles
  FROM medaille m
  JOIN epreuve e ON e.id_epreuve = m.id_epreuve
  GROUP BY m.id_nation, e.id_sport
),
synthese AS (
  SELECT id_nation,
         SUM(nb_medailles)   AS nb_total,
         COUNT(*)            AS nb_sports_medailles,
         MAX(nb_medailles)   AS medailles_premier_sport
  FROM par_sport
  GROUP BY id_nation
  HAVING SUM(nb_medailles) >= 10
)
SELECT n.nom AS nation, s.nb_total, s.nb_sports_medailles,
       CONCAT(ROUND(100 * s.medailles_premier_sport / s.nb_total, 1), ' %') AS part_premier_sport,
       DENSE_RANK() OVER (ORDER BY s.nb_sports_medailles DESC) AS rang_diversite
FROM synthese s
JOIN nation n ON n.id_nation = s.id_nation
ORDER BY s.nb_sports_medailles DESC, s.nb_total DESC;

-- ---------------------------------------------------------------------------
-- A6. La France, pays hôte : médailles par sport et rang de la France
--     parmi les nations dans chaque sport (au nombre total de médailles).
-- ---------------------------------------------------------------------------
WITH par_sport AS (
  SELECT e.id_sport, m.id_nation,
         SUM(m.type_medaille = 'Or')     AS nb_or,
         SUM(m.type_medaille = 'Argent') AS nb_argent,
         SUM(m.type_medaille = 'Bronze') AS nb_bronze,
         COUNT(*) AS nb_total
  FROM medaille m
  JOIN epreuve e ON e.id_epreuve = m.id_epreuve
  GROUP BY e.id_sport, m.id_nation
),
classe AS (
  SELECT p.*, RANK() OVER (PARTITION BY id_sport ORDER BY nb_total DESC, nb_or DESC) AS rang_dans_le_sport
  FROM par_sport p
)
SELECT s.nom_fr AS sport, c.nb_or, c.nb_argent, c.nb_bronze, c.nb_total, c.rang_dans_le_sport
FROM classe c
JOIN sport s  ON s.id_sport  = c.id_sport
JOIN nation n ON n.id_nation = c.id_nation
WHERE n.nom = 'France'
ORDER BY c.nb_total DESC, c.nb_or DESC, s.nom_fr;

-- ---------------------------------------------------------------------------
-- A7. Répartition des médailles selon la catégorie d'épreuve (hommes, femmes,
--     mixte, ouvert) pour les 10 premières nations du tableau officiel.
-- ---------------------------------------------------------------------------
SELECT o.rang, n.nom AS nation,
       SUM(e.categorie = 'Hommes') AS hommes,
       SUM(e.categorie = 'Femmes') AS femmes,
       SUM(e.categorie = 'Mixte')  AS mixte,
       SUM(e.categorie = 'Ouvert') AS ouvert,
       COUNT(*) AS total,
       CONCAT(ROUND(100 * SUM(e.categorie = 'Femmes') / COUNT(*), 1), ' %') AS part_epreuves_feminines
FROM medaille m
JOIN epreuve e ON e.id_epreuve = m.id_epreuve
JOIN nation n ON n.id_nation = m.id_nation
JOIN tableau_officiel o ON o.id_nation = n.id_nation
WHERE o.rang <= 10
GROUP BY o.rang, n.nom
ORDER BY o.rang, n.nom;

-- Ensemble des épreuves et des médailles, par catégorie (référence pour A7).
SELECT e.categorie, COUNT(DISTINCT e.id_epreuve) AS nb_epreuves, COUNT(*) AS nb_medailles,
       CONCAT(ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1), ' %') AS part_des_medailles
FROM medaille m
JOIN epreuve e ON e.id_epreuve = m.id_epreuve
GROUP BY e.categorie
ORDER BY nb_medailles DESC;

-- ---------------------------------------------------------------------------
-- A8. Épreuves dont la répartition n'est pas une médaille de chaque couleur :
--     deux médailles de bronze dans toutes les épreuves d'un sport (règlement
--     des sports de combat) ou ex aequo ponctuels (une médaille peut alors ne
--     pas être attribuée).
-- ---------------------------------------------------------------------------
WITH par_epreuve AS (
  SELECT e.id_epreuve, e.id_sport, e.categorie, e.nom,
         SUM(m.type_medaille = 'Or')     AS nb_or,
         SUM(m.type_medaille = 'Argent') AS nb_argent,
         SUM(m.type_medaille = 'Bronze') AS nb_bronze
  FROM epreuve e
  JOIN medaille m ON m.id_epreuve = e.id_epreuve
  GROUP BY e.id_epreuve, e.id_sport, e.categorie, e.nom
),
sports_deux_bronzes AS (   -- sports dont toutes les épreuves ont deux bronzes
  SELECT id_sport
  FROM par_epreuve
  GROUP BY id_sport
  HAVING MIN(nb_bronze = 2 AND nb_argent = 1) = 1
)
SELECT s.nom_fr AS sport,
       IF(d.id_sport IS NULL, 'Ex aequo', 'Deux bronzes par épreuve') AS motif,
       COUNT(*) AS nb_epreuves,
       SUM(p.nb_or + p.nb_argent + p.nb_bronze) AS nb_medailles,
       IF(d.id_sport IS NULL,
          GROUP_CONCAT(CONCAT(p.nom, ' (', p.categorie, ') : ', p.nb_or, ' or, ', p.nb_argent, ' argent, ',
                              p.nb_bronze, ' bronze') ORDER BY p.nom SEPARATOR ' ; '),
          NULL) AS detail
FROM par_epreuve p
JOIN sport s ON s.id_sport = p.id_sport
LEFT JOIN sports_deux_bronzes d ON d.id_sport = p.id_sport
WHERE NOT (p.nb_or = 1 AND p.nb_argent = 1 AND p.nb_bronze = 1)
GROUP BY s.id_sport, s.nom_fr, d.id_sport
ORDER BY motif, nb_epreuves DESC, sport;

-- ---------------------------------------------------------------------------
-- A9. Athlètes les plus médaillés (au moins 3 médailles).
-- ---------------------------------------------------------------------------
WITH par_athlete AS (
  SELECT a.id_athlete, a.nom,
         MIN(n.nom) AS nation,
         SUM(m.type_medaille = 'Or')     AS nb_or,
         SUM(m.type_medaille = 'Argent') AS nb_argent,
         SUM(m.type_medaille = 'Bronze') AS nb_bronze,
         COUNT(*) AS nb_total,
         MIN(s.nom_fr) AS sport
  FROM medaille_athlete ma
  JOIN athlete a  ON a.id_athlete  = ma.id_athlete
  JOIN medaille m ON m.id_medaille = ma.id_medaille
  JOIN nation n   ON n.id_nation   = m.id_nation
  JOIN epreuve e  ON e.id_epreuve  = m.id_epreuve
  JOIN sport s    ON s.id_sport    = e.id_sport
  GROUP BY a.id_athlete, a.nom
)
SELECT DENSE_RANK() OVER (ORDER BY nb_total DESC, nb_or DESC, nb_argent DESC) AS rang,
       nom AS athlete, nation, sport, nb_or, nb_argent, nb_bronze, nb_total
FROM par_athlete
WHERE nb_total >= 3
ORDER BY rang, nom;

-- ---------------------------------------------------------------------------
-- A10. Proportion de titres parmi les médailles (nations ayant au moins 15
--      médailles), comparée à la moyenne de l'ensemble des médailles.
-- ---------------------------------------------------------------------------
WITH par_nation AS (
  SELECT m.id_nation,
         SUM(m.type_medaille = 'Or') AS nb_or,
         COUNT(*) AS nb_total
  FROM medaille m
  GROUP BY m.id_nation
),
reference AS (
  SELECT SUM(nb_or) / SUM(nb_total) AS taux_global FROM par_nation
)
SELECT n.nom AS nation, p.nb_or, p.nb_total,
       CONCAT(ROUND(100 * p.nb_or / p.nb_total, 1), ' %') AS part_de_titres,
       CONCAT(IF(p.nb_or / p.nb_total >= r.taux_global, '+', ''),
              ROUND(100 * (p.nb_or / p.nb_total - r.taux_global), 1), ' pts') AS ecart_a_la_moyenne
FROM par_nation p
CROSS JOIN reference r
JOIN nation n ON n.id_nation = p.id_nation
WHERE p.nb_total >= 15
ORDER BY p.nb_or / p.nb_total DESC, p.nb_total DESC;
