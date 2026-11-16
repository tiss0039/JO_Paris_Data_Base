-- Module d'analyse : résultats RÉELS des Jeux olympiques de Paris 2024.
-- Base distincte de la base simulée « jeux_olympiques_2024 » (JO_Paris_base_de_donnee.sql).
-- MySQL 8.0 ou plus récent.

CREATE DATABASE IF NOT EXISTS jo_paris_2024_resultats
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE jo_paris_2024_resultats;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS medaille_athlete;
DROP TABLE IF EXISTS athlete;
DROP TABLE IF EXISTS medaille;
DROP TABLE IF EXISTS epreuve;
DROP TABLE IF EXISTS sport;
DROP TABLE IF EXISTS tableau_officiel;
DROP TABLE IF EXISTS nation;

-- Comité national olympique (ou équipe : Athlètes individuels neutres, Équipe olympique des réfugiés).
-- Seules les 92 délégations ayant remporté au moins une médaille figurent dans la source.
CREATE TABLE nation (
  id_nation      SMALLINT UNSIGNED NOT NULL,
  nom            VARCHAR(60)  NOT NULL,   -- nom anglais, tel que dans la source
  page_wikipedia VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_nation),
  UNIQUE KEY uq_nation_nom (nom)
) ENGINE=InnoDB;

-- Tableau des médailles tel que publié par la source (Wikipédia, données non officielles du CIO),
-- conservé tel quel pour contrôler les données par épreuve.
CREATE TABLE tableau_officiel (
  id_nation SMALLINT UNSIGNED NOT NULL,
  rang      SMALLINT UNSIGNED NULL,       -- NULL : délégation non classée (Athlètes individuels neutres)
  nb_or     SMALLINT UNSIGNED NOT NULL,
  nb_argent SMALLINT UNSIGNED NOT NULL,
  nb_bronze SMALLINT UNSIGNED NOT NULL,
  nb_total  SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (id_nation),
  CONSTRAINT fk_officiel_nation FOREIGN KEY (id_nation) REFERENCES nation (id_nation),
  CONSTRAINT ck_officiel_total CHECK (nb_total = nb_or + nb_argent + nb_bronze)
) ENGINE=InnoDB;

-- Sport, selon le découpage de la source (35 sports ; par ex. le plongeon est distinct de la natation).
CREATE TABLE sport (
  id_sport TINYINT UNSIGNED NOT NULL,
  nom      VARCHAR(40) NOT NULL,           -- nom anglais de la source
  nom_fr   VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_sport),
  UNIQUE KEY uq_sport_nom (nom)
) ENGINE=InnoDB;

-- Épreuve donnant lieu à l'attribution de médailles (329 épreuves).
CREATE TABLE epreuve (
  id_epreuve SMALLINT UNSIGNED NOT NULL,
  id_sport   TINYINT UNSIGNED NOT NULL,
  discipline VARCHAR(40) NULL,             -- ex. « Track cycling », « Beach volleyball »
  categorie  ENUM('Hommes', 'Femmes', 'Mixte', 'Ouvert') NOT NULL,
  nom        VARCHAR(80) NOT NULL,         -- nom anglais de la source
  PRIMARY KEY (id_epreuve),
  UNIQUE KEY uq_epreuve (id_sport, discipline, categorie, nom),
  CONSTRAINT fk_epreuve_sport FOREIGN KEY (id_sport) REFERENCES sport (id_sport)
) ENGINE=InnoDB;

-- Une ligne par médaille attribuée (une médaille d'équipe compte pour une médaille,
-- comme dans le tableau des médailles). Les ex aequo donnent plusieurs lignes.
CREATE TABLE medaille (
  id_medaille   SMALLINT UNSIGNED NOT NULL,
  id_epreuve    SMALLINT UNSIGNED NOT NULL,
  id_nation     SMALLINT UNSIGNED NOT NULL,
  type_medaille ENUM('Or', 'Argent', 'Bronze') NOT NULL,
  rang_medaille TINYINT UNSIGNED NOT NULL,  -- 1 or, 2 argent, 3 bronze (pour trier)
  PRIMARY KEY (id_medaille),
  KEY ix_medaille_nation (id_nation, type_medaille),
  KEY ix_medaille_epreuve (id_epreuve, type_medaille),
  CONSTRAINT fk_medaille_epreuve FOREIGN KEY (id_epreuve) REFERENCES epreuve (id_epreuve),
  CONSTRAINT fk_medaille_nation  FOREIGN KEY (id_nation)  REFERENCES nation (id_nation),
  CONSTRAINT ck_medaille_rang CHECK (rang_medaille = CASE type_medaille
                                       WHEN 'Or' THEN 1 WHEN 'Argent' THEN 2 ELSE 3 END)
) ENGINE=InnoDB;

-- Médaillé, identifié par sa page Wikipédia (deux homonymes restent distincts).
CREATE TABLE athlete (
  id_athlete     SMALLINT UNSIGNED NOT NULL,
  nom            VARCHAR(80)  NOT NULL,
  page_wikipedia VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_athlete),
  UNIQUE KEY uq_athlete_page (page_wikipedia)
) ENGINE=InnoDB;

-- Membres d'une médaille (un athlète en individuel, plusieurs pour une équipe).
CREATE TABLE medaille_athlete (
  id_medaille SMALLINT UNSIGNED NOT NULL,
  id_athlete  SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (id_medaille, id_athlete),
  KEY ix_ma_athlete (id_athlete),
  CONSTRAINT fk_ma_medaille FOREIGN KEY (id_medaille) REFERENCES medaille (id_medaille),
  CONSTRAINT fk_ma_athlete  FOREIGN KEY (id_athlete)  REFERENCES athlete (id_athlete)
) ENGINE=InnoDB;
