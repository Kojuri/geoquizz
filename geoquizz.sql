-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Mar 06 Février 2018 à 15:53
-- Version du serveur :  5.7.14
-- Version de PHP :  7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `geoquizz`
--

-- --------------------------------------------------------

--
-- Structure de la table `partie`
--

CREATE TABLE `partie` (
  `id` int(11) NOT NULL,
  `token` text NOT NULL,
  `statut` int(11) NOT NULL,
  `joueur` varchar(250) NOT NULL,
  `score` int(11) DEFAULT '0',
  `serie_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `partie`
--

INSERT INTO `partie` (`id`, `token`, `statut`, `joueur`, `score`, `serie_id`, `updated_at`, `created_at`) VALUES
(1, '9d6768dd-62a1-4502-9c3a-52f71223298a', 3, 'Flo', 200, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, '857ed17d-ee78-406f-a800-cf7a6596b88f', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, '36025909-b512-4eac-a77e-ea93a4959044', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, '6234fd6c-5d89-4ed1-8830-95258d949bf9', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'ffc36ded-c428-46b5-9bfe-f19b952f0b54', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, '94456eb2-0bfa-400a-b9f5-ed22d438e868', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, '8e25bff0-ed18-497e-b075-548082e40e22', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, '203ab1a8-bb0d-457d-8103-30de7bf18fb1', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, '3dc54e5f-3e62-4401-8926-31a7b0b4b675', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, '5fa0468f-3e02-4697-b548-c8ec7a2f962e', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 'bf112215-18d6-467e-8de9-432676c13c44', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 'cca3c48f-db19-48b8-9a2d-dade8ce304bd', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, '3e513996-8aaa-4ea4-9f5b-cbac8e054228', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 'a0897f75-7ef6-4afe-b334-c56ee18d4cbd', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, '7dcc853f-274c-449d-b77e-601ea092a378', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, '7989ae26-1116-4ebb-a223-28599e241d52', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, '19733cb3-21db-459b-928f-2d2beede31bd', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 'ddab3cc1-7746-4d4b-8796-8afc510d9f25', 1, 'Flo', 0, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, '425555d8-bd6f-4f7c-9e73-2c5b98df1ad5', 1, 'Thomas', 0, 1, '2018-02-06 09:56:04', '2018-02-06 09:56:04'),
(20, 'fecb29bf-cdd4-407d-a749-fa757a51803c', 1, 'Thomas', 0, 1, '2018-02-06 10:02:31', '2018-02-06 10:02:31'),
(21, '858ae1d6-fbd6-495a-91a6-e1b579e7f2a2', 3, 'Thomas', 79, 1, '2018-02-06 11:08:00', '2018-02-06 11:04:02'),
(22, 'e7add762-3239-4def-a46f-d2c7316f990f', 1, 'coco', 0, 1, '2018-02-06 14:08:31', '2018-02-06 14:08:31');

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE `photo` (
  `id` int(11) NOT NULL,
  `desc` text NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `url` text NOT NULL,
  `serie_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `photo`
--

INSERT INTO `photo` (`id`, `desc`, `longitude`, `latitude`, `url`, `serie_id`) VALUES
(1, 'Place Stan', 234, 567, 'http:///Hhfrhrthe', 0),
(2, 'Centre Pompidou', 6.1816762999999355, 49.10824059999999, 'http://www.pedagogie.ac-nantes.fr/medias/photo/pompidoumetz4x3_1394100049099.jpg?ID_FICHE=1409432037701', 1),
(3, 'Gare de Metz', 6.177221300000042, 49.1098016, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Gare_de_Metz_-_2014.JPG/1200px-Gare_de_Metz_-_2014.JPG', 1),
(4, 'Stade Saint-Symphorien', 6.159414100000049, 49.1097781, 'http://www.thinkfoot.fr/ressources/stade/photos/53/650x500/photo-stade+saint-symphorien-531000.jpg', 1),
(5, 'Cathédrale de Metz', 6.175797399999965, 49.1203081, 'https://files1.structurae.de/files/photos/5256/2016-07-21/dsc07810.jpg', 1),
(6, 'Porte des Allemands', 6.185551600000053, 49.1178681, 'http://1.bp.blogspot.com/-N7ww1NwQyiE/U5rzkHlhPCI/AAAAAAAAFl8/PH5KM9pLwRs/s1600/Porte+des+Allemands+(80).jpg', 1),
(7, 'Musée de La Cour d\'Or', 6.185551600000053, 49.1178681, 'https://metz.fr/lieux/images/gr_musee.jpg', 1),
(8, 'Opera Theatre', 6.172711199999981, 49.12172959999999, 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Metz_Theatre_2003.jpg', 1),
(9, 'Arènes de Metz', 6.184101000000055, 49.108758, 'http://www.fnactickets.com/static/0/visuel/pano/157/1576546216361416860__1.jpg?1257846644000', 1),
(10, 'Hôtel de Ville de Metz', 6.176422000000002, 49.119819, 'http://ekladata.com/gz2ADKG3yK14OV1XyJPaYtJWgvA.jpg', 1),
(11, 'Préfecture de la Moselle', 6.174792099999991, 49.1224518, 'https://tout-metz.com/wp-content/uploads/2015/01/Pr%C3%A9fecture-de-Moselle-1200.jpg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `serie`
--

CREATE TABLE `serie` (
  `id` int(11) NOT NULL,
  `lieu` varchar(250) NOT NULL,
  `lieu_longitude` double NOT NULL,
  `lieu_latitude` double NOT NULL,
  `zoom_carte` int(11) NOT NULL,
  `distance_calcul` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `serie`
--

INSERT INTO `serie` (`id`, `lieu`, `lieu_longitude`, `lieu_latitude`, `zoom_carte`, `distance_calcul`) VALUES
(1, 'Metz', 6.166667, 49.133333, 13, 100);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `partie`
--
ALTER TABLE `partie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serie_id` (`serie_id`);

--
-- Index pour la table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serie_id` (`serie_id`);

--
-- Index pour la table `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `partie`
--
ALTER TABLE `partie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT pour la table `photo`
--
ALTER TABLE `photo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `serie`
--
ALTER TABLE `serie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
