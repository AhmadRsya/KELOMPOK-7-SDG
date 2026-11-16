SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `admin` (
  `id_admin` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nama`, `password`) VALUES
(1, 'Admin AirKita', 'HASH_PASSWORD_CONTOH');

-- --------------------------------------------------------

--
-- Table structure for table `artikel`
--

CREATE TABLE `artikel` (
  `id_artikel` int NOT NULL,
  `id_admin` int NOT NULL,
  `judul` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artikel`
--

INSERT INTO `artikel` (`id_artikel`, `id_admin`, `judul`, `isi`) VALUES
(1, 1, 'Ciri Air Bersih yang Layak Pakai', 'Air bersih tidak berwarna, tidak berbau, dan tidak berasa ...'),
(2, 1, 'Cara Menjaga Kebersihan Sungai', 'Hindari membuang sampah langsung ke sungai ...'),
(3, 1, 'Pentingnya Sanitasi Layak', 'Sanitasi yang baik mencegah penyakit ...');

-- --------------------------------------------------------

--
-- Table structure for table `laporan`
--

CREATE TABLE `laporan` (
  `id_laporan` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `id_admin` int DEFAULT NULL,
  `jenis_masalah` enum('air keruh','air berbau','air berwarna','sampah di sungai','pencemaran sumber air','sanitasi tidak layak') COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('terkirim','sedang diproses','selesai') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'terkirim',
  `tanggal_lapor` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tanggal_update` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `laporan`
--

INSERT INTO `laporan` (`id_laporan`, `id_pengguna`, `id_admin`, `jenis_masalah`, `deskripsi`, `lokasi`, `foto`, `status`, `tanggal_lapor`, `tanggal_update`) VALUES
(1, 1, 1, 'air keruh', 'Air sumur berwarna cokelat sejak kemarin', 'Kel. Oro-oro Ombo, Madiun', 'foto/lap1.jpg', 'sedang diproses', '2026-11-02 12:08:20', '2026-11-02 12:08:20'),
(2, 2, NULL, 'sampah di sungai', 'Tumpukan sampah menyumbat aliran sungai', 'Sungai Madiun dekat jembatan', 'foto/lap2.jpg', 'terkirim', '2026-11-02 12:08:20', NULL),
(3, 3, NULL, 'air berbau', 'Air PDAM berbau menyengat', 'Kec. Taman, Madiun', NULL, 'terkirim', '2026-11-02 12:08:20', NULL),
(4, 1, NULL, 'air keruh', 'Air keran keruh setelah hujan', 'Kel. Oro-oro Ombo, Madiun', NULL, 'terkirim', '2026-11-02 12:08:20', NULL),
(5, 2, NULL, 'sanitasi tidak layak', 'Saluran pembuangan tersumbat', 'Kel. Pandean, Madiun', 'foto/lap5.jpg', 'terkirim', '2026-11-02 12:08:20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_laporan` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `nama`, `total_laporan`) VALUES
(1, 'Ani', 2),
(2, 'Budi', 2),
(3, 'Citra', 1);

-- --------------------------------------------------------

--
-- Table structure for table `saran`
--

CREATE TABLE `saran` (
  `id_saran` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `isi_saran` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `saran`
--

INSERT INTO `saran` (`id_saran`, `id_pengguna`, `isi_saran`) VALUES
(1, 1, 'Tambahkan fitur filter laporan berdasarkan wilayah'),
(2, 2, 'Mohon ada pengingat jika laporan belum diproses'),
(3, 3, 'Tambahkan mode gelap pada aplikasi');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_laporan_publik`
-- (See below for the actual view)
--
CREATE TABLE `v_laporan_publik` (
`id_laporan` int
,`jenis_masalah` enum('air keruh','air berbau','air berwarna','sampah di sungai','pencemaran sumber air','sanitasi tidak layak')
,`deskripsi` text
,`lokasi` varchar(255)
,`foto` varchar(255)
,`status` enum('terkirim','sedang diproses','selesai')
,`tanggal_lapor` datetime
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `artikel`
--
ALTER TABLE `artikel`
  ADD PRIMARY KEY (`id_artikel`),
  ADD KEY `fk_artikel_admin` (`id_admin`);

--
-- Indexes for table `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id_laporan`),
  ADD KEY `fk_laporan_pengguna` (`id_pengguna`),
  ADD KEY `fk_laporan_admin` (`id_admin`),
  ADD KEY `idx_laporan_status` (`status`),
  ADD KEY `idx_laporan_jenis` (`jenis_masalah`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`);

--
-- Indexes for table `saran`
--
ALTER TABLE `saran`
  ADD PRIMARY KEY (`id_saran`),
  ADD KEY `fk_saran_pengguna` (`id_pengguna`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `artikel`
--
ALTER TABLE `artikel`
  MODIFY `id_artikel` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id_laporan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `saran`
--
ALTER TABLE `saran`
  MODIFY `id_saran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --------------------------------------------------------

--
-- Structure for view `v_laporan_publik`
--
DROP TABLE IF EXISTS `v_laporan_publik`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_laporan_publik`  AS SELECT `laporan`.`id_laporan` AS `id_laporan`, `laporan`.`jenis_masalah` AS `jenis_masalah`, `laporan`.`deskripsi` AS `deskripsi`, `laporan`.`lokasi` AS `lokasi`, `laporan`.`foto` AS `foto`, `laporan`.`status` AS `status`, `laporan`.`tanggal_lapor` AS `tanggal_lapor` FROM `laporan` ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artikel`
--
ALTER TABLE `artikel`
  ADD CONSTRAINT `fk_artikel_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `laporan`
--
ALTER TABLE `laporan`
  ADD CONSTRAINT `fk_laporan_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_laporan_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `saran`
--
ALTER TABLE `saran`
  ADD CONSTRAINT `fk_saran_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
