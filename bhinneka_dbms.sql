-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 20, 2021 at 06:57 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bhinneka_dbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(20) DEFAULT NULL,
  `no_rekening` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `no_rekening`) VALUES
(1, 'BNI', '009-557-7779'),
(2, 'Mandiri', '070-00-0187777-3'),
(3, 'BCA', '6860-1485-77');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `id_kategori_child` int(11) NOT NULL,
  `nama_barang` varchar(100) DEFAULT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(4) NOT NULL DEFAULT '0',
  `spesifikasi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `id_kategori_child`, `nama_barang`, `harga`, `stok`, `spesifikasi`) VALUES
(1, 5, 'Hardsik External Seagate 1 TB', 800000, 5, 'Garansi Resmi Indonesia 5 Tahun Original. Kapasitas 1 TB. USB 3.0'),
(2, 5, 'Hardisk External Toshiba 1 TB', 750000, 5, 'Garansi 1 Tahun Indonesia Original. Kapasitas 1 TB. USB 3.0'),
(3, 9, 'RAM SODIMM DDR4 4 GB Samsung', 700000, 5, 'RAM khusus untuk laptop yang menggunakan DDR4 kapasitas 4GB. Garansi Resmi Toko.'),
(4, 23, 'Sepeda Motor Matic Honda Spacy Warna Merah', 19000000, 4, 'Sepeda Motor Matic Honda Spacy Warna Merah Garansi Resmi Honda 3 Tahun'),
(5, 6, 'Monitor Acer X145N', 900000, 10, 'Monitor Acer X145, Resolusi Layar HD, Input VGA, kelengkapan kabel power dan kabel VGA Garansi Seumur Hidup.'),
(6, 83, 'Printer Epson L360', 1800000, 5, 'Resolusi Printing 720px resolusi Scanning up to 1000dpi. Gratis Warna CMBY 1 Packet Asli Epson. Garansi 2 Tahun.'),
(7, 83, 'Printer Epson L310', 1600000, 5, 'Resolusi Printing 720px. Gratis Warna CMBY 1 PAcket Asli EPOSON, Garansi 2 Tahun.'),
(8, 74, 'Gitar Yamaha F310 Natural Colour', 1200000, 10, 'Garansi Resmi Yamaha 1 Tahun Original'),
(9, 74, 'Gitar Elektrik Bose Black', 3600000, 4, 'Gitar Elektrik Merek Bose Garansi International Warna Hitam'),
(10, 159, 'POCOPHONE F1 By xiaomi', 4000000, 24, 'Ukuran 6.18 inci (~82.2% screen-to-body ratio) Resolusi 1080 x 2246 piksel 18.7:9 ratio (~403 ppi density) Proteksi Corning Gorilla Glass (versinya tak dijabarkan) Sistem Operasi Android 8.1 (Oreo) Chipset Qualcomm SDM845 Snapdragon 845');

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `barang_delete` AFTER DELETE ON `barang` FOR EACH ROW BEGIN 
INSERT INTO barang_log (keterangan, waktu, nama_barang, harga, stok) VALUES('delete', now(), OLD.nama_barang, OLD.harga, OLD.stok); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_update` AFTER UPDATE ON `barang` FOR EACH ROW BEGIN 
INSERT INTO barang_log (keterangan, waktu, nama_barang, harga, stok) VALUES('update', now(), new.nama_barang, new.harga, new.stok); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `perubahan_barang` AFTER INSERT ON `barang` FOR EACH ROW BEGIN
INSERT INTO barang_log (keterangan,waktu, nama_barang,harga,stok)	
VALUES('bertambah', now(), new.nama_barang, new.harga, new.stok);END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang_log`
--

CREATE TABLE `barang_log` (
  `id_log` int(5) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `waktu` datetime NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga` int(10) NOT NULL DEFAULT '0',
  `stok` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang_log`
--

INSERT INTO `barang_log` (`id_log`, `keterangan`, `waktu`, `nama_barang`, `harga`, `stok`) VALUES
(1, 'bertambah', '2019-04-02 20:47:52', 'Legion Y530', 1500000, 20),
(2, 'update', '2019-04-02 20:58:05', 'POCOPHONE F1 By xiaomi', 4000000, 24),
(3, 'delete', '2019-04-02 21:02:03', 'Legion Y530', 1500000, 20),
(4, 'update', '2019-04-02 21:31:09', 'Hardisk External Toshiba 1 TB', 750000, 5),
(5, 'update', '2019-04-10 09:56:43', 'Gitar Yamaha F310 Natural Colour', 1200000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id_detail` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `jumlah` int(2) NOT NULL,
  `total_harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id_detail`, `id_transaksi`, `id_barang`, `jumlah`, `total_harga`) VALUES
(5, 10, 3, 1, 700000),
(6, 11, 1, 1, 800000),
(7, 12, 6, 1, 1800000),
(8, 10, 5, 1, 20000),
(9, 11, 2, 5, 1500000),
(10, 11, 8, 3, 3000000);

--
-- Triggers `detail_transaksi`
--
DELIMITER $$
CREATE TRIGGER `stok_update` AFTER INSERT ON `detail_transaksi` FOR EACH ROW BEGIN
	UPDATE barang SET stok=stok - NEW.jumlah
	WHERE id_barang=NEW.id_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_child`
--

CREATE TABLE `kategori_child` (
  `id_kategori_child` int(11) NOT NULL,
  `id_kategori_parent` int(11) NOT NULL,
  `nama_kategori_child` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_child`
--

INSERT INTO `kategori_child` (`id_kategori_child`, `id_kategori_parent`, `nama_kategori_child`) VALUES
(1, 42, 'Mouse'),
(2, 4, 'Sendok'),
(3, 20, 'Speaker'),
(5, 10, 'Lenovo');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_parent`
--

CREATE TABLE `kategori_parent` (
  `id_kategori_parent` int(11) NOT NULL,
  `nama_kategori_parent` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_parent`
--

INSERT INTO `kategori_parent` (`id_kategori_parent`, `nama_kategori_parent`) VALUES
(2, 'Perkakas & Otomotif'),
(3, 'Network and Security System'),
(4, 'Pelaratan Dapur & Rumah Tangga'),
(7, 'Power and Rack System'),
(8, 'Furnitur & Perlengkapan Rumah Tangg'),
(9, 'Camera and Video'),
(10, 'Computer, Desktop, Notebook'),
(11, 'Peralatan Kantor'),
(12, 'Tas, Koper & Perjalanan'),
(13, 'Server and Data Storage'),
(14, 'Alat Tulis & Perlengkapan Kerja'),
(15, 'Sport & Fitness'),
(16, 'Kesehatan dan Kecantikan'),
(17, 'Fashion & Busana Pria'),
(18, 'Software & Licensing'),
(19, 'Gadget'),
(20, 'Tv and Home Audio Video'),
(21, 'Makanan & Kebutuhan Harian'),
(22, 'Buku, Film & Musik'),
(23, 'Printing and Digital Imaging'),
(24, 'Koleksi dan Mainan'),
(25, 'Service Center'),
(26, 'Produk Prabayar & Voucher'),
(27, 'Perlengkapan Bayi & Anak'),
(28, 'Spare Part'),
(29, 'Fashion & BusanaWanita'),
(42, 'Aksesoris Gadget & Komputer');

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(5) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `jumlah` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_barang`, `id_pelanggan`, `jumlah`) VALUES
(1, 3, 1, 1),
(2, 1, 1, 1),
(3, 6, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(32) NOT NULL,
  `email` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  `jenis_kelamin` char(9) NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `pembayaran_berhasil` char(9) DEFAULT NULL,
  `no_telp` varchar(12) DEFAULT NULL,
  `pembayaran_batal` char(5) DEFAULT NULL,
  `menunggu_pembayaran` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `email`, `password`, `jenis_kelamin`, `tgl_lahir`, `pembayaran_berhasil`, `no_telp`, `pembayaran_batal`, `menunggu_pembayaran`, `alamat`) VALUES
(1, 'Sultan Baharuddin Ulil Amrie', 'sultan.emoticons@gmail.com', 'rahaisa', 'Laki-Laki', '1999-08-25', '0', '082290459499', '0', '2', 'Jl. Dg. Ramang'),
(2, 'Gab Hozana', 'gabhozna@gmail.com', 'sembarangmokapang', 'Laki-Laki', '1998-07-22', '0', '082222445611', '0', '0', 'Gua'),
(3, 'Kimi Hime', 'mahasiswagagal@gmail.com', 'rahasiailahi', 'Perempuan', '1998-02-04', '1', '082696969696', '3', '0', 'Jakarta'),
(4, 'Sultan Agunf', 'sultan.agung@tuta.io', 'masihrahasia', 'Laki-Laki', '1999-06-12', '0', '082000001002', '6', '0', 'Makassar'),
(5, 'Puji Astuti', 'purwarupa@gmail.com', 'tetaprahasia', 'Perempuan', '1987-07-01', '2', '081454678987', '0', '1', 'Makassar'),
(33, 'Gabs', 'admingabs@gmail.com', '12345678', 'Laki - La', '1997-09-14', '0', '083244423332', '0', '1', 'Gowa'),
(34, 'Gabs', 'admingabs@gmail.com', '12345678', 'Laki - La', '1997-09-14', '0', '083244423332', '0', '1', 'Gowa');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `status_pembayaran` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_bank`, `status_pembayaran`) VALUES
(1, 1, 'Belum Bayar'),
(2, 2, 'Belum Bayar'),
(3, 3, 'Belum Bayar');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_pembayaran` int(11) NOT NULL,
  `status_pengiriman` varchar(255) NOT NULL,
  `barang_diterima` varchar(255) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `total_keseluruhan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_pelanggan`, `id_pembayaran`, `status_pengiriman`, `barang_diterima`, `tanggal_transaksi`, `total_keseluruhan`) VALUES
(10, 1, 1, 'Belum Terkirim', 'Belum Diterima', '2018-12-31', 0),
(11, 1, 2, 'Belum Dikirim', 'Belum Diterima', '2019-01-05', 0),
(12, 5, 1, 'Belum Dikirim', 'Belum Diterima', '2019-01-04', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_kategori_child` (`id_kategori_child`);

--
-- Indexes for table `barang_log`
--
ALTER TABLE `barang_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_transaksi` (`id_transaksi`);

--
-- Indexes for table `kategori_child`
--
ALTER TABLE `kategori_child`
  ADD PRIMARY KEY (`id_kategori_child`),
  ADD KEY `id_kategori_parent` (`id_kategori_parent`);

--
-- Indexes for table `kategori_parent`
--
ALTER TABLE `kategori_parent`
  ADD PRIMARY KEY (`id_kategori_parent`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_barang` (`id_barang`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_bank` (`id_bank`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_pembayaran` (`id_pembayaran`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `barang_log`
--
ALTER TABLE `barang_log`
  MODIFY `id_log` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `kategori_parent`
--
ALTER TABLE `kategori_parent`
  MODIFY `id_kategori_parent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `detail_transaksi_ibfk_3` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`);

--
-- Constraints for table `kategori_child`
--
ALTER TABLE `kategori_child`
  ADD CONSTRAINT `kategori_child_ibfk_1` FOREIGN KEY (`id_kategori_parent`) REFERENCES `kategori_parent` (`id_kategori_parent`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `keranjang_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_pembayaran`) REFERENCES `pembayaran` (`id_pembayaran`),
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
