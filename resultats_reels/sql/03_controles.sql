-- Contrôles de cohérence des données réelles (base jo_paris_2024_resultats).
-- Chaque contrôle renvoie le nombre d'anomalies : le résultat attendu est 0 partout.
-- Usage : mysql -t jo_paris_2024_resultats < resultats_reels/sql/03_controles.sql

SET NAMES utf8mb4;

WITH
-- C1. Médailles comptées par épreuve et tableau des médailles publié par la source : mêmes totaux par nation.
calcule AS (
  SELECT id_nation,
         SUM(type_medaille = 'Or')     AS nb_or,
         SUM(type_medaille = 'Argent') AS nb_argent,
         SUM(type_medaille = 'Bronze') AS nb_bronze
  FROM medaille
  GROUP BY id_nation
),
ecarts_tableau AS (
  SELECT o.id_nation
  FROM tableau_officiel o
  LEFT JOIN calcule c ON c.id_nation = o.id_nation
  WHERE NOT (o.nb_or <=> c.nb_or AND o.nb_argent <=> c.nb_argent AND o.nb_bronze <=> c.nb_bronze)
),
-- C2. Une et une seule médaille d'or par épreuve.
or_par_epreuve AS (
  SELECT e.id_epreuve, COUNT(m.id_medaille) AS nb_or
  FROM epreuve e
  LEFT JOIN medaille m ON m.id_epreuve = e.id_epreuve AND m.type_medaille = 'Or'
  GROUP BY e.id_epreuve
),
-- C3. Chaque épreuve a au moins une médaille d'argent (aucune égalité pour l'or en 2024).
sans_argent AS (
  SELECT e.id_epreuve
  FROM epreuve e
  WHERE NOT EXISTS (SELECT 1 FROM medaille m WHERE m.id_epreuve = e.id_epreuve AND m.type_medaille = 'Argent')
),
-- C4. Chaque médaille a au moins un athlète.
sans_athlete AS (
  SELECT m.id_medaille
  FROM medaille m
  WHERE NOT EXISTS (SELECT 1 FROM medaille_athlete ma WHERE ma.id_medaille = m.id_medaille)
),
-- C5. Un athlète n'est médaillé que pour une seule nation.
plusieurs_nations AS (
  SELECT ma.id_athlete
  FROM medaille_athlete ma
  JOIN medaille m ON m.id_medaille = ma.id_medaille
  GROUP BY ma.id_athlete
  HAVING COUNT(DISTINCT m.id_nation) > 1
),
-- C6. Aucun athlète à la fois dans une épreuve masculine et une épreuve féminine
--     (contrôle de la catégorie déduite lors de l'extraction).
deux_categories AS (
  SELECT ma.id_athlete
  FROM medaille_athlete ma
  JOIN medaille m ON m.id_medaille = ma.id_medaille
  JOIN epreuve e  ON e.id_epreuve  = m.id_epreuve
  GROUP BY ma.id_athlete
  HAVING SUM(e.categorie = 'Hommes') > 0 AND SUM(e.categorie = 'Femmes') > 0
),
-- C7. Un athlète ne reçoit pas deux médailles dans la même épreuve.
doublons_epreuve AS (
  SELECT ma.id_athlete, m.id_epreuve
  FROM medaille_athlete ma
  JOIN medaille m ON m.id_medaille = ma.id_medaille
  GROUP BY ma.id_athlete, m.id_epreuve
  HAVING COUNT(*) > 1
),
-- C9. Le rang publié correspond au rang recalculé (or, puis argent, puis bronze).
rangs AS (
  SELECT o.rang,
         RANK() OVER (ORDER BY c.nb_or DESC, c.nb_argent DESC, c.nb_bronze DESC) AS rang_calcule
  FROM tableau_officiel o
  JOIN calcule c ON c.id_nation = o.id_nation
  WHERE o.rang IS NOT NULL
)
SELECT 'C1 totaux par nation différents du tableau officiel' AS controle,
       (SELECT COUNT(*) FROM ecarts_tableau) AS anomalies
UNION ALL SELECT 'C2 épreuves sans exactement une médaille d''or',
       (SELECT COUNT(*) FROM or_par_epreuve WHERE nb_or <> 1)
UNION ALL SELECT 'C3 épreuves sans médaille d''argent',
       (SELECT COUNT(*) FROM sans_argent)
UNION ALL SELECT 'C4 médailles sans athlète',
       (SELECT COUNT(*) FROM sans_athlete)
UNION ALL SELECT 'C5 athlètes médaillés pour plusieurs nations',
       (SELECT COUNT(*) FROM plusieurs_nations)
UNION ALL SELECT 'C6 athlètes à la fois en épreuve masculine et féminine',
       (SELECT COUNT(*) FROM deux_categories)
UNION ALL SELECT 'C7 athlètes médaillés deux fois dans la même épreuve',
       (SELECT COUNT(*) FROM doublons_epreuve)
UNION ALL SELECT 'C8 total des médailles différent de 329 / 330 / 385',
       (SELECT (SUM(nb_or) <> 329) + (SUM(nb_argent) <> 330) + (SUM(nb_bronze) <> 385) FROM tableau_officiel)
UNION ALL SELECT 'C9 rangs publiés différents des rangs recalculés',
       (SELECT COUNT(*) FROM rangs WHERE rang <> rang_calcule);
