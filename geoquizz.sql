-- phpMyAdmin SQL Dump
-- version 4.1.14.8
-- http://www.phpmyadmin.net
--
-- Client :  db722835319.db.1and1.com
-- Généré le :  Sam 10 Février 2018 à 09:33
-- Version du serveur :  5.5.59-0+deb7u1-log
-- Version de PHP :  5.4.45-0+deb7u12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `db722835319`
--

-- --------------------------------------------------------

--
-- Structure de la table `partie`
--

CREATE TABLE IF NOT EXISTS `partie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` text NOT NULL,
  `statut` int(11) NOT NULL,
  `joueur` varchar(250) NOT NULL,
  `score` int(11) DEFAULT '0',
  `serie_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

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
(22, 'e7add762-3239-4def-a46f-d2c7316f990f', 1, 'coco', 0, 1, '2018-02-06 14:08:31', '2018-02-06 14:08:31'),
(23, '365462b8-6eff-4d39-b0ca-ffb71a8e00c1', 1, 'coco', 0, 1, '2018-02-08 15:14:55', '2018-02-08 15:14:55'),
(24, '807494e5-2788-4aed-afdd-24589716a045', 1, 'coco', 0, 1, '2018-02-09 14:20:46', '2018-02-09 14:16:03'),
(25, 'a1966c1d-ac6f-4ed5-9494-9729237c74c0', 0, 'coco', 0, 1, '2018-02-09 14:24:26', '2018-02-09 14:24:26'),
(26, 'a33354ad-b5d2-44f9-b2bf-fba112d576d5', 1, 'thomas', 0, 1, '2018-02-09 16:34:56', '2018-02-09 16:34:56'),
(27, '8c800369-8f24-48c6-b718-11d1000885ea', 1, 'flo', 0, 1, '2018-02-09 16:46:40', '2018-02-09 16:46:40'),
(28, 'c9954e2e-8fa6-47b5-b963-0b65bdcf9ac9', 1, 'razzo', 0, 1, '2018-02-09 16:58:25', '2018-02-09 16:58:25'),
(29, 'af3d18ff-7b37-49f7-9e6d-9a8d70914cfb', 1, 'gfgg', 0, 1, '2018-02-09 17:01:50', '2018-02-09 17:01:50'),
(30, 'f586034b-64da-41a6-9f61-b0771bb40011', 1, 'azertyuiop', 0, 1, '2018-02-09 17:02:41', '2018-02-09 17:02:41'),
(31, '4418b604-bec7-4a61-af52-b4d093ab5b01', 1, 'blabla', 0, 1, '2018-02-09 17:04:30', '2018-02-09 17:04:30'),
(32, '40b85c6c-f913-48e3-a2b7-bc2ae56ccac9', 1, 'wxcvbn', 0, 1, '2018-02-09 17:10:45', '2018-02-09 17:10:45'),
(33, '68df3e0f-02f0-496a-8eab-7e4edf92fff8', 1, 'ghdd', 0, 1, '2018-02-09 17:14:16', '2018-02-09 17:14:16'),
(34, '6edc99fd-30f6-4777-b5a9-10807834b05a', 1, 'dfghj', 0, 1, '2018-02-09 17:14:57', '2018-02-09 17:14:57'),
(35, '300be350-6264-4873-beec-bdc55720bea8', 1, 'fghjqqq', 0, 1, '2018-02-09 17:16:46', '2018-02-09 17:16:46'),
(36, 'b9622fb6-cf72-48f1-bfc5-0bb3edc165c0', 1, 'sdfgh', 0, 1, '2018-02-09 17:19:52', '2018-02-09 17:19:52'),
(37, '90298557-3c12-43f1-aa12-141f1fb80a41', 1, 'blabla', 0, 1, '2018-02-10 08:19:35', '2018-02-10 08:19:35'),
(38, 'f2e4cb0d-a633-494b-8dba-2e2ff217b927', 1, 'wxcvb', 0, 1, '2018-02-10 08:28:32', '2018-02-10 08:28:32'),
(39, '30044b58-1ddd-4118-ac04-2f6962f094fc', 1, 'cvbn', 0, 1, '2018-02-10 08:29:08', '2018-02-10 08:29:08');

-- --------------------------------------------------------

--
-- Structure de la table `photo`
--

CREATE TABLE IF NOT EXISTS `photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `desc` text NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `url` text NOT NULL,
  `serie_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Contenu de la table `photo`
--

INSERT INTO `photo` (`id`, `desc`, `longitude`, `latitude`, `url`, `serie_id`) VALUES
(2, 'Centre Pompidou', 6.1816762999999355, 49.10824059999999, 'http://www.pedagogie.ac-nantes.fr/medias/photo/pompidoumetz4x3_1394100049099.jpg?ID_FICHE=1409432037701', 1),
(3, 'Gare de Metz', 6.177221300000042, 49.1098016, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Gare_de_Metz_-_2014.JPG/1200px-Gare_de_Metz_-_2014.JPG', 1),
(4, 'Stade Saint-Symphorien', 6.159414100000049, 49.1097781, 'http://www.thinkfoot.fr/ressources/stade/photos/53/650x500/photo-stade+saint-symphorien-531000.jpg', 1),
(5, 'Cathédrale de Metz', 6.175797399999965, 49.1203081, 'https://files1.structurae.de/files/photos/5256/2016-07-21/dsc07810.jpg', 1),
(6, 'Porte des Allemands', 6.185551600000053, 49.1178681, 'http://1.bp.blogspot.com/-N7ww1NwQyiE/U5rzkHlhPCI/AAAAAAAAFl8/PH5KM9pLwRs/s1600/Porte+des+Allemands+(80).jpg', 1),
(7, 'Musée de La Cour d''Or', 6.185551600000053, 49.1178681, 'https://metz.fr/lieux/images/gr_musee.jpg', 1),
(8, 'Opera Theatre', 6.172711199999981, 49.12172959999999, 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Metz_Theatre_2003.jpg', 1),
(9, 'Arènes de Metz', 6.184101000000055, 49.108758, 'http://www.fnactickets.com/static/0/visuel/pano/157/1576546216361416860__1.jpg?1257846644000', 1),
(10, 'Hôtel de Ville de Metz', 6.176422000000002, 49.119819, 'http://ekladata.com/gz2ADKG3yK14OV1XyJPaYtJWgvA.jpg', 1),
(11, 'Préfecture de la Moselle', 6.174792099999991, 49.1224518, 'https://tout-metz.com/wp-content/uploads/2015/01/Pr%C3%A9fecture-de-Moselle-1200.jpg', 1),
(17, 'y(yy-r-u-', 5.5078124441206455, 47.204642388766935, 'ryr', 7),
(20, 'Arc de Triomphe', 2.294940948486328, 48.87386089807715, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Arc_de_Triomphe%2C_Paris_21_October_2010.jpg/260px-Arc_de_Triomphe%2C_Paris_21_October_2010.jpg', 8),
(21, 'Musée du Louvre', 2.337512969970703, 48.860649275706926, 'https://fr.petitsfrenchies.com/wp-content/uploads/2017/01/museedulouvre-1460x650.jpg', 8),
(19, 'Tour Eiffel', 2.2944259643554688, 48.8583905296204, 'https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/02.-sites-culturels-630-x-405/tour-eiffel-trocadero-630x405-c-thinkstock/37221-1-fre-FR/Tour-Eiffel-Trocadero-630x405-C-Thinkstock.jpg', 8),
(22, 'Cathédrale Notre-Dame de Paris', 2.349872589111328, 48.852969123136646, 'https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/02.-sites-culturels-630-x-405/cathedrale-notre-dame-nuit-630x405-c-thinkstock2/36086-1-fre-FR/Cathedrale-Notre-Dame-nuit-630x405-C-Thinkstock.jpg', 8),
(23, 'Musée Grévin', 2.3421478271484375, 48.871828567827116, 'http://encoreunblogdemode.com/wp-content/uploads/2014/05/musee-grevin_scalewidth_460.jpg', 8),
(24, 'Sacré-Coeur ', 2.34283447265625, 48.8868432816345, 'https://images.musement.com/default/0001/19/montmartre-sacre-cœur-art-quarter-guided-visit_header-18093.jpeg?w=520&#38;dpr=1', 8),
(25, 'Pont Alexandre 3', 2.3134803771972656, 48.863924276481605, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Pont_Alexandre_III_from_pont_de_la_Concorde%2C_Paris_17_May_2012.jpg/1200px-Pont_Alexandre_III_from_pont_de_la_Concorde%2C_Paris_17_May_2012.jpg', 8),
(26, 'Le Centre Pompidou', 2.3521041870117188, 48.860649275706926, 'http://agenda.germainpire.info/img/locations/Centre_Pompidou.jpg', 8),
(27, 'Bataclan', 2.3705577850341797, 48.8630208493969, 'http://scd.rfi.fr/sites/filesrfi/imagecache/rfi_16x9_1024_578/sites/images.rfi.fr/files/aef_image/bataclan_2016-11-08t144437z_1175516336_d1beulraevaa_rtrmadp_3_europe-attacks-france-bataclan_0.jpg', 8),
(28, 'Panthéon', 2.3462677001953125, 48.846304506623845, 'https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/02.-sites-culturels-630-x-405/pantheon-vue-generale-630x405-c-thinkstock/36266-1-fre-FR/Pantheon-vue-generale-630x405-C-Thinkstock.jpg', 8),
(29, 'Place de la République', 6.172771453857422, 49.11511896660571, 'http://ekladata.com/P_oQZ9d2YP7Jgg0Wp7yWACKWjEk.jpg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `serie`
--

CREATE TABLE IF NOT EXISTS `serie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lieu` varchar(250) NOT NULL,
  `lieu_longitude` double NOT NULL,
  `lieu_latitude` double NOT NULL,
  `zoom_carte` int(11) NOT NULL,
  `distance_calcul` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `serie`
--

INSERT INTO `serie` (`id`, `lieu`, `lieu_longitude`, `lieu_latitude`, `zoom_carte`, `distance_calcul`) VALUES
(1, 'Metz', 6.166667, 49.133333, 13, 100),
(8, 'Paris', 2.352447509765625, 48.852969123136646, 11, 100);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(250) NOT NULL,
  `pseudo` varchar(250) NOT NULL,
  `mdp` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `mail`, `pseudo`, `mdp`) VALUES
(1, 'coco@coco.fr', 'coco', '$2y$10$CMhCZ/XUazuneexVc/QZBeL74TUffaWRv0pkwHWRogUVPfmpBTtBC'),
(2, 'toto@toto.fr', 'toto', '$2y$10$QQy2S/fDgEwfd7GuN/TaR.KFav1hpfwAbU7wIjF/K99DnHRwFuFjO'),
(3, 'edege@dfg.fr', '12éé', '$2y$10$ca3BjLZEa8m0IsEdQtvku.hxxtddnQqJvRrnAndujva6NkYszacE2'),
(4, 'thtr@rhdd.fr', 'gghh', '$2y$10$M3HigL1Dk0rMfzqgVo3Jze/6flJwDrmIDPEov4auLVQSi8nucF63K'),
(5, 'grr@zeg.fr', 'fr', '$2y$10$ptBCBSfg2AWTfL97VJpi1OtzZ2gIK0QoHbKz9FWwFzvn93nLj0SQO'),
(6, 'ddr@rje.fr', 'o', '$2y$10$MxL6FIT.NosyBwGiZIzfBudFmq1brLO59bFdE/caQbDfMZt5aPJNS'),
(7, 'de@de.de', 'de', '$2y$10$8OjHHfVYa0eOf2BAK1NlfO/GbOHHsP...8/fG5XzaF2roevC64LwK'),
(8, 'coco@coco.com', 'coco', '$2y$10$hAsHo4y/7LJBdfW8y/BhVetENxyY4xZK9Z5gj5ENe70J4whUP8Gj.'),
(9, 'flo@lebg.fr', 'flodu57', '$2y$10$eJA7FnoHmQdPrRRrTH/K5.nGwQDldgEdyAEU6fi/P7oBh4PlEVjGO'),
(10, 'toto@toto.com', 'toto', '$2y$10$Q0V69Zoo3Af/xXL9sRPWaOYIkMqZvXzgvhOTmn5b2DZhXt8AT3P9i'),
(11, 'flo@flo.fr', 'flodu57', '$2y$10$ryD0QGa2ycgi7AbHnZXBku2aYTDfqTyPzSSkeHoGpTPPZb/vRw.4.'),
(12, 'flo@live.fr', 'Florent', '$2y$10$IRAR8HFOgV03YiJOZaMoSuHuGRZoE1eoRGHjHGElTj8lCsTtSmeqa');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
