-- Audit de la qualité des données de la base SIMULÉE « jeux_olympiques_2024 »
-- (script d'origine JO_Paris_base_de_donnee.sql, conservé sans modification).
--
-- Requêtes en lecture seule : elles signalent les incohérences sans rien corriger.
-- Les données de cette base sont fictives ou approximatives : elles ne doivent pas
-- être confondues avec les résultats réels du module resultats_reels/.
--
-- Usage : mysql -t jeux_olympiques_2024 < audit/audit_base_simulee.sql

SET NAMES utf8mb4;

-- Q1. Athlètes saisis plusieurs fois (même nom, prénom et date de naissance).
SELECT nom_athlete, prenom_athlete, date_naissance,
       COUNT(*) AS nb_lignes,
       GROUP_CONCAT(id_athlete ORDER BY id_athlete) AS identifiants
FROM athlete
GROUP BY nom_athlete, prenom_athlete, date_naissance
HAVING COUNT(*) > 1
ORDER BY nom_athlete;

-- Q2. Dates de naissance invraisemblables pour un athlète olympique
--     (moins de 14 ans à l'ouverture des Jeux, ou date absente).
SELECT id_athlete, nom_athlete, prenom_athlete, date_naissance,
       TIMESTAMPDIFF(YEAR, date_naissance, '2024-07-26') AS age_aux_jeux
FROM athlete
WHERE date_naissance IS NULL
   OR TIMESTAMPDIFF(YEAR, date_naissance, '2024-07-26') < 14
ORDER BY date_naissance;

-- Q3. Doublons dans les référentiels : disciplines de même nom, épreuves de
--     même nom dans la même discipline.
SELECT 'discipline' AS table_concernee, nom_discipline AS libelle,
       COUNT(*) AS nb_lignes, GROUP_CONCAT(id_discipline ORDER BY id_discipline) AS identifiants
FROM discipline
GROUP BY nom_discipline
HAVING COUNT(*) > 1
UNION ALL
SELECT 'epreuve', nom_epreuve, COUNT(*), GROUP_CONCAT(id_epreuve ORDER BY id_epreuve)
FROM epreuve
GROUP BY nom_epreuve, id_discipline
HAVING COUNT(*) > 1
ORDER BY table_concernee, libelle;

-- Q4. Épreuves datées en dehors de l'événement auquel elles sont rattachées.
SELECT p.id_epreuve, p.nom_epreuve, p.date_epreuve,
       e.nom_evenement, e.date_debut, e.date_fin
FROM epreuve p
JOIN evenement e ON e.id_evenement = p.id_evenement
WHERE p.date_epreuve NOT BETWEEN e.date_debut AND e.date_fin
ORDER BY p.date_epreuve;

-- Q5. Libellés de médaille non normalisés (mêmes valeurs écrites avec une casse différente).
SELECT CAST(medaille AS BINARY) AS valeur_exacte, COUNT(*) AS nb_resultats
FROM resultat
GROUP BY CAST(medaille AS BINARY)
ORDER BY nb_resultats DESC;

-- Q6. Résultats comptés plusieurs fois : un même athlète a plusieurs lignes dans
--     la même épreuve, car les records sont enregistrés comme des résultats
--     supplémentaires (type_resultat mélange nature du résultat et records).
SELECT a.nom_athlete, a.prenom_athlete, p.nom_epreuve,
       COUNT(*) AS nb_lignes,
       GROUP_CONCAT(CONCAT(COALESCE(r.medaille, 'sans médaille'), ' / ', t.nom_type)
                    ORDER BY r.id_resultat SEPARATOR ' ; ') AS detail
FROM resultat r
JOIN athlete a       ON a.id_athlete = r.id_athlete
JOIN epreuve p       ON p.id_epreuve = r.id_epreuve
JOIN type_resultat t ON t.id_type_resultat = r.id_type_resultat
GROUP BY r.id_athlete, a.nom_athlete, a.prenom_athlete, r.id_epreuve, p.nom_epreuve
HAVING COUNT(*) > 1
ORDER BY a.nom_athlete;

-- Q7. Incohérences entre l'athlète et l'épreuve ou l'équipe : sexe incompatible avec
--     une épreuve masculine ou féminine, pays de l'athlète différent de celui de l'équipe.
SELECT r.id_resultat, a.nom_athlete, a.prenom_athlete, a.sexe_athlete, a.pays_athlete,
       p.nom_epreuve, d.nom_pays AS pays_equipe,
       CONCAT_WS(' + ',
         IF((p.nom_epreuve LIKE '%hommes%' AND a.sexe_athlete = 'F')
            OR (p.nom_epreuve LIKE '%femme%' AND a.sexe_athlete = 'H'), 'sexe / épreuve', NULL),
         IF(a.pays_athlete <> d.nom_pays, 'pays / équipe', NULL)) AS anomalie
FROM resultat r
JOIN athlete a     ON a.id_athlete = r.id_athlete
JOIN epreuve p     ON p.id_epreuve = r.id_epreuve
LEFT JOIN equipe q ON q.id_equipe = r.id_equipe
LEFT JOIN delegation d ON d.id_delegation = q.id_delegation
WHERE (p.nom_epreuve LIKE '%hommes%' AND a.sexe_athlete = 'F')
   OR (p.nom_epreuve LIKE '%femme%' AND a.sexe_athlete = 'H')
   OR a.pays_athlete <> d.nom_pays
ORDER BY r.id_resultat;

-- Q8. Classements incohérents : position différente entre resultat et classement,
--     ou même ligne de classement partagée par plusieurs épreuves.
SELECT r.id_resultat, a.nom_athlete, p.nom_epreuve, r.position_ AS position_resultat,
       c.id_classement, c.position_athlete AS position_classement,
       CONCAT_WS(' + ',
         IF(r.position_ <> c.position_athlete, 'positions différentes', NULL),
         IF(partage.nb_epreuves > 1, CONCAT('classement partagé par ', partage.nb_epreuves, ' épreuves'), NULL)
       ) AS anomalie
FROM resultat r
JOIN classement c ON c.id_classement = r.id_classement
JOIN athlete a    ON a.id_athlete = r.id_athlete
JOIN epreuve p    ON p.id_epreuve = r.id_epreuve
JOIN (SELECT id_classement, COUNT(DISTINCT id_epreuve) AS nb_epreuves
      FROM resultat GROUP BY id_classement) partage ON partage.id_classement = r.id_classement
WHERE r.position_ <> c.position_athlete OR partage.nb_epreuves > 1
ORDER BY c.id_classement, r.id_resultat;

-- Q9. Résultats d'athlètes absents de la table « participer », et part des
--     épreuves sans aucun résultat.
SELECT 'résultat sans participation enregistrée' AS constat,
       COUNT(DISTINCT r.id_athlete, r.id_epreuve) AS nombre,
       (SELECT COUNT(DISTINCT id_athlete, id_epreuve) FROM resultat WHERE id_athlete IS NOT NULL) AS sur_un_total_de
FROM resultat r
WHERE r.id_athlete IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM participer pa
                  WHERE pa.id_athlete = r.id_athlete AND pa.id_epreuve = r.id_epreuve)
UNION ALL
SELECT 'épreuve sans aucun résultat',
       (SELECT COUNT(*) FROM epreuve p
        WHERE NOT EXISTS (SELECT 1 FROM resultat r WHERE r.id_epreuve = p.id_epreuve)),
       (SELECT COUNT(*) FROM epreuve);

-- Q10. Billetterie : présences enregistrées sans billet pour la même session,
--      et billets sans présence correspondante.
SELECT 'présence sans billet' AS constat, COUNT(*) AS nombre,
       (SELECT COUNT(*) FROM assister) AS sur_un_total_de
FROM assister a
WHERE NOT EXISTS (SELECT 1 FROM billet b
                  WHERE b.id_spectateur = a.id_spectateur AND b.id_session = a.id_session)
UNION ALL
SELECT 'billet sans présence', COUNT(*), (SELECT COUNT(*) FROM billet)
FROM billet b
WHERE NOT EXISTS (SELECT 1 FROM assister a
                  WHERE a.id_spectateur = b.id_spectateur AND a.id_session = b.id_session);
