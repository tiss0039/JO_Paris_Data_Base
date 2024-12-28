-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : mar. 12 nov. 2024 à 22:36
-- Version du serveur : 8.0.35
-- Version de PHP : 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jeux_olympiques_2024`
--

-- --------------------------------------------------------

--
-- Structure de la table `assister`
--

CREATE TABLE `assister` (
  `id_session` int NOT NULL,
  `id_spectateur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `assister`
--

INSERT INTO `assister` (`id_session`, `id_spectateur`) VALUES
(1, 1),
(2, 1),
(3, 1),
(13, 1),
(15, 1),
(1, 2),
(2, 3),
(4, 4),
(5, 5),
(6, 5),
(5, 6),
(7, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 11),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 31),
(32, 32);

-- --------------------------------------------------------

--
-- Structure de la table `athlete`
--

CREATE TABLE `athlete` (
  `id_athlete` int NOT NULL,
  `nom_athlete` varchar(50) DEFAULT NULL,
  `prenom_athlete` varchar(50) DEFAULT NULL,
  `pays_athlete` varchar(50) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `sexe_athlete` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `athlete`
--

INSERT INTO `athlete` (`id_athlete`, `nom_athlete`, `prenom_athlete`, `pays_athlete`, `date_naissance`, `sexe_athlete`) VALUES
(1, 'Marchand', 'Léon', 'France', '2002-05-11', 'H'),
(2, 'Riner', 'Teddy', 'France', '1989-04-07', 'H'),
(3, 'Biles', 'Simone', 'États-Unis', '1997-03-14', 'F'),
(4, 'Djokovic', 'Novak', 'Serbie', '1987-05-22', 'H'),
(5, 'Duplantis', 'Armand', 'Suède', '1999-11-10', 'H'),
(6, 'Ledecky', 'Katie', 'États-Unis', '1997-03-17', 'F'),
(7, 'Lyles', 'Noah', 'États-Unis', '1997-07-18', 'H'),
(8, 'Lopez', 'Mijain', 'Cuba', '1982-08-20', 'H'),
(9, 'James', 'LeBron', 'États-Unis', '1984-12-30', 'H'),
(10, 'Pan', 'Zhanle', 'Chine', '2004-04-15', 'H'),
(11, 'Marchand', 'Léon', 'France', '2002-05-11', 'H'),
(12, 'Dressel', 'Caeleb', 'États-Unis', '1996-08-16', 'H'),
(13, 'McKeown', 'Kaylee', 'Australie', '2001-07-12', 'F'),
(14, 'Ledecky', 'Katie', 'États-Unis', '1997-03-17', 'F'),
(15, 'Popovici', 'David', 'Roumanie', '2004-09-15', 'H'),
(16, 'Chalmers', 'Kyle', 'Australie', '1998-06-25', 'H'),
(17, 'Kolesnikov', 'Kliment', 'Russie', '2000-07-09', 'H'),
(18, 'Sjostrom', 'Sarah', 'Suède', '1993-08-17', 'F'),
(19, 'Paltrinieri', 'Gregorio', 'Italie', '1994-09-05', 'H'),
(20, 'Titmus', 'Ariarne', 'Australie', '2000-09-07', 'F'),
(21, 'Milak', 'Kristof', 'Hongrie', '2000-02-20', 'H'),
(22, 'Peaty', 'Adam', 'Royaume-Uni', '1994-12-28', 'H'),
(23, 'Ohashi', 'Yui', 'Japon', '1995-10-18', 'F'),
(24, 'Biles', 'Simone', 'États-Unis', '1997-03-14', 'F'),
(25, 'Groulx', 'Summer', 'Canada', '1999-04-05', 'F'),
(26, 'Haughey', 'Siobhan', 'Hong Kong', '1997-10-31', 'F'),
(27, 'Kamminga', 'Arno', 'Pays-Bas', '1995-10-22', 'H'),
(28, 'Lopez', 'Juan Manuel', 'Espagne', '1999-02-28', 'H'),
(29, 'Kirpichnikova', 'Anastasia', 'Russie', '2000-04-22', 'F'),
(30, 'Pallister', 'Lani', 'Australie', '2002-08-06', 'F'),
(31, 'Hubbard', 'Laurel', 'Nouvelle-Zélande', '1978-02-09', 'F'),
(32, 'Fraser-Pryce', 'Shelly-Ann', 'Jamaïque', '1986-12-27', 'F'),
(33, 'Warholm', 'Karsten', 'Norvège', '1996-02-28', 'H'),
(34, 'Ingebrigtsen', 'Jakob', 'Norvège', '2000-09-19', 'H'),
(35, 'Richardson', 'Sha’Carri', 'États-Unis', '2000-03-25', 'F'),
(36, 'Knighton', 'Erriyon', 'États-Unis', '2004-01-29', 'H'),
(37, 'Obiri', 'Hellen', 'Kenya', '1989-12-13', 'F'),
(38, 'De Grasse', 'Andre', 'Canada', '1994-11-10', 'H'),
(39, 'Dos Santos', 'Alison', 'Brésil', '2000-06-03', 'H'),
(40, 'Kipyegon', 'Faith', 'Kenya', '1994-01-10', 'F'),
(41, 'Dupont', 'Jean', 'France', '1990-06-15', 'H'),
(42, 'Martin', 'Luc', 'France', '1992-09-08', 'H'),
(43, 'Lucie', 'Pierre', 'France', '1988-03-22', 'F'),
(44, 'Lorenzo', 'Musetti', 'Italie', '2024-03-03', 'H'),
(45, 'Campbell', 'Bronte', 'Australie', '1994-05-14', 'F'),
(46, 'O’Callaghan', 'Mollie ', 'Australie', '2004-04-02', 'F'),
(47, 'Ballard', 'Angela', 'Royaume-Uni', '1982-06-06', 'F'),
(48, 'Zhou', 'Hongzhuan', 'Chine', '1988-12-12', 'F'),
(49, 'Kinghorn', 'Samantha', 'Royaume-Uni', '1996-01-06', 'F'),
(50, 'McClammer', 'Chelsea', 'États-Unis', '1994-03-01', 'F'),
(51, 'Dupont', 'Alexis', 'France', '1998-07-22', 'H'),
(52, 'Bernard', 'Thomas', 'France', '1996-03-15', 'H'),
(53, 'Lemoine', 'Pierre', 'France', '2000-10-05', 'H'),
(54, 'Martin', 'Julien', 'France', '1999-05-30', 'H');

-- --------------------------------------------------------

--
-- Structure de la table `billet`
--

CREATE TABLE `billet` (
  `id_billet` int NOT NULL,
  `prix_billet` decimal(15,2) DEFAULT NULL,
  `date_achat` date DEFAULT NULL,
  `id_spectateur` int DEFAULT NULL,
  `id_session` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `billet`
--

INSERT INTO `billet` (`id_billet`, `prix_billet`, `date_achat`, `id_spectateur`, `id_session`) VALUES
(1, 950.00, '2024-06-15', 1, 1),
(2, 120.00, '2024-06-16', 2, 2),
(3, 250.00, '2024-06-17', 3, 3),
(4, 100.00, '2024-06-18', 4, 4),
(5, 240.00, '2024-06-19', 5, 5),
(6, 80.00, '2024-06-20', 6, 6),
(7, 85.00, '2024-06-21', 7, 7),
(8, 130.00, '2024-06-22', 8, 8),
(9, 130.00, '2024-06-23', 9, 9),
(10, 90.00, '2024-06-24', 10, 10),
(11, 250.00, '2024-06-25', 11, 11),
(12, 70.00, '2024-06-26', 12, 12),
(13, 110.00, '2024-06-27', 13, 13),
(14, 400.00, '2024-06-28', 14, 14),
(15, 375.00, '2024-06-29', 15, 15),
(16, 120.00, '2024-06-30', 16, 16),
(17, 125.00, '2024-07-01', 17, 17),
(18, 105.00, '2024-07-02', 18, 18),
(19, 60.00, '2024-07-03', 19, 19),
(20, 150.00, '2024-07-04', 20, 19),
(21, 90.00, '2024-07-05', 21, 21),
(22, 160.00, '2024-07-06', 22, 21),
(23, 75.00, '2024-07-07', 23, 23),
(24, 100.00, '2024-07-08', 24, 9),
(25, 60.00, '2024-07-09', 25, 25),
(26, 140.00, '2024-07-10', 26, 26),
(27, 160.00, '2024-07-11', 27, 27),
(28, 150.00, '2024-07-12', 28, 28),
(29, 500.00, '2024-07-13', 29, 29),
(30, 950.00, '2024-07-14', 30, 30),
(31, 150.00, '2024-06-01', 1, 25),
(32, 200.00, '2024-06-02', 2, 9),
(33, 250.00, '2024-06-03', 3, 19),
(34, 175.00, '2024-06-04', 4, 5),
(35, 120.00, '2024-06-05', 5, 24),
(36, 220.00, '2024-06-06', 1, 23),
(37, 190.00, '2024-06-07', 2, 16),
(38, 300.00, '2024-06-08', 3, 12),
(39, 250.00, '2024-06-09', 4, 4),
(40, 100.00, '2024-06-10', 5, 21),
(41, 180.00, '2024-06-11', 1, 15),
(42, 130.00, '2024-06-12', 2, 2),
(43, 145.00, '2024-06-13', 3, 25),
(44, 210.00, '2024-06-14', 4, 9),
(45, 175.00, '2024-06-15', 5, 19),
(46, 165.00, '2024-06-16', 1, 5),
(47, 250.00, '2024-06-17', 2, 24),
(48, 225.00, '2024-06-18', 3, 23),
(49, 190.00, '2024-06-19', 4, 16),
(50, 180.00, '2024-06-20', 5, 12),
(51, 140.00, '2024-06-21', 1, 4),
(52, 110.00, '2024-06-22', 2, 21),
(53, 155.00, '2024-06-23', 3, 15),
(54, 125.00, '2024-06-24', 4, 2),
(55, 135.00, '2024-06-25', 5, 25),
(56, 145.00, '2024-06-26', 1, 9),
(57, 215.00, '2024-06-27', 2, 19),
(58, 200.00, '2024-06-28', 3, 5),
(59, 195.00, '2024-06-29', 4, 24),
(60, 220.00, '2024-06-30', 5, 23);

-- --------------------------------------------------------

--
-- Structure de la table `budget`
--

CREATE TABLE `budget` (
  `id_budget` int NOT NULL,
  `budget_total` decimal(15,2) DEFAULT NULL,
  `depenses_organisation` decimal(15,2) DEFAULT NULL,
  `depenses_securite` decimal(15,2) DEFAULT NULL,
  `depenses_logistique` decimal(15,2) DEFAULT NULL,
  `depenses_infrastructures` decimal(15,2) DEFAULT NULL,
  `revenus_billetterie` decimal(15,2) DEFAULT NULL,
  `nombre_medailles_totals` int DEFAULT NULL,
  `cout_fabrication_medailles` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `budget`
--

INSERT INTO `budget` (`id_budget`, `budget_total`, `depenses_organisation`, `depenses_securite`, `depenses_logistique`, `depenses_infrastructures`, `revenus_billetterie`, `nombre_medailles_totals`, `cout_fabrication_medailles`) VALUES
(1, 4380000000.00, 500000000.00, 200000000.00, 150000000.00, 1400000000.00, 1000000000.00, 5084, 800000.00);

-- --------------------------------------------------------

--
-- Structure de la table `classement`
--

CREATE TABLE `classement` (
  `id_classement` int NOT NULL,
  `position_athlete` int DEFAULT NULL,
  `score` decimal(15,2) DEFAULT NULL,
  `temps_classement` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `classement`
--

INSERT INTO `classement` (`id_classement`, `position_athlete`, `score`, `temps_classement`) VALUES
(1, 1, 0.00, '00:46:31'),
(2, 2, 0.00, '00:47:02'),
(3, 1, 0.00, '01:05:01'),
(4, 1, 0.00, '52:51:54'),
(5, 3, 0.00, '00:47:58'),
(6, 1, 0.00, '01:05:01'),
(7, 2, 0.00, '09:25:15'),
(8, 1, 15.50, '00:00:00'),
(9, 1, 0.00, '00:11:05'),
(10, 1, 0.00, '03:52:59'),
(11, 1, 10.00, '00:00:00'),
(12, 2, 7.00, '00:00:00'),
(13, 1, 6.25, '00:00:00'),
(14, 1, 0.00, '00:57:33'),
(15, 2, 0.00, '00:58:34'),
(16, 3, 0.00, '00:58:50'),
(17, 4, 0.00, '00:59:07'),
(18, 5, 0.00, '00:59:10'),
(19, 1, 0.00, '00:59:44'),
(20, 1, 0.00, '01:03:05'),
(21, 1, 0.00, '00:16:32'),
(22, 1, 0.00, '00:16:40'),
(23, 1, 0.00, '00:16:47'),
(24, 1, 0.00, '00:16:52');

-- --------------------------------------------------------

--
-- Structure de la table `delegation`
--

CREATE TABLE `delegation` (
  `id_delegation` int NOT NULL,
  `nom_pays` varchar(50) DEFAULT NULL,
  `chef_de_mission` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `delegation`
--

INSERT INTO `delegation` (`id_delegation`, `nom_pays`, `chef_de_mission`) VALUES
(1, 'Afghanistan', 'Mohammad Amiri'),
(2, 'Afrique du Sud', 'Thabo Mokoena'),
(3, 'Albanie', 'Ilir Meta'),
(4, 'Algérie', 'Ahmed Ben Saïd'),
(5, 'Allemagne', 'Hans Müller'),
(6, 'Andorre', 'Pere López'),
(7, 'Angola', 'José Neto'),
(8, 'Antigua-et-Barbuda', 'Michael Grant'),
(9, 'Arabie Saoudite', 'Salem Al-Khaled'),
(10, 'Argentine', 'Luis Fernandez'),
(11, 'Arménie', 'Aram Petrosyan'),
(12, 'Australie', 'James O\'Connor'),
(13, 'Autriche', 'Franz Hauser'),
(14, 'Azerbaïdjan', 'Rashad Karimov'),
(15, 'Bahamas', 'Derrick Jones'),
(16, 'Bahreïn', 'Ali Bin Khalifa'),
(17, 'Bangladesh', 'Hasan Rahman'),
(18, 'Barbade', 'Sean Clarke'),
(19, 'Belgique', 'Sophie Verhoeven'),
(20, 'Belize', 'David Castillo'),
(21, 'Bénin', 'Emmanuel Yao'),
(22, 'Bhoutan', 'Sangay Dorji'),
(23, 'Biélorussie', 'Ivan Kostin'),
(24, 'Birmanie', 'Khin Zaw'),
(25, 'Bolivie', 'Carlos Luna'),
(26, 'Bosnie-Herzégovine', 'Nedim Kolar'),
(27, 'Botswana', 'Thato Mothusi'),
(28, 'Brésil', 'Ana Silva'),
(29, 'Brunei', 'Ahmad Jabir'),
(30, 'Bulgarie', 'Georgi Nikolov'),
(31, 'Burkina Faso', 'Issa Ouédraogo'),
(32, 'Burundi', 'Jean Ndayishimiye'),
(33, 'Cambodge', 'Sokha Pich'),
(34, 'Cameroun', 'Roger Tchani'),
(35, 'Canada', 'Pierre Tremblay'),
(36, 'Cap-Vert', 'Carlos dos Santos'),
(37, 'Chili', 'Juan Pablo Reyes'),
(38, 'Chine', 'Li Wei'),
(39, 'Chypre', 'Andreas Christou'),
(40, 'Colombie', 'Carlos Rodriguez'),
(41, 'Comores', 'Ali Said'),
(42, 'Congo', 'Basile Mwamba'),
(43, 'Corée du Nord', 'Kim Sung-ho'),
(44, 'Corée du Sud', 'Kim Min-ho'),
(45, 'Costa Rica', 'Esteban Solis'),
(46, 'Côte d\'Ivoire', 'Kouadio Traoré'),
(47, 'Croatie', 'Marko Kovac'),
(48, 'Cuba', 'Ernesto Perez'),
(49, 'Danemark', 'Niels Andersen'),
(50, 'Djibouti', 'Omar Idris'),
(51, 'Dominique', 'Samuel Johnson'),
(52, 'Égypte', 'Ahmed Mansour'),
(53, 'Émirats Arabes Unis', 'Nasser Al-Hashimi'),
(54, 'Équateur', 'Luis Morán'),
(55, 'Érythrée', 'Tesfaye Kidane'),
(56, 'Espagne', 'Carmen García'),
(57, 'Estonie', 'Kristjan Tamme'),
(58, 'Eswatini', 'Mandla Dlamini'),
(59, 'États-Unis', 'John Smith'),
(60, 'Éthiopie', 'Abebe Fekadu'),
(61, 'Fidji', 'Apenisa Cakobau'),
(62, 'Finlande', 'Antti Virtanen'),
(63, 'France', 'Marie Dupont'),
(64, 'Gabon', 'Albert Mboumba'),
(65, 'Gambie', 'Ousmane Jobe'),
(66, 'Géorgie', 'Zurab Khutsishvili'),
(67, 'Ghana', 'Yaw Asamoah'),
(68, 'Grèce', 'Nikos Papadopoulos'),
(69, 'Grenade', 'Calvin Peters'),
(70, 'Guatemala', 'Marco Díaz'),
(71, 'Guinée', 'Mamadi Camara'),
(72, 'Guinée-Bissau', 'Amilcar Lopes'),
(73, 'Guinée équatoriale', 'Miguel Obiang'),
(74, 'Guyana', 'Vishnu Persaud'),
(75, 'Haïti', 'Pierre-Louis Michel'),
(76, 'Honduras', 'Oscar Reyes'),
(77, 'Hongrie', 'Laszlo Toth'),
(78, 'Îles Cook', 'Teava Matai'),
(79, 'Îles Marshall', 'Tony Matayo'),
(80, 'Îles Salomon', 'Douglas Paru'),
(81, 'Inde', 'Ravi Kumar'),
(82, 'Indonésie', 'Budi Santoso'),
(83, 'Irak', 'Hassan Karim'),
(84, 'Iran', 'Mohammad Reza'),
(85, 'Irlande', 'Seamus O\'Brien'),
(86, 'Islande', 'Bjorn Jonsson'),
(87, 'Israël', 'Avi Cohen'),
(88, 'Italie', 'Luca Rossi'),
(89, 'Jamaïque', 'Derrick Brown'),
(90, 'Japon', 'Takashi Yamamoto'),
(91, 'Jordanie', 'Ahmad al-Taher'),
(92, 'Kazakhstan', 'Aidar Nursultanov'),
(93, 'Kenya', 'Mwangi Njoroge'),
(94, 'Kirghizistan', 'Azamat Abdrahmanov'),
(95, 'Kiribati', 'Tevita Tora'),
(96, 'Kosovo', 'Luan Shala'),
(97, 'Koweït', 'Nasser Al-Sabah'),
(98, 'Laos', 'Souk Somboun'),
(99, 'Lesotho', 'Motlalepula Mphafi'),
(100, 'Lettonie', 'Janis Berzins'),
(101, 'Liban', 'Nadim Abou Nader'),
(102, 'Libéria', 'Samuel Johnson'),
(103, 'Libye', 'Ali Mohammed'),
(104, 'Liechtenstein', 'Hans Vogt'),
(105, 'Lituanie', 'Mantas Pukis'),
(106, 'Luxembourg', 'Claude Muller'),
(107, 'Macédoine du Nord', 'Bojan Ivanovski'),
(108, 'Madagascar', 'Hery Randriamampionona'),
(109, 'Malaisie', 'Ali Osman'),
(110, 'Malawi', 'Daniel Banda'),
(111, 'Maldives', 'Ahmed Rasheed'),
(112, 'Mali', 'Seydou Keita'),
(113, 'Malte', 'Mario Farrugia'),
(114, 'Maroc', 'Rachid Bensaid'),
(115, 'Maurice', 'Ashwin Ramgoolam'),
(116, 'Mauritanie', 'Sidi Mohamed'),
(117, 'Mexique', 'José Hernandez'),
(118, 'Micronésie', 'Felix Nakamura'),
(119, 'Moldavie', 'Ion Popescu'),
(120, 'Monaco', 'Charles Grimaldi'),
(121, 'Mongolie', 'Temuujin Batjargal'),
(122, 'Monténégro', 'Marko Milic'),
(123, 'Mozambique', 'Carlos Mondlane'),
(124, 'Namibie', 'Petrus Nangolo'),
(125, 'Nauru', 'Marcus Kun'),
(126, 'Népal', 'Dawa Sherpa'),
(127, 'Nicaragua', 'Carlos Montalvan'),
(128, 'Niger', 'Abdoulaye Issa'),
(129, 'Nigeria', 'Chukwuemeka Nwosu'),
(130, 'Norvège', 'Lars Olsen'),
(131, 'Nouvelle-Zélande', 'Emma Clarke'),
(132, 'Oman', 'Salim Al-Rashdi'),
(133, 'Ouganda', 'Moses Kamya'),
(134, 'Ouzbékistan', 'Sherzod Karimov'),
(135, 'Pakistan', 'Imran Ali'),
(136, 'Palaos', 'Roman Ngirailur'),
(137, 'Panama', 'Jose Aguilar'),
(138, 'Papouasie-Nouvelle-Guinée', 'Peter Wingti'),
(139, 'Paraguay', 'Luis Gonzalez'),
(140, 'Pays-Bas', 'Jan de Vries'),
(141, 'Pérou', 'Carlos Ramirez'),
(142, 'Philippines', 'Jose Cruz'),
(143, 'Pologne', 'Adam Kowalski'),
(144, 'Portugal', 'João Santos'),
(145, 'Qatar', 'Fahad Al-Mansoori'),
(146, 'République Centrafricaine', 'Albert Yabada'),
(147, 'République Démocratique du Congo', 'Beni Kashama'),
(148, 'République Dominicaine', 'Carlos Guzman'),
(149, 'République Tchèque', 'Petr Novak'),
(150, 'Roumanie', 'Radu Popescu'),
(151, 'Royaume-Uni', 'Sarah Thompson'),
(152, 'Russie', 'Ivan Petrov'),
(153, 'Rwanda', 'Jean Habimana'),
(154, 'Saint-Kitts-et-Nevis', 'Leon Samuel'),
(155, 'Saint-Vincent-et-les-Grenadines', 'Samuel Joseph'),
(156, 'Sainte-Lucie', 'Luke Charles'),
(157, 'Salvador', 'Manuel Castro'),
(158, 'Samoa', 'Tuilaepa Malielegaoi'),
(159, 'Sénégal', 'Moussa Ndiaye'),
(160, 'Serbie', 'Nikola Markovic'),
(161, 'Seychelles', 'Michel Jean-Louis'),
(162, 'Sierra Leone', 'Joseph Kamara'),
(163, 'Singapour', 'Tan Wei'),
(164, 'Slovaquie', 'Jozef Fiala'),
(165, 'Slovénie', 'Andrej Zagar'),
(166, 'Somalie', 'Ali Farah'),
(167, 'Soudan', 'Omar Ahmed'),
(168, 'Soudan du Sud', 'Jacob Lado'),
(169, 'Sri Lanka', 'Lakshman Perera'),
(170, 'Suède', 'Emma Johansson'),
(171, 'Suisse', 'Adrian Meier'),
(172, 'Suriname', 'Ravi Jagessar'),
(173, 'Syrie', 'Hassan al-Khatib'),
(174, 'Tadjikistan', 'Kamil Bek'),
(175, 'Tanzanie', 'Mwita Mwambije'),
(176, 'Tchad', 'Abakar Mahamat'),
(177, 'Thaïlande', 'Somchai Thanasiri'),
(178, 'Timor oriental', 'Antonio Da Costa'),
(179, 'Togo', 'Koffi Mensah'),
(180, 'Tonga', 'Mate Ma\'a'),
(181, 'Trinité-et-Tobago', 'Keith Richards'),
(182, 'Tunisie', 'Ali Kacem'),
(183, 'Turkménistan', 'Serdar Orazov'),
(184, 'Turquie', 'Mehmet Yilmaz'),
(185, 'Tuvalu', 'Kitiona Tautu'),
(186, 'Ukraine', 'Oleksandr Ivanov'),
(187, 'Uruguay', 'Diego Perez'),
(188, 'Vanuatu', 'Jack Nalau'),
(189, 'Venezuela', 'Carlos Gonzalez'),
(190, 'Vietnam', 'Nguyen Van Phuc'),
(191, 'Yémen', 'Ahmed Abdullah'),
(192, 'Zambie', 'Chanda Mwamba'),
(193, 'Zimbabwe', 'Tendai Moyo'),
(194, 'Andorre', 'Marc Riera'),
(195, 'Anguilla', 'John Lake'),
(196, 'Aruba', 'Miguel Fortuné'),
(197, 'Bermudes', 'Elias Spencer'),
(198, 'Curaçao', 'Frank Maduro'),
(199, 'Dominique', 'Daniel Charles'),
(200, 'Guam', 'Peter Perez'),
(201, 'Kosovo', 'Arben Morina'),
(202, 'Macao', 'Wei Ming'),
(203, 'Monaco', 'Alain Roux'),
(204, 'Monténégro', 'Stefan Kovacevic'),
(205, 'Nouvelle-Calédonie', 'Jean-Louis Verdier'),
(206, 'Palaos', 'Roman Ngirailur'),
(207, 'Équipe olympique des réfugiés', 'Tegla Loroupe');

-- --------------------------------------------------------

--
-- Structure de la table `discipline`
--

CREATE TABLE `discipline` (
  `id_discipline` int NOT NULL,
  `nom_discipline` varchar(50) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `discipline`
--

INSERT INTO `discipline` (`id_discipline`, `nom_discipline`, `description`) VALUES
(1, 'Natation', 'Discipline olympique'),
(2, 'Athlétisme', 'Discipline olympique'),
(3, 'Basketball', 'Discipline olympique'),
(4, 'Tir à l\'arc', 'Discipline olympique'),
(5, 'Judo', 'Discipline olympique'),
(6, 'Boxe', 'Discipline olympique'),
(7, 'Cyclisme sur Piste', 'Discipline olympique'),
(8, 'Triathlon', 'Discipline olympique'),
(9, 'Volleyball', 'Discipline olympique'),
(11, 'Aviron', 'Discipline olympique'),
(12, 'Badminton', 'Discipline olympique'),
(14, 'Basketball ', 'Discipline olympique'),
(16, 'Breaking', 'Discipline olympique'),
(17, 'Canoë-Kayak Slalom', 'Discipline olympique'),
(18, 'Canoë-Kayak Sprint', 'Discipline olympique'),
(19, 'Cyclisme BMX Freestyle', 'Discipline olympique'),
(20, 'Cyclisme BMX Racing', 'Discipline olympique'),
(21, 'Cyclisme sur Route', 'Discipline olympique'),
(23, 'Escalade Sportive', 'Discipline olympique'),
(24, 'Escrime', 'Discipline olympique'),
(25, 'Football', 'Discipline olympique'),
(26, 'Golf', 'Discipline olympique'),
(27, 'Gymnastique Artistique', 'Discipline olympique'),
(28, 'Gymnastique Rythmique', 'Discipline olympique'),
(29, 'Haltérophilie', 'Discipline olympique'),
(30, 'Handball', 'Discipline olympique'),
(31, 'Hockey sur Gazon', 'Discipline olympique'),
(33, 'Karaté', 'Discipline olympique'),
(34, 'Lutte Libre', 'Discipline olympique'),
(35, 'Lutte Gréco-Romaine', 'Discipline olympique'),
(37, 'Natation Artistique', 'Discipline olympique'),
(38, 'Pentathlon Moderne', 'Discipline olympique'),
(39, 'Plongeon', 'Discipline olympique'),
(40, 'Rugby à 7', 'Discipline olympique'),
(41, 'Skateboard', 'Discipline olympique'),
(42, 'Surf', 'Discipline olympique'),
(43, 'Taekwondo', 'Discipline olympique'),
(44, 'Tennis', 'Discipline olympique'),
(45, 'Tennis de Table', 'Discipline olympique'),
(46, 'Tir', 'Discipline olympique'),
(48, 'Trampoline', 'Discipline olympique'),
(50, 'Voile', 'Discipline olympique'),
(52, 'Water-Polo', 'Discipline olympique'),
(53, 'Para athlétisme', 'Discipline paralympique'),
(54, 'Para aviron', 'Discipline paralympique'),
(55, 'Para badminton', 'Discipline paralympique'),
(56, 'Basket-ball en fauteuil roulant', 'Discipline paralympique'),
(57, 'Boccia', 'Discipline paralympique'),
(58, 'Para canoë', 'Discipline paralympique'),
(59, 'Cyclisme sur route', 'Discipline paralympique'),
(60, 'Cyclisme sur piste', 'Discipline paralympique'),
(61, 'Escrime en fauteuil roulant', 'Discipline paralympique'),
(62, 'Football à 5 (cécifoot)', 'Discipline paralympique'),
(63, 'Goalball', 'Discipline paralympique'),
(64, 'Para haltérophilie', 'Discipline paralympique'),
(65, 'Judo', 'Discipline paralympique'),
(66, 'Para natation', 'Discipline paralympique'),
(67, 'Para taekwondo', 'Discipline paralympique'),
(68, 'Para tennis de table', 'Discipline paralympique'),
(69, 'Para tir', 'Discipline paralympique'),
(70, 'Para tir à l\'arc', 'Discipline paralympique'),
(71, 'Para triathlon', 'Discipline paralympique'),
(72, 'Rugby en fauteuil roulant', 'Discipline paralympique'),
(73, 'Para équitation (dressage)', 'Discipline paralympique'),
(74, 'Volley-ball assis', 'Discipline paralympique'),
(75, 'Tennis', 'Discipline olympique');

-- --------------------------------------------------------

--
-- Structure de la table `encadrer`
--

CREATE TABLE `encadrer` (
  `id_athlete` int NOT NULL,
  `id_entraineur` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `encadrer`
--

INSERT INTO `encadrer` (`id_athlete`, `id_entraineur`) VALUES
(1, 1),
(6, 2),
(12, 2),
(13, 3),
(30, 3),
(45, 3),
(5, 8),
(20, 10),
(46, 10),
(3, 14),
(7, 25),
(40, 30),
(2, 31),
(9, 32),
(23, 33),
(44, 34),
(43, 35),
(42, 36),
(41, 37),
(4, 38),
(9, 39);

-- --------------------------------------------------------

--
-- Structure de la table `entraineur`
--

CREATE TABLE `entraineur` (
  `id_entraineur` int NOT NULL,
  `nom_entraineur` varchar(50) DEFAULT NULL,
  `prenom_entraineur` varchar(50) DEFAULT NULL,
  `specialite_entraineur` varchar(50) DEFAULT NULL,
  `nationalite_entraineur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `entraineur`
--

INSERT INTO `entraineur` (`id_entraineur`, `nom_entraineur`, `prenom_entraineur`, `specialite_entraineur`, `nationalite_entraineur`) VALUES
(1, 'Pellerin', 'Nicolas', 'Natation', 'France'),
(2, 'Durden', 'Gregg', 'Natation', 'États-Unis'),
(3, 'Bohl', 'Chris', 'Natation', 'Australie'),
(4, 'Gemmel', 'Bruce', 'Natation', 'États-Unis'),
(5, 'Schumacher', 'David', 'Natation', 'Roumanie'),
(6, 'Bohl', 'Peter', 'Natation', 'Australie'),
(7, 'Zelinski', 'Andrey', 'Natation', 'Russie'),
(8, 'Johansson', 'Carl', 'Athlétisme', 'Suède'),
(9, 'Morini', 'Stefano', 'Athlétisme ', 'Italie'),
(10, 'Boxall', 'Dean', 'Natation', 'Australie'),
(11, 'Turi', 'Attila', 'Natation', 'Hongrie'),
(12, 'Melville', 'Mel', 'Natation', 'Royaume-Uni'),
(13, 'Hirai', 'Norimasa', 'Natation', 'Japon'),
(14, 'Chow', 'Cecile', 'Gymnastique', 'États-Unis'),
(15, 'Waddell', 'Becky', 'Natation', 'Canada'),
(16, 'Fong', 'Daryl', 'Natation', 'Hong Kong'),
(17, 'Van Hooren', 'Martin', 'Natation', 'Pays-Bas'),
(18, 'Lopez', 'Carlos', 'Natation', 'Espagne'),
(19, 'Drozdev', 'Sergei', 'Natation', 'Russie'),
(20, 'Cotterell', 'Michael', 'Natation', 'Australie'),
(21, 'Smith', 'Simon', 'Haltérophilie', 'Nouvelle-Zélande'),
(22, 'Francis', 'Stephen', 'Athlétisme', 'Jamaïque'),
(23, 'Alnes', 'Leif Olav', 'Athlétisme', 'Norvège'),
(24, 'Gjert', 'Ingebrigtsen', 'Athlétisme', 'Norvège'),
(25, 'Davis', 'Dennis', 'Athlétisme', 'États-Unis'),
(26, 'Boldon', 'Ato', 'Athlétisme', 'États-Unis'),
(27, 'Koech', 'Japhet', 'Athlétisme', 'Kenya'),
(28, 'Browning', 'Glenroy', 'Athlétisme', 'Canada'),
(29, 'Souza', 'Everson', 'Athlétisme', 'Brésil'),
(30, 'Sang', 'Patrick', 'Athlétisme', 'Kenya'),
(31, 'Dupont', 'Marc', 'Judo', 'France'),
(32, 'Smith', 'John', 'Basketball', 'États-Unis'),
(33, 'Hirai', 'Norimasa', 'Natation', 'Japon'),
(34, 'Bianchi', 'Luca', 'Tennis', 'Italie'),
(35, 'Lemoine', 'Pierre', 'Athlétisme', 'France'),
(36, 'Martin', 'Julien', 'Athlétisme', 'France'),
(37, 'Dupuis', 'Jean-Paul', 'Athlétisme', 'France'),
(38, 'Petrovic', 'Milan', 'Tennis', 'Serbie'),
(39, 'Green', 'Alex', 'Basketball', 'États-Unis');

-- --------------------------------------------------------

--
-- Structure de la table `epreuve`
--

CREATE TABLE `epreuve` (
  `id_epreuve` int NOT NULL,
  `nom_epreuve` varchar(50) DEFAULT NULL,
  `date_epreuve` date DEFAULT NULL,
  `heure_epreuve` time DEFAULT NULL,
  `id_discipline` int NOT NULL,
  `id_evenement` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `epreuve`
--

INSERT INTO `epreuve` (`id_epreuve`, `nom_epreuve`, `date_epreuve`, `heure_epreuve`, `id_discipline`, `id_evenement`) VALUES
(1, 'Cérémonie d\'ouverture', '2024-07-26', '20:00:00', 9, 1),
(2, '100 m nage libre hommes', '2024-07-27', '10:00:00', 1, 2),
(3, '100 m nage libre femmes', '2024-07-27', '10:30:00', 1, 2),
(4, '200 m papillon hommes', '2024-07-28', '10:00:00', 1, 2),
(5, '200 m papillon femmes', '2024-07-28', '10:30:00', 1, 2),
(6, '4 x 100 m relais nage libre hommes', '2024-07-29', '11:00:00', 1, 2),
(7, '4 x 100 m relais nage libre femmes', '2024-07-29', '11:30:00', 1, 2),
(8, 'Marathon hommes', '2024-08-01', '07:00:00', 2, 3),
(9, 'Marathon femmes', '2024-08-02', '07:00:00', 2, 3),
(10, '100 m sprint hommes', '2024-08-03', '18:00:00', 2, 3),
(11, '100 m sprint femmes', '2024-08-04', '18:00:00', 2, 3),
(12, 'Saut en longueur hommes', '2024-08-05', '09:00:00', 2, 3),
(13, 'Saut en longueur femmes', '2024-08-06', '09:00:00', 2, 3),
(14, 'Finale de Basketball hommes', '2024-08-10', '20:00:00', 3, 4),
(15, 'Finale de Basketball femmes', '2024-08-10', '17:00:00', 3, 4),
(16, '100 m dos Femme', '2024-07-27', '10:00:00', 1, 2),
(17, '200 m quatre nages femmes', '2024-07-29', '11:00:00', 1, 2),
(18, '100 m brasse femmes', '2024-07-27', '09:00:00', 1, 2),
(19, 'Tir à l\'arc individuel hommes', '2024-07-28', '14:00:00', 4, 11),
(20, 'Tir à l\'arc individuel femmes', '2024-07-28', '15:00:00', 4, 11),
(21, '73 kg Judo hommes', '2024-07-29', '12:00:00', 5, 10),
(22, '57 kg Judo femmes', '2024-07-29', '13:00:00', 5, 10),
(23, 'Boxe 57 kg hommes', '2024-07-30', '11:00:00', 6, 13),
(24, 'Boxe 51 kg femmes', '2024-07-30', '12:00:00', 6, 13),
(25, '500 m sprint hommes', '2024-07-27', '08:00:00', 7, 7),
(26, 'Relais mixte triathlon', '2024-08-09', '15:00:00', 8, 3),
(27, 'Relais 4 x 400 m hommes', '2024-08-10', '19:00:00', 2, 3),
(28, 'Relais 4 x 400 m femmes', '2024-08-10', '19:30:00', 2, 3),
(29, '10 000 m hommes', '2024-08-01', '17:00:00', 2, 3),
(30, 'Cérémonie de clôture', '2024-08-11', '20:00:00', 9, 30),
(31, 'Relais mixte triathlon', '2024-08-09', '15:00:00', 8, 3),
(32, 'Relais 4 x 400 m hommes', '2024-08-10', '19:00:00', 2, 3),
(33, 'Relais 4 x 400 m femmes', '2024-08-10', '19:30:00', 2, 3),
(34, '10 000 m hommes', '2024-08-01', '17:00:00', 2, 3),
(35, 'Cérémonie de clôture', '2024-08-11', '20:00:00', 9, 30),
(36, 'Finale de Gymnastique Artistique - Sol Femme', '2024-08-03', '10:00:00', 27, 6),
(37, 'Finale de Tennis hommes', '2024-08-10', '15:00:00', 44, 31),
(38, 'Finale de Tennis femmes', '2024-08-10', '12:00:00', 44, 31),
(39, 'Finale du 200 m hommes', '2024-08-04', '18:30:00', 2, 3),
(40, 'Finale du saut en hauteur femmes', '2024-08-05', '17:00:00', 2, 3),
(41, 'Finale du lancer du javelot hommes', '2024-08-06', '16:00:00', 2, 3),
(42, 'Finale du saut en longueur femmes', '2024-08-06', '15:00:00', 2, 3),
(43, 'Finale 400 m nage libre hommes', '2024-07-28', '10:00:00', 1, 2),
(44, 'Finale 800 m nage libre femmes', '2024-07-29', '10:00:00', 1, 2),
(45, 'Relais 4 x 100 m nage libre femmes', '2024-07-30', '09:30:00', 1, 2),
(46, 'Relais 4 x 100 m 4 nages hommes', '2024-07-31', '10:00:00', 1, 2),
(47, 'Judo - Finales poids lourds hommes', '2024-08-01', '14:00:00', 5, 10),
(48, 'Judo - Finales Mixte ', '2024-08-02', '14:00:00', 5, 10),
(49, 'Finale Basketball hommes', '2024-08-09', '20:00:00', 3, 4),
(50, 'Finale Basketball femmes', '2024-08-10', '17:00:00', 3, 4),
(51, 'Saut à la perche', '2024-07-05', '16:40:00', 2, 3),
(52, '100 m T53 femmes (course en fauteuil roulant)', '2024-08-27', '15:00:00', 2, 32),
(53, '50 m nage libre S9 hommes', '2024-08-29', '14:00:00', 1, 33);

-- --------------------------------------------------------

--
-- Structure de la table `equipe`
--

CREATE TABLE `equipe` (
  `id_equipe` int NOT NULL,
  `nom_equipe` varchar(50) DEFAULT NULL,
  `id_discipline` int NOT NULL,
  `id_delegation` int NOT NULL,
  `id_type_equipe` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `equipe`
--

INSERT INTO `equipe` (`id_equipe`, `nom_equipe`, `id_discipline`, `id_delegation`, `id_type_equipe`) VALUES
(1, 'FR', 1, 63, 1),
(2, 'FR', 1, 63, 2),
(3, 'US', 14, 59, 1),
(4, 'US', 2, 59, 2),
(5, 'CA', 3, 35, 1),
(6, 'CA', 3, 35, 2),
(7, 'JP', 5, 90, 1),
(8, 'JP', 1, 90, 2),
(9, 'BR', 9, 28, 1),
(10, 'BR', 9, 28, 2),
(11, 'CN', 4, 38, 1),
(12, 'CN', 2, 38, 2),
(13, 'KE', 2, 93, 1),
(14, 'KE', 2, 93, 2),
(15, 'GB', 7, 151, 1),
(16, 'GB', 7, 151, 2),
(17, 'ZA', 31, 2, 1),
(18, 'ZA', 31, 2, 2),
(19, 'AR', 25, 10, 1),
(20, 'AR', 25, 10, 2),
(21, 'AU', 40, 12, 1),
(22, 'AU', 1, 12, 2),
(23, 'RU', 23, 152, 1),
(24, 'RU', 23, 152, 2),
(25, 'EG', 53, 52, 1),
(26, 'EG', 53, 52, 2),
(27, 'IN', 12, 81, 1),
(28, 'IN', 12, 81, 2),
(29, 'IT', 44, 88, 1),
(30, 'IT', 27, 88, 2),
(31, 'NL', 7, 140, 1),
(32, 'ROU', 1, 150, 1),
(33, 'KEN', 2, 93, 1),
(34, 'KEN', 2, 93, 2),
(35, 'FR', 5, 1, 3),
(36, 'FR', 5, 63, 3),
(37, 'POL', 2, 143, 1),
(38, 'RS', 44, 160, 1),
(39, 'UK', 2, 151, 2),
(40, 'US', 1, 59, 1),
(41, 'US', 27, 59, 2),
(42, 'US', 1, 59, 1);

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE `evenement` (
  `id_evenement` int NOT NULL,
  `nom_evenement` varchar(50) DEFAULT NULL,
  `type_evenement` varchar(50) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `id_budget` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `evenement`
--

INSERT INTO `evenement` (`id_evenement`, `nom_evenement`, `type_evenement`, `date_debut`, `date_fin`, `id_budget`) VALUES
(1, 'Cérémonie d\'Ouverture Olympique', 'Olympique', '2024-07-26', '2024-07-26', 1),
(2, 'Compétition de Natation', 'Olympique', '2024-07-27', '2024-08-04', 1),
(3, 'Compétition d\'Athlétisme', 'Olympique', '2024-08-01', '2024-08-11', 1),
(4, 'Tournoi de Basket-Ball', 'Olympique', '2024-07-27', '2024-08-10', 1),
(5, 'Finale de Football', 'Olympique', '2024-08-09', '2024-08-09', 1),
(6, 'Compétition de Gymnastique Artistique', 'Olympique', '2024-07-27', '2024-08-05', 1),
(7, 'Compétition de Cyclisme sur Route', 'Olympique', '2024-07-27', '2024-07-28', 1),
(8, 'Compétition de Tennis', 'Olympique', '2024-07-27', '2024-08-04', 1),
(9, 'Compétition d\'Escrime', 'Olympique', '2024-07-27', '2024-08-04', 1),
(10, 'Compétition de Judo', 'Olympique', '2024-07-27', '2024-08-02', 1),
(11, 'Compétition de Tir à l\'Arc', 'Olympique', '2024-07-27', '2024-08-02', 1),
(12, 'Compétition de Plongeon', 'Olympique', '2024-07-27', '2024-08-10', 1),
(13, 'Compétition de Boxe', 'Olympique', '2024-07-27', '2024-08-10', 1),
(14, 'Compétition d\'Haltérophilie', 'Olympique', '2024-07-27', '2024-08-05', 1),
(15, 'Compétition de Lutte', 'Olympique', '2024-08-05', '2024-08-11', 1),
(16, 'Compétition de Taekwondo', 'Olympique', '2024-07-27', '2024-07-30', 1),
(17, 'Compétition de Badminton', 'Olympique', '2024-07-27', '2024-08-05', 1),
(18, 'Compétition de Tennis de Table', 'Olympique', '2024-07-27', '2024-08-05', 1),
(19, 'Compétition de Volleyball', 'Olympique', '2024-07-27', '2024-08-11', 1),
(20, 'Compétition de Handball', 'Olympique', '2024-07-27', '2024-08-11', 1),
(21, 'Compétition de Hockey sur Gazon', 'Olympique', '2024-07-27', '2024-08-09', 1),
(22, 'Compétition de Rugby à 7', 'Olympique', '2024-07-27', '2024-07-31', 1),
(23, 'Compétition de Golf', 'Olympique', '2024-08-01', '2024-08-10', 1),
(24, 'Compétition de Natation Artistique', 'Olympique', '2024-08-05', '2024-08-10', 1),
(25, 'Compétition de Water-Polo', 'Olympique', '2024-07-27', '2024-08-11', 1),
(26, 'Compétition de Canoë-Kayak Slalom', 'Olympique', '2024-07-27', '2024-07-31', 1),
(27, 'Compétition de Canoë-Kayak Sprint', 'Olympique', '2024-08-03', '2024-08-10', 1),
(28, 'Compétition d\'Aviron', 'Olympique', '2024-07-27', '2024-08-03', 1),
(29, 'Compétition de Voile', 'Olympique', '2024-07-27', '2024-08-05', 1),
(30, 'Cérémonie de Clôture Olympique', 'Olympique', '2024-08-11', '2024-08-11', 1),
(31, 'Tournoi de Tennis', 'Olympique', '2024-08-05', '2024-08-10', 1),
(32, 'Compétition d\'Athlétisme', 'Paralympique', '2024-08-27', '2024-08-28', 1),
(33, 'Compétition de natation', 'Paralympique', '2024-08-29', '2024-08-30', 1);

-- --------------------------------------------------------

--
-- Structure de la table `finance`
--

CREATE TABLE `finance` (
  `id_budget` int NOT NULL,
  `id_sponsor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `finance`
--

INSERT INTO `finance` (`id_budget`, `id_sponsor`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25);

-- --------------------------------------------------------

--
-- Structure de la table `inclure`
--

CREATE TABLE `inclure` (
  `id_discipline` int NOT NULL,
  `id_type_epreuve` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `inclure`
--

INSERT INTO `inclure` (`id_discipline`, `id_type_epreuve`) VALUES
(1, 1),
(2, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(11, 1),
(12, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(23, 1),
(24, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(33, 1),
(34, 1),
(35, 1),
(37, 1),
(38, 1),
(39, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(48, 1),
(50, 1),
(53, 1),
(54, 1),
(55, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(73, 1),
(75, 1),
(1, 2),
(2, 2),
(3, 2),
(7, 2),
(8, 2),
(9, 2),
(11, 2),
(12, 2),
(14, 2),
(24, 2),
(25, 2),
(30, 2),
(31, 2),
(40, 2),
(44, 2),
(45, 2),
(50, 2),
(52, 2),
(56, 2),
(62, 2),
(72, 2),
(74, 2),
(75, 2);

-- --------------------------------------------------------

--
-- Structure de la table `participer`
--

CREATE TABLE `participer` (
  `id_athlete` int NOT NULL,
  `id_epreuve` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `participer`
--

INSERT INTO `participer` (`id_athlete`, `id_epreuve`) VALUES
(1, 2),
(12, 2),
(6, 7),
(7, 10),
(9, 14),
(13, 16),
(20, 16),
(23, 16),
(30, 16),
(46, 16),
(45, 17),
(3, 36),
(4, 37),
(44, 37),
(2, 48),
(41, 48),
(42, 48),
(43, 48),
(5, 51);

-- --------------------------------------------------------

--
-- Structure de la table `resultat`
--

CREATE TABLE `resultat` (
  `id_resultat` int NOT NULL,
  `medaille` varchar(50) DEFAULT NULL,
  `position_` int DEFAULT NULL,
  `id_classement` int NOT NULL,
  `id_athlete` int DEFAULT NULL,
  `id_equipe` int DEFAULT NULL,
  `id_type_resultat` int NOT NULL,
  `id_epreuve` int NOT NULL,
  `id_session` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `resultat`
--

INSERT INTO `resultat` (`id_resultat`, `medaille`, `position_`, `id_classement`, `id_athlete`, `id_equipe`, `id_type_resultat`, `id_epreuve`, `id_session`) VALUES
(1, 'OR', 1, 1, 1, 1, 1, 2, 2),
(2, 'ARGENT', 2, 2, 12, 42, 1, 2, 2),
(3, 'OR', 1, 8, 3, 41, 1, 36, 15),
(4, 'OR', 1, 4, 4, 38, 6, 37, 21),
(6, 'OR', 1, 6, 6, 40, 1, 4, 4),
(7, 'ARGENT', 2, 7, 7, 33, 1, 10, 12),
(9, 'Or', 1, 9, 9, 3, 2, 14, 16),
(11, 'Or', 1, 12, 2, 36, 2, 48, 23),
(12, 'Or', 1, 12, 41, 36, 2, 48, 23),
(13, 'Or', 1, 12, 42, 36, 2, 48, 23),
(14, 'Or', 1, 12, 43, 36, 2, 48, 23),
(37, 'Or', 1, 4, 5, 37, 4, 51, 24),
(38, 'OR', 1, 1, 1, 1, 3, 2, 2),
(39, 'OR', 1, 8, 3, 41, 3, 36, 15),
(40, 'Or', 1, 4, 5, 37, 5, 51, 24),
(41, 'Argent', 2, 4, 44, 29, 1, 37, 21),
(42, 'Or', 1, 14, 13, 22, 4, 16, 5),
(43, 'Or', 1, 14, 13, 22, 6, 16, 5),
(44, 'Argent', 2, 15, 20, 22, 1, 16, 5),
(45, 'Bronze', 3, 16, 23, 8, 1, 16, 5),
(46, 'Bronze', 3, 16, 23, 8, 6, 16, 5),
(47, NULL, 4, 17, 30, 22, 1, 16, 5),
(48, NULL, 5, 18, 46, 22, 1, 16, 5),
(49, 'Or', 1, 19, 45, 22, 4, 17, 19),
(50, 'Or', 1, 19, 45, 22, 5, 17, 19),
(51, 'Or', 1, 20, 13, 22, 2, 7, 9),
(52, 'Or', 1, 20, 20, 22, 2, 7, 9),
(53, 'Or', 1, 20, 45, 22, 2, 7, 9),
(54, 'Or', 1, 20, 46, 22, 2, 7, 9),
(55, 'Or', 1, 21, 47, 39, 1, 52, 25),
(56, 'Or', 1, 21, 47, 39, 3, 52, 25),
(57, 'Argent', 2, 22, 48, 12, 1, 52, 25),
(58, 'Bronze', 3, 23, 49, 39, 1, 52, 25),
(59, NULL, 4, 24, 50, 4, 1, 52, 25);

-- --------------------------------------------------------

--
-- Structure de la table `session`
--

CREATE TABLE `session` (
  `id_session` int NOT NULL,
  `numero_session` int DEFAULT NULL,
  `heure_debut` time DEFAULT NULL,
  `heure_fin` time DEFAULT NULL,
  `id_site` int NOT NULL,
  `id_epreuve` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `session`
--

INSERT INTO `session` (`id_session`, `numero_session`, `heure_debut`, `heure_fin`, `id_site`, `id_epreuve`) VALUES
(1, 1, '20:00:00', '22:00:00', 1, 1),
(2, 2, '10:00:00', '10:15:00', 2, 2),
(3, 1, '18:00:00', '18:10:00', 2, 2),
(4, 2, '10:30:00', '10:45:00', 2, 4),
(5, 1, '18:30:00', '18:40:00', 2, 16),
(6, 3, '10:00:00', '10:10:00', 2, 4),
(7, 3, '10:30:00', '10:40:00', 2, 5),
(8, 1, '11:00:00', '11:15:00', 2, 6),
(9, 1, '11:30:00', '11:45:00', 2, 7),
(10, 0, '07:00:00', '10:30:00', 3, 8),
(11, 0, '07:00:00', '10:30:00', 3, 9),
(12, 2, '18:00:00', '18:10:00', 1, 10),
(13, 1, '18:30:00', '18:40:00', 1, 11),
(14, 3, '09:00:00', '10:30:00', 1, 12),
(15, 1, '14:00:00', '15:30:00', 1, 36),
(16, 1, '20:00:00', '22:00:00', 4, 14),
(17, 1, '17:00:00', '19:00:00', 4, 15),
(18, 1, '10:00:00', '10:05:00', 2, 16),
(19, 1, '11:00:00', '11:15:00', 2, 17),
(20, 1, '09:00:00', '09:05:00', 2, 18),
(21, 3, '14:00:00', '15:30:00', 5, 37),
(22, 1, '17:00:00', '18:00:00', 5, 20),
(23, 2, '12:00:00', '13:30:00', 6, 48),
(24, 1, '13:30:00', '14:00:00', 6, 51),
(25, 2, '11:00:00', '11:30:00', 7, 52),
(26, 1, '20:00:00', '20:30:00', 7, 24),
(27, 3, '08:00:00', '08:05:00', 8, 25),
(28, 1, '15:00:00', '17:00:00', 3, 26),
(29, 1, '19:00:00', '19:20:00', 1, 27),
(30, 1, '19:30:00', '19:50:00', 1, 28),
(31, 1, '20:00:00', '22:00:00', 1, 30),
(32, 1, '10:00:00', '12:00:00', 8, 36);

-- --------------------------------------------------------

--
-- Structure de la table `site`
--

CREATE TABLE `site` (
  `id_site` int NOT NULL,
  `nom_site` varchar(50) DEFAULT NULL,
  `adresse_site` varchar(50) DEFAULT NULL,
  `capacite_site` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `site`
--

INSERT INTO `site` (`id_site`, `nom_site`, `adresse_site`, `capacite_site`) VALUES
(1, 'Stade de France', 'Saint-Denis, Paris', 80000),
(2, 'Centre Aquatique', 'Saint-Denis, Paris', 15000),
(3, 'Parcours à travers Paris', 'Champs-Élysées, Paris', NULL),
(4, 'Accor Arena', 'Bercy, Paris', 20300),
(5, 'Esplanade des Invalides', '7ème arrondissement, Paris', 8000),
(6, 'Champ de Mars Arena', 'Champ de Mars, Paris', 10000),
(7, 'Grand Palais', 'Champs-Élysées, Paris', 9000),
(8, 'Vélodrome National', 'Saint-Quentin-en-Yvelines', 5000);

-- --------------------------------------------------------

--
-- Structure de la table `spectateur`
--

CREATE TABLE `spectateur` (
  `id_spectateur` int NOT NULL,
  `nom_spectateur` varchar(50) DEFAULT NULL,
  `prenom_spectateur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `spectateur`
--

INSERT INTO `spectateur` (`id_spectateur`, `nom_spectateur`, `prenom_spectateur`) VALUES
(1, 'Dupont', 'Jean'),
(2, 'Martin', 'Sophie'),
(3, 'Bernard', 'Paul'),
(4, 'Leroy', 'Marie'),
(5, 'Morel', 'Luc'),
(6, 'Roux', 'Emma'),
(7, 'Fournier', 'Louis'),
(8, 'Girard', 'Alice'),
(9, 'Bonnet', 'Maxime'),
(10, 'Durand', 'Julie'),
(11, 'Simon', 'Hugo'),
(12, 'Renard', 'Clara'),
(13, 'Lambert', 'Nicolas'),
(14, 'Blanc', 'Laura'),
(15, 'Garnier', 'Lucas'),
(16, 'Henry', 'Camille'),
(17, 'Masson', 'Thomas'),
(18, 'Picard', 'Sarah'),
(19, 'Marchand', 'Antoine'),
(20, 'Perret', 'Lucie'),
(21, 'Perrin', 'Emma'),
(22, 'Leblanc', 'Matthieu'),
(23, 'Gauthier', 'Chloé'),
(24, 'Morin', 'Alexandre'),
(25, 'Noel', 'Elodie'),
(26, 'Carpentier', 'Benoît'),
(27, 'Rodriguez', 'Inès'),
(28, 'Boulanger', 'Etienne'),
(29, 'Chevalier', 'Anna'),
(30, 'Vidal', 'Manon'),
(31, 'Martin', 'Jean'),
(32, 'Dubois', 'Marie'),
(33, 'Durand', 'Louis'),
(34, 'Moreau', 'Sophie'),
(35, 'Lefevre', 'Pierre'),
(36, 'Garcia', 'Isabelle'),
(37, 'Bernard', 'Luc'),
(38, 'Petit', 'Emma'),
(39, 'Roux', 'Paul'),
(40, 'Fournier', 'Julie'),
(41, 'Morel', 'Lucas'),
(42, 'Girard', 'Elodie'),
(43, 'Andre', 'Antoine'),
(44, 'Lemoine', 'Camille'),
(45, 'Renaud', 'Sarah'),
(46, 'Marchand', 'Leo'),
(47, 'Robert', 'Alice'),
(48, 'Simon', 'Nicolas'),
(49, 'Laurent', 'Caroline'),
(50, 'Perrin', 'David');

-- --------------------------------------------------------

--
-- Structure de la table `sponsor`
--

CREATE TABLE `sponsor` (
  `id_sponsor` int NOT NULL,
  `nom_sponsor` varchar(50) DEFAULT NULL,
  `montant_sponsor` decimal(15,2) DEFAULT NULL,
  `type_sponsoring` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `sponsor`
--

INSERT INTO `sponsor` (`id_sponsor`, `nom_sponsor`, `montant_sponsor`, `type_sponsoring`) VALUES
(1, 'Airbnb', 50000000.00, 'Partenaire Olympique Mondial'),
(2, 'Alibaba', 50000000.00, 'Partenaire Olympique Mondial'),
(3, 'Allianz', 50000000.00, 'Partenaire Olympique Mondial'),
(4, 'Atos', 50000000.00, 'Partenaire Olympique Mondial'),
(5, 'Bridgestone', 50000000.00, 'Partenaire Olympique Mondial'),
(6, 'Coca-Cola', 50000000.00, 'Partenaire Olympique Mondial'),
(7, 'Deloitte', 50000000.00, 'Partenaire Olympique Mondial'),
(8, 'Intel', 50000000.00, 'Partenaire Olympique Mondial'),
(9, 'Omega', 50000000.00, 'Partenaire Olympique Mondial'),
(10, 'Panasonic', 50000000.00, 'Partenaire Olympique Mondial'),
(11, 'Procter & Gamble', 50000000.00, 'Partenaire Olympique Mondial'),
(12, 'Samsung', 50000000.00, 'Partenaire Olympique Mondial'),
(13, 'Toyota', 50000000.00, 'Partenaire Olympique Mondial'),
(14, 'Visa', 50000000.00, 'Partenaire Olympique Mondial'),
(15, 'EDF', 30000000.00, 'Partenaire Premium'),
(16, 'Accor', 30000000.00, 'Partenaire Premium'),
(17, 'Orange', 30000000.00, 'Partenaire Premium'),
(18, 'Carrefour', 30000000.00, 'Partenaire Premium'),
(19, 'LVMH', 30000000.00, 'Partenaire Premium'),
(20, 'La Poste', 20000000.00, 'Partenaire Officiel'),
(21, 'FDJ', 20000000.00, 'Partenaire Officiel'),
(22, 'Sanofi', 20000000.00, 'Partenaire Officiel'),
(23, 'PwC', 20000000.00, 'Partenaire Officiel'),
(24, 'Caisse d’Épargne', 20000000.00, 'Partenaire Officiel'),
(25, 'Westfield', 10000000.00, 'Supporteur Officiel');

-- --------------------------------------------------------

--
-- Structure de la table `type_epreuve`
--

CREATE TABLE `type_epreuve` (
  `id_type_epreuve` int NOT NULL,
  `nom_type_epreuve` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type_epreuve`
--

INSERT INTO `type_epreuve` (`id_type_epreuve`, `nom_type_epreuve`) VALUES
(1, 'Individuel'),
(2, 'Équipe');

-- --------------------------------------------------------

--
-- Structure de la table `Type_Equipe`
--

CREATE TABLE `Type_Equipe` (
  `id_type_equipe` int NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `Type_Equipe`
--

INSERT INTO `Type_Equipe` (`id_type_equipe`, `type`) VALUES
(1, 'HOMME'),
(2, 'FEMME'),
(3, 'MIXTE');

-- --------------------------------------------------------

--
-- Structure de la table `type_resultat`
--

CREATE TABLE `type_resultat` (
  `id_type_resultat` int NOT NULL,
  `nom_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type_resultat`
--

INSERT INTO `type_resultat` (`id_type_resultat`, `nom_type`) VALUES
(1, 'Individuel'),
(2, 'Équipe'),
(3, 'Record Olympique'),
(4, 'Record du Monde'),
(5, 'Meilleure Performance de la Saison'),
(6, 'Record Personnel');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `assister`
--
ALTER TABLE `assister`
  ADD PRIMARY KEY (`id_session`,`id_spectateur`),
  ADD KEY `id_spectateur` (`id_spectateur`);

--
-- Index pour la table `athlete`
--
ALTER TABLE `athlete`
  ADD PRIMARY KEY (`id_athlete`);

--
-- Index pour la table `billet`
--
ALTER TABLE `billet`
  ADD PRIMARY KEY (`id_billet`),
  ADD KEY `id_spectateur` (`id_spectateur`),
  ADD KEY `id_session` (`id_session`);

--
-- Index pour la table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`id_budget`);

--
-- Index pour la table `classement`
--
ALTER TABLE `classement`
  ADD PRIMARY KEY (`id_classement`);

--
-- Index pour la table `delegation`
--
ALTER TABLE `delegation`
  ADD PRIMARY KEY (`id_delegation`);

--
-- Index pour la table `discipline`
--
ALTER TABLE `discipline`
  ADD PRIMARY KEY (`id_discipline`);

--
-- Index pour la table `encadrer`
--
ALTER TABLE `encadrer`
  ADD PRIMARY KEY (`id_athlete`,`id_entraineur`),
  ADD KEY `id_entraineur` (`id_entraineur`);

--
-- Index pour la table `entraineur`
--
ALTER TABLE `entraineur`
  ADD PRIMARY KEY (`id_entraineur`);

--
-- Index pour la table `epreuve`
--
ALTER TABLE `epreuve`
  ADD PRIMARY KEY (`id_epreuve`),
  ADD KEY `id_discipline` (`id_discipline`),
  ADD KEY `id_evenement` (`id_evenement`);

--
-- Index pour la table `equipe`
--
ALTER TABLE `equipe`
  ADD PRIMARY KEY (`id_equipe`),
  ADD KEY `id_discipline` (`id_discipline`),
  ADD KEY `id_delegation` (`id_delegation`),
  ADD KEY `fk_type_equipe` (`id_type_equipe`);

--
-- Index pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id_evenement`),
  ADD KEY `id_budget` (`id_budget`);

--
-- Index pour la table `finance`
--
ALTER TABLE `finance`
  ADD PRIMARY KEY (`id_budget`,`id_sponsor`),
  ADD KEY `id_sponsor` (`id_sponsor`);

--
-- Index pour la table `inclure`
--
ALTER TABLE `inclure`
  ADD PRIMARY KEY (`id_discipline`,`id_type_epreuve`),
  ADD KEY `id_type_epreuve` (`id_type_epreuve`);

--
-- Index pour la table `participer`
--
ALTER TABLE `participer`
  ADD PRIMARY KEY (`id_athlete`,`id_epreuve`),
  ADD KEY `id_epreuve` (`id_epreuve`);

--
-- Index pour la table `resultat`
--
ALTER TABLE `resultat`
  ADD PRIMARY KEY (`id_resultat`),
  ADD KEY `id_classement` (`id_classement`),
  ADD KEY `id_athlete` (`id_athlete`),
  ADD KEY `id_equipe` (`id_equipe`),
  ADD KEY `id_type_resultat` (`id_type_resultat`),
  ADD KEY `id_epreuve` (`id_epreuve`),
  ADD KEY `id_session` (`id_session`);

--
-- Index pour la table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id_session`),
  ADD KEY `id_site` (`id_site`),
  ADD KEY `id_epreuve` (`id_epreuve`);

--
-- Index pour la table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id_site`);

--
-- Index pour la table `spectateur`
--
ALTER TABLE `spectateur`
  ADD PRIMARY KEY (`id_spectateur`);

--
-- Index pour la table `sponsor`
--
ALTER TABLE `sponsor`
  ADD PRIMARY KEY (`id_sponsor`);

--
-- Index pour la table `type_epreuve`
--
ALTER TABLE `type_epreuve`
  ADD PRIMARY KEY (`id_type_epreuve`);

--
-- Index pour la table `Type_Equipe`
--
ALTER TABLE `Type_Equipe`
  ADD PRIMARY KEY (`id_type_equipe`);

--
-- Index pour la table `type_resultat`
--
ALTER TABLE `type_resultat`
  ADD PRIMARY KEY (`id_type_resultat`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `athlete`
--
ALTER TABLE `athlete`
  MODIFY `id_athlete` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT pour la table `billet`
--
ALTER TABLE `billet`
  MODIFY `id_billet` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `budget`
--
ALTER TABLE `budget`
  MODIFY `id_budget` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `classement`
--
ALTER TABLE `classement`
  MODIFY `id_classement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `delegation`
--
ALTER TABLE `delegation`
  MODIFY `id_delegation` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT pour la table `discipline`
--
ALTER TABLE `discipline`
  MODIFY `id_discipline` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT pour la table `entraineur`
--
ALTER TABLE `entraineur`
  MODIFY `id_entraineur` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `epreuve`
--
ALTER TABLE `epreuve`
  MODIFY `id_epreuve` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `equipe`
--
ALTER TABLE `equipe`
  MODIFY `id_equipe` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `evenement`
--
ALTER TABLE `evenement`
  MODIFY `id_evenement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT pour la table `resultat`
--
ALTER TABLE `resultat`
  MODIFY `id_resultat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `session`
--
ALTER TABLE `session`
  MODIFY `id_session` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `site`
--
ALTER TABLE `site`
  MODIFY `id_site` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `spectateur`
--
ALTER TABLE `spectateur`
  MODIFY `id_spectateur` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `sponsor`
--
ALTER TABLE `sponsor`
  MODIFY `id_sponsor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `type_epreuve`
--
ALTER TABLE `type_epreuve`
  MODIFY `id_type_epreuve` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `Type_Equipe`
--
ALTER TABLE `Type_Equipe`
  MODIFY `id_type_equipe` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `type_resultat`
--
ALTER TABLE `type_resultat`
  MODIFY `id_type_resultat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `assister`
--
ALTER TABLE `assister`
  ADD CONSTRAINT `assister_ibfk_1` FOREIGN KEY (`id_session`) REFERENCES `session` (`id_session`),
  ADD CONSTRAINT `assister_ibfk_2` FOREIGN KEY (`id_spectateur`) REFERENCES `spectateur` (`id_spectateur`);

--
-- Contraintes pour la table `billet`
--
ALTER TABLE `billet`
  ADD CONSTRAINT `billet_ibfk_1` FOREIGN KEY (`id_spectateur`) REFERENCES `spectateur` (`id_spectateur`),
  ADD CONSTRAINT `billet_ibfk_2` FOREIGN KEY (`id_session`) REFERENCES `session` (`id_session`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Contraintes pour la table `encadrer`
--
ALTER TABLE `encadrer`
  ADD CONSTRAINT `encadrer_ibfk_1` FOREIGN KEY (`id_athlete`) REFERENCES `athlete` (`id_athlete`),
  ADD CONSTRAINT `encadrer_ibfk_2` FOREIGN KEY (`id_entraineur`) REFERENCES `entraineur` (`id_entraineur`);

--
-- Contraintes pour la table `epreuve`
--
ALTER TABLE `epreuve`
  ADD CONSTRAINT `epreuve_ibfk_1` FOREIGN KEY (`id_discipline`) REFERENCES `discipline` (`id_discipline`),
  ADD CONSTRAINT `epreuve_ibfk_2` FOREIGN KEY (`id_evenement`) REFERENCES `evenement` (`id_evenement`);

--
-- Contraintes pour la table `equipe`
--
ALTER TABLE `equipe`
  ADD CONSTRAINT `equipe_ibfk_1` FOREIGN KEY (`id_discipline`) REFERENCES `discipline` (`id_discipline`),
  ADD CONSTRAINT `equipe_ibfk_2` FOREIGN KEY (`id_delegation`) REFERENCES `delegation` (`id_delegation`),
  ADD CONSTRAINT `fk_type_equipe` FOREIGN KEY (`id_type_equipe`) REFERENCES `Type_Equipe` (`id_type_equipe`);

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `evenement_ibfk_1` FOREIGN KEY (`id_budget`) REFERENCES `budget` (`id_budget`);

--
-- Contraintes pour la table `finance`
--
ALTER TABLE `finance`
  ADD CONSTRAINT `finance_ibfk_1` FOREIGN KEY (`id_budget`) REFERENCES `budget` (`id_budget`),
  ADD CONSTRAINT `finance_ibfk_2` FOREIGN KEY (`id_sponsor`) REFERENCES `sponsor` (`id_sponsor`);

--
-- Contraintes pour la table `inclure`
--
ALTER TABLE `inclure`
  ADD CONSTRAINT `inclure_ibfk_1` FOREIGN KEY (`id_discipline`) REFERENCES `discipline` (`id_discipline`),
  ADD CONSTRAINT `inclure_ibfk_2` FOREIGN KEY (`id_type_epreuve`) REFERENCES `type_epreuve` (`id_type_epreuve`);

--
-- Contraintes pour la table `participer`
--
ALTER TABLE `participer`
  ADD CONSTRAINT `participer_ibfk_1` FOREIGN KEY (`id_athlete`) REFERENCES `athlete` (`id_athlete`),
  ADD CONSTRAINT `participer_ibfk_2` FOREIGN KEY (`id_epreuve`) REFERENCES `epreuve` (`id_epreuve`);

--
-- Contraintes pour la table `resultat`
--
ALTER TABLE `resultat`
  ADD CONSTRAINT `resultat_ibfk_1` FOREIGN KEY (`id_classement`) REFERENCES `classement` (`id_classement`),
  ADD CONSTRAINT `resultat_ibfk_2` FOREIGN KEY (`id_athlete`) REFERENCES `athlete` (`id_athlete`),
  ADD CONSTRAINT `resultat_ibfk_3` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`),
  ADD CONSTRAINT `resultat_ibfk_4` FOREIGN KEY (`id_type_resultat`) REFERENCES `type_resultat` (`id_type_resultat`),
  ADD CONSTRAINT `resultat_ibfk_5` FOREIGN KEY (`id_epreuve`) REFERENCES `epreuve` (`id_epreuve`),
  ADD CONSTRAINT `resultat_ibfk_6` FOREIGN KEY (`id_session`) REFERENCES `session` (`id_session`);

--
-- Contraintes pour la table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `session_ibfk_1` FOREIGN KEY (`id_site`) REFERENCES `site` (`id_site`),
  ADD CONSTRAINT `session_ibfk_2` FOREIGN KEY (`id_epreuve`) REFERENCES `epreuve` (`id_epreuve`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
