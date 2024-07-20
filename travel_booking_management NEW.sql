-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 20 Jul 2024 pada 19.17
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel_booking_management`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookingDetails` (IN `customerID` INT, OUT `totalPayments` DECIMAL(10,2))   BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(JumlahPembayaran) INTO total FROM Pembayaran WHERE IDPelanggan = customerID;
    SET totalPayments = total;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListAllCustomers` ()   BEGIN
    SELECT * FROM DetailPelanggan;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetCustomerDetails` (`ID` INT, `Field` VARCHAR(10)) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE customerDetail VARCHAR(50);
    
    IF Field = 'Email' THEN
        SELECT Email INTO customerDetail FROM DetailPelanggan WHERE IDPelanggan = ID;
    ELSEIF Field = 'Nama' THEN
        SELECT NamaLengkap INTO customerDetail FROM DetailPelanggan WHERE IDPelanggan = ID;
    ELSE
        SET customerDetail = 'Invalid Field';
    END IF;

    RETURN customerDetail;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetCustomerEmail` (`ID` INT) RETURNS VARCHAR(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE customerEmail VARCHAR(50);
    SELECT Email INTO customerEmail FROM DetailPelanggan WHERE IDPelanggan = ID;
    RETURN customerEmail;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TotalCustomers` () RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM DetailPelanggan;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bus`
--

CREATE TABLE `bus` (
  `IDBus` int(11) NOT NULL,
  `NomorBus` varchar(10) DEFAULT NULL,
  `Operator` varchar(50) DEFAULT NULL,
  `WaktuBerangkat` datetime DEFAULT NULL,
  `WaktuTiba` datetime DEFAULT NULL,
  `Asal` varchar(50) DEFAULT NULL,
  `Tujuan` varchar(50) DEFAULT NULL,
  `IDTujuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bus`
--

INSERT INTO `bus` (`IDBus`, `NomorBus`, `Operator`, `WaktuBerangkat`, `WaktuTiba`, `Asal`, `Tujuan`, `IDTujuan`) VALUES
(1, 'B001', 'PO Haryanto', '2024-03-18 08:00:00', '2024-03-18 10:00:00', 'Jakarta', 'Bandung', 202),
(2, 'B002', 'Lorena', '2024-03-18 10:00:00', '2024-03-18 12:00:00', 'Jakarta', 'Semarang', 101),
(3, 'B003', 'Rosalia Indah', '2024-03-18 12:00:00', '2024-03-18 15:00:00', 'Jakarta', 'Surabaya', 203),
(4, 'B004', 'Murni Jaya', '2024-03-18 14:00:00', '2024-03-18 17:00:00', 'Jakarta', 'Yogyakarta', 204),
(5, 'B005', 'Kramat Djati', '2024-03-18 16:00:00', '2024-03-18 18:00:00', 'Jakarta', 'Medan', 206),
(6, 'B006', 'Primajasa', '2024-03-18 18:00:00', '2024-03-18 20:00:00', 'Bandung', 'Jakarta', 201),
(7, 'B007', 'Agra Mas', '2024-03-18 20:00:00', '2024-03-19 02:00:00', 'Jakarta', 'Solo', 104),
(8, 'B008', 'Sinar Jaya', '2024-03-18 22:00:00', '2024-03-19 01:00:00', 'Jakarta', 'Bali', 205),
(9, 'B009', 'SAN', '2024-03-19 01:00:00', '2024-03-19 06:00:00', 'Jakarta', 'Palembang', 102),
(10, 'B010', 'Medan Jaya', '2024-03-19 03:00:00', '2024-03-19 05:00:00', 'Medan', 'Pekanbaru', 103);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detailpelanggan`
--

CREATE TABLE `detailpelanggan` (
  `IDPelanggan` int(11) NOT NULL,
  `NamaLengkap` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Telepon` varchar(10) DEFAULT NULL,
  `BuktiIdentitas` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `detailpelanggan`
--

INSERT INTO `detailpelanggan` (`IDPelanggan`, `NamaLengkap`, `Email`, `Telepon`, `BuktiIdentitas`) VALUES
(1, 'Nur Ahmad Fathi BR', 'fathi@gmail.com', '0812345678', 'KTP'),
(2, 'Moch Aliffian', 'alif@gmail.com', '0812345677', 'SIM'),
(3, 'M. Ikhsan', 'ikhsan@gmail.com', '0812345676', 'KTP'),
(4, 'Riyan Andhika', 'riyan@gmail.com', '0812345675', 'KTP'),
(5, 'Aldan Maulana', 'aldan@gmail.com', '0812345674', 'PASPORT'),
(6, 'Farhan Syahid', 'farhan@gmail.com', '0812345673', 'KTP'),
(7, 'Dewi Lestari', 'dewi@gmail.com', '0812345672', 'KTP'),
(8, 'Armin Santoso', 'armin@gmail.com', '0812345671', 'SIM'),
(9, 'Rina Aulia', 'rina@gmail.com', '0812345670', 'KTP'),
(10, 'Agus Susanto', 'agus@gmail.com', '0812345669', 'PASPORT');

--
-- Trigger `detailpelanggan`
--
DELIMITER $$
CREATE TRIGGER `AfterDeleteDetailPelanggan` AFTER DELETE ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, OldValue) 
    VALUES ('DELETE', 'DetailPelanggan', OLD.NamaLengkap);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterInsertDetailPelanggan` AFTER INSERT ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, NewValue) 
    VALUES ('INSERT', 'DetailPelanggan', NEW.NamaLengkap);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AfterUpdateDetailPelanggan` AFTER UPDATE ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, OldValue, NewValue) 
    VALUES ('UPDATE', 'DetailPelanggan', OLD.NamaLengkap, NEW.NamaLengkap);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeDeleteDetailPelanggan` BEFORE DELETE ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, OldValue) 
    VALUES ('DELETE', 'DetailPelanggan', OLD.NamaLengkap);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeInsertDetailPelanggan` BEFORE INSERT ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, NewValue) 
    VALUES ('INSERT', 'DetailPelanggan', NEW.NamaLengkap);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `BeforeUpdateDetailPelanggan` BEFORE UPDATE ON `detailpelanggan` FOR EACH ROW BEGIN
    INSERT INTO LogTable (OperationType, TableName, OldValue, NewValue) 
    VALUES ('UPDATE', 'DetailPelanggan', OLD.NamaLengkap, NEW.NamaLengkap);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `indextable`
--

CREATE TABLE `indextable` (
  `ID` int(11) NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kapalpesiar`
--

CREATE TABLE `kapalpesiar` (
  `IDKapalPesiar` int(11) NOT NULL,
  `NamaKapalPesiar` varchar(50) DEFAULT NULL,
  `WaktuBerangkat` datetime DEFAULT NULL,
  `WaktuTiba` datetime DEFAULT NULL,
  `Asal` varchar(50) DEFAULT NULL,
  `Tujuan` varchar(50) DEFAULT NULL,
  `IDTujuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kapalpesiar`
--

INSERT INTO `kapalpesiar` (`IDKapalPesiar`, `NamaKapalPesiar`, `WaktuBerangkat`, `WaktuTiba`, `Asal`, `Tujuan`, `IDTujuan`) VALUES
(1, 'Jakarta ke Bali Cruise', '2024-03-18 08:00:00', '2024-03-18 20:00:00', 'Jakarta', 'Bali', 205),
(2, 'Bali ke Lombok Cruise', '2024-03-18 10:00:00', '2024-03-18 22:00:00', 'Bali', 'Lombok', 206),
(3, 'Surabaya ke Makassar Cruise', '2024-03-18 12:00:00', '2024-03-18 23:00:00', 'Surabaya', 'Makassar', 207),
(4, 'Jakarta ke Singapore Cruise', '2024-03-18 14:00:00', '2024-03-18 23:00:00', 'Jakarta', 'Singapura', 302),
(5, 'Bali ke Jakarta Cruise', '2024-03-18 16:00:00', '2024-03-19 01:00:00', 'Bali', 'Jakarta', 201),
(6, 'Jakarta ke Lombok Cruise', '2024-03-18 18:00:00', '2024-03-19 04:00:00', 'Jakarta', 'Lombok', 206),
(7, 'Surabaya ke Bali Cruise', '2024-03-18 20:00:00', '2024-03-19 08:00:00', 'Surabaya', 'Bali', 205),
(8, 'Makassar ke Jakarta Cruise', '2024-03-18 22:00:00', '2024-03-19 10:00:00', 'Makassar', 'Jakarta', 201),
(9, 'Lombok ke Singapore Cruise', '2024-03-19 01:00:00', '2024-03-19 10:00:00', 'Lombok', 'Singapura', 302),
(10, 'Singapore ke Jakarta Cruise', '2024-03-19 03:00:00', '2024-03-19 16:00:00', 'Singapura', 'Jakarta', 201);

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan`
--

CREATE TABLE `karyawan` (
  `IDKaryawan` int(11) NOT NULL,
  `NamaKaryawan` varchar(50) DEFAULT NULL,
  `Departemen` varchar(50) DEFAULT NULL,
  `GajiKaryawan` int(11) DEFAULT NULL,
  `PosisiKaryawan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `karyawan`
--

INSERT INTO `karyawan` (`IDKaryawan`, `NamaKaryawan`, `Departemen`, `GajiKaryawan`, `PosisiKaryawan`) VALUES
(1, 'Budi Santoso', 'Bus', 54000, 'Sopir'),
(2, 'Siti Aminah', 'Mobil', 55000, 'Pemandu'),
(3, 'Joko Widodo', 'Kereta', 60000, 'Pengawas'),
(4, 'Dwi Sri Lestari', 'Pesawat', 65000, 'Agen Pemesanan'),
(5, 'Asep Sunandar', 'Kapal Pesiar', 70000, 'Pemandu'),
(6, 'Rina Aditama', 'Bus', 54000, 'Sopir'),
(7, 'Agus Santoso', 'Mobil', 55000, 'Pemandu'),
(8, 'Siti Rahayu', 'Kereta', 60000, 'Pengawas'),
(9, 'Ahmad Hidayat', 'Pesawat', 65000, 'Agen Pemesanan'),
(10, 'Nurul Fitri', 'Kapal Pesiar', 70000, 'Pemandu');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kereta`
--

CREATE TABLE `kereta` (
  `IDKereta` int(11) NOT NULL,
  `NamaKereta` varchar(50) DEFAULT NULL,
  `WaktuBerangkat` time DEFAULT NULL,
  `WaktuTiba` time DEFAULT NULL,
  `Asal` varchar(50) DEFAULT NULL,
  `Tujuan` varchar(50) DEFAULT NULL,
  `IDTujuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kereta`
--

INSERT INTO `kereta` (`IDKereta`, `NamaKereta`, `WaktuBerangkat`, `WaktuTiba`, `Asal`, `Tujuan`, `IDTujuan`) VALUES
(1, 'Argo Bromo Anggrek', '08:00:00', '15:00:00', 'Jakarta', 'Surabaya', 203),
(2, 'Argo Parahyangan', '09:00:00', '14:00:00', 'Jakarta', 'Bandung', 202),
(3, 'Argo Dwipangga', '10:00:00', '17:00:00', 'Jakarta', 'Solo', 104),
(4, 'Lodaya', '11:00:00', '18:00:00', 'Bandung', 'Yogyakarta', 204),
(5, 'Sancaka', '12:00:00', '19:00:00', 'Yogyakarta', 'Surabaya', 203),
(6, 'Taksaka', '13:00:00', '20:00:00', 'Jakarta', 'Yogyakarta', 204),
(7, 'Majapahit', '14:00:00', '21:00:00', 'Malang', 'Jakarta', 201),
(8, 'Jayabaya', '15:00:00', '22:00:00', 'Jakarta', 'Malang', 201),
(9, 'Senja Utama Solo', '16:00:00', '23:00:00', 'Jakarta', 'Solo', 104),
(10, 'Matarmaja', '17:00:00', '00:00:00', 'Jakarta', 'Malang', 201);

-- --------------------------------------------------------

--
-- Struktur dari tabel `logtable`
--

CREATE TABLE `logtable` (
  `LogID` int(11) NOT NULL,
  `OperationType` varchar(10) DEFAULT NULL,
  `TableName` varchar(50) DEFAULT NULL,
  `OldValue` varchar(255) DEFAULT NULL,
  `NewValue` varchar(255) DEFAULT NULL,
  `ChangeTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `logtable`
--

INSERT INTO `logtable` (`LogID`, `OperationType`, `TableName`, `OldValue`, `NewValue`, `ChangeTime`) VALUES
(1, 'INSERT', 'DetailPelanggan', NULL, 'Sari Dewi', '2024-07-20 12:11:10'),
(2, 'UPDATE', 'DetailPelanggan', 'Sari Dewi', 'Sari Dewi Putri', '2024-07-20 13:03:24'),
(3, 'DELETE', 'DetailPelanggan', 'Sari Dewi Putri', NULL, '2024-07-20 13:15:20'),
(4, 'INSERT', 'DetailPelanggan', NULL, 'Hamzah Shafa', '2024-07-20 13:33:03'),
(5, 'INSERT', 'DetailPelanggan', NULL, 'Hamzah Shafa', '2024-07-20 13:33:03'),
(6, 'UPDATE', 'DetailPelanggan', 'Hamzah Shafa', 'Hamzah Shafa Tandyayuda', '2024-07-20 13:37:08'),
(7, 'UPDATE', 'DetailPelanggan', 'Hamzah Shafa', 'Hamzah Shafa Tandyayuda', '2024-07-20 13:37:08'),
(8, 'DELETE', 'DetailPelanggan', 'Hamzah Shafa Tandyayuda', NULL, '2024-07-20 13:41:59'),
(9, 'DELETE', 'DetailPelanggan', 'Hamzah Shafa Tandyayuda', NULL, '2024-07-20 13:41:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mobil`
--

CREATE TABLE `mobil` (
  `IDMobil` int(11) NOT NULL,
  `ModelMobil` varchar(50) DEFAULT NULL,
  `NomorPlat` varchar(20) DEFAULT NULL,
  `Kapasitas` int(11) DEFAULT NULL,
  `Asal` varchar(50) DEFAULT NULL,
  `Tujuan` varchar(50) DEFAULT NULL,
  `IDTujuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mobil`
--

INSERT INTO `mobil` (`IDMobil`, `ModelMobil`, `NomorPlat`, `Kapasitas`, `Asal`, `Tujuan`, `IDTujuan`) VALUES
(101, 'Toyota Innova', 'B1234ABC', 7, 'Jakarta', 'Bandung', 202),
(102, 'Maruti Swift', 'B5678DEF', 5, 'Bandung', 'Jakarta', 201),
(103, 'Honda City', 'B9012GHI', 5, 'Surabaya', 'Yogyakarta', 204),
(104, 'Hyundai i20', 'B3456JKL', 5, 'Yogyakarta', 'Semarang', 205),
(105, 'Ford EcoSport', 'B6789MNO', 5, 'Semarang', 'Surabaya', 203),
(106, 'Volkswagen Polo', 'B0123PQR', 5, 'Denpasar', 'Makassar', 207),
(107, 'Toyota Corolla', 'B3456STU', 5, 'Makassar', 'Denpasar', 206),
(108, 'Renault Kwid', 'B6789VWX', 5, 'Medan', 'Banda Aceh', 102),
(109, 'Honda Civic', 'B0123YZA', 5, 'Banda Aceh', 'Padang', 103),
(110, 'Mahindra Scorpio', 'B3456BCD', 7, 'Padang', 'Medan', 101);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `IDPembayaran` int(11) NOT NULL,
  `MetodePembayaran` varchar(50) DEFAULT NULL,
  `JumlahPembayaran` decimal(10,2) DEFAULT NULL,
  `TanggalPembayaran` date DEFAULT NULL,
  `IDPelanggan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`IDPembayaran`, `MetodePembayaran`, `JumlahPembayaran`, `TanggalPembayaran`, `IDPelanggan`) VALUES
(101, 'Kartu Kredit', 5000.00, '2023-01-15', 1),
(102, 'Kartu Debit', 3000.00, '2023-02-20', 2),
(103, 'Perbankan Internet', 2000.00, '2023-03-25', 3),
(104, 'Transfer Bank', 4000.00, '2023-04-30', 4),
(105, 'Tunai', 2500.00, '2023-05-05', 5),
(106, 'Kartu Kredit', 3500.00, '2023-06-10', 6),
(107, 'Kartu Debit', 2800.00, '2023-07-15', 7),
(108, 'Perbankan Internet', 1800.00, '2023-08-20', 8),
(109, 'Transfer Bank', 4200.00, '2023-09-25', 9),
(110, 'Tunai', 2300.00, '2023-10-30', 10);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan`
--

CREATE TABLE `pemesanan` (
  `IDPemesanan` int(11) NOT NULL,
  `IDPelanggan` int(11) DEFAULT NULL,
  `StatusPemesanan` varchar(20) DEFAULT NULL,
  `IDPembayaran` int(11) DEFAULT NULL,
  `WaktuPemesanan` datetime DEFAULT NULL,
  `Transportasi` varchar(50) DEFAULT NULL,
  `Asal` varchar(50) NOT NULL,
  `Tujuan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pemesanan`
--

INSERT INTO `pemesanan` (`IDPemesanan`, `IDPelanggan`, `StatusPemesanan`, `IDPembayaran`, `WaktuPemesanan`, `Transportasi`, `Asal`, `Tujuan`) VALUES
(1, 1, 'Terkonfirmasi', 101, '2024-03-10 08:00:00', 'PO Haryanto', 'Jakarta', 'Bandung'),
(2, 2, 'Terkonfirmasi', 102, '2024-03-10 10:00:00', 'B3456BCD', 'Jakarta', 'Semarang'),
(3, 3, 'Terkonfirmasi', 103, '2024-03-10 12:00:00', 'GA101', 'Jakarta', 'Surabaya'),
(4, 4, 'Terkonfirmasi', 104, '2024-03-10 14:00:00', NULL, 'Jakarta', 'Yogyakarta'),
(5, 5, 'Terkonfirmasi', 105, '2024-03-10 16:00:00', 'Surabaya ke Makassar Cruise', 'Surabaya', 'Makassar'),
(6, 6, 'Terkonfirmasi', 106, '2024-03-10 18:00:00', 'Kramat Djati', 'Jakarta', 'Medan'),
(7, 7, 'Terkonfirmasi', 107, '2024-03-10 20:00:00', 'B0123YZA', 'Jakarta', 'Banjarmasin'),
(8, 8, 'Terkonfirmasi', 108, '2024-03-10 22:00:00', NULL, 'Jakarta', 'Frankfurt'),
(9, 9, 'Terkonfirmasi', 109, '2024-03-11 01:00:00', 'QF301', 'Jakarta', 'Sydney'),
(10, 10, 'Terkonfirmasi', 110, '2024-03-11 03:00:00', NULL, 'Singapura', 'Jakarta');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerbangan`
--

CREATE TABLE `penerbangan` (
  `IDPenerbangan` int(11) NOT NULL,
  `NomorPenerbangan` varchar(10) DEFAULT NULL,
  `Maskapai` varchar(50) DEFAULT NULL,
  `WaktuBerangkat` datetime DEFAULT NULL,
  `WaktuTiba` datetime DEFAULT NULL,
  `Asal` varchar(50) DEFAULT NULL,
  `Tujuan` varchar(50) DEFAULT NULL,
  `IDTujuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penerbangan`
--

INSERT INTO `penerbangan` (`IDPenerbangan`, `NomorPenerbangan`, `Maskapai`, `WaktuBerangkat`, `WaktuTiba`, `Asal`, `Tujuan`, `IDTujuan`) VALUES
(1, 'GA101', 'Garuda Indonesia', '2024-03-18 08:00:00', '2024-03-18 10:00:00', 'Jakarta', 'Surabaya', 203),
(2, 'GA102', 'Garuda Indonesia', '2024-03-18 10:00:00', '2024-03-18 12:00:00', 'Jakarta', 'Bandung', 202),
(3, 'GA103', 'Garuda Indonesia', '2024-03-18 12:00:00', '2024-03-18 15:00:00', 'Jakarta', 'Medan', 206),
(4, 'GA104', 'Garuda Indonesia', '2024-03-18 14:00:00', '2024-03-18 17:00:00', 'Jakarta', 'Bali', 205),
(5, 'SQ201', 'Singapore Airlines', '2024-03-18 16:00:00', '2024-03-18 18:00:00', 'Jakarta', 'Singapura', 302),
(6, 'QZ301', 'AirAsia', '2024-03-18 18:00:00', '2024-03-18 20:00:00', 'Surabaya', 'Kuala Lumpur', 302),
(7, 'MH101', 'Malaysia Airlines', '2024-03-18 20:00:00', '2024-03-19 02:00:00', 'Jakarta', 'Kuala Lumpur', 302),
(8, 'LH201', 'Lufthansa', '2024-03-18 22:00:00', '2024-03-19 01:00:00', 'Jakarta', 'Frankfurt', 304),
(9, 'QF301', 'Qantas', '2024-03-19 01:00:00', '2024-03-19 06:00:00', 'Jakarta', 'Sydney', 305),
(10, 'SQ204', 'Singapore Airlines', '2024-03-19 03:00:00', '2024-03-19 05:00:00', 'Surabaya', 'Singapura', 302);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tujuan`
--

CREATE TABLE `tujuan` (
  `IDTujuan` int(11) NOT NULL,
  `NamaTujuan` varchar(50) DEFAULT NULL,
  `Jarak` int(11) DEFAULT NULL,
  `Negara` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tujuan`
--

INSERT INTO `tujuan` (`IDTujuan`, `NamaTujuan`, `Jarak`, `Negara`) VALUES
(1, 'Bandung', 1200, 'Indonesia'),
(101, 'Semarang', 0, 'Indonesia'),
(102, 'Palembang', 400, 'Indonesia'),
(103, 'Banjarmasin', 900, 'Indonesia'),
(104, 'Pontianak', 750, 'Indonesia'),
(201, 'Jakarta', 0, 'Indonesia'),
(202, 'Bandung', 150, 'Indonesia'),
(203, 'Surabaya', 800, 'Indonesia'),
(204, 'Yogyakarta', 600, 'Indonesia'),
(205, 'Bali', 1150, 'Indonesia'),
(206, 'Medan', 1420, 'Indonesia'),
(207, 'Makassar', 1650, 'Indonesia'),
(301, 'London', 12768, 'United Kingdom'),
(302, 'Singapura', 5567, 'Singapura'),
(303, 'Dubai', 767, 'Uni Emirat Arab'),
(304, 'Frankfurt', 7898, 'Jerman'),
(305, 'Sydney', 9783, 'Australia');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vw_horizontalpemesanan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vw_horizontalpemesanan` (
`IDPemesanan` int(11)
,`IDPelanggan` int(11)
,`StatusPemesanan` varchar(20)
,`IDPembayaran` int(11)
,`WaktuPemesanan` datetime
,`Transportasi` varchar(50)
,`Asal` varchar(50)
,`Tujuan` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vw_tujuandenganjarak`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vw_tujuandenganjarak` (
`IDTujuan` int(11)
,`NamaTujuan` varchar(50)
,`Jarak` int(11)
,`Negara` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vw_validtujuan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vw_validtujuan` (
`IDTujuan` int(11)
,`NamaTujuan` varchar(50)
,`Jarak` int(11)
,`Negara` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vw_verticalpemesanan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vw_verticalpemesanan` (
`IDPemesanan` int(11)
,`IDPelanggan` int(11)
,`StatusPemesanan` varchar(20)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `vw_horizontalpemesanan`
--
DROP TABLE IF EXISTS `vw_horizontalpemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_horizontalpemesanan`  AS SELECT `pemesanan`.`IDPemesanan` AS `IDPemesanan`, `pemesanan`.`IDPelanggan` AS `IDPelanggan`, `pemesanan`.`StatusPemesanan` AS `StatusPemesanan`, `pemesanan`.`IDPembayaran` AS `IDPembayaran`, `pemesanan`.`WaktuPemesanan` AS `WaktuPemesanan`, `pemesanan`.`Transportasi` AS `Transportasi`, `pemesanan`.`Asal` AS `Asal`, `pemesanan`.`Tujuan` AS `Tujuan` FROM `pemesanan` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vw_tujuandenganjarak`
--
DROP TABLE IF EXISTS `vw_tujuandenganjarak`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_tujuandenganjarak`  AS SELECT `tujuan`.`IDTujuan` AS `IDTujuan`, `tujuan`.`NamaTujuan` AS `NamaTujuan`, `tujuan`.`Jarak` AS `Jarak`, `tujuan`.`Negara` AS `Negara` FROM `tujuan` WHERE `tujuan`.`Jarak` < 1500 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vw_validtujuan`
--
DROP TABLE IF EXISTS `vw_validtujuan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_validtujuan`  AS SELECT `vw_tujuandenganjarak`.`IDTujuan` AS `IDTujuan`, `vw_tujuandenganjarak`.`NamaTujuan` AS `NamaTujuan`, `vw_tujuandenganjarak`.`Jarak` AS `Jarak`, `vw_tujuandenganjarak`.`Negara` AS `Negara` FROM `vw_tujuandenganjarak`WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vw_verticalpemesanan`
--
DROP TABLE IF EXISTS `vw_verticalpemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_verticalpemesanan`  AS SELECT `pemesanan`.`IDPemesanan` AS `IDPemesanan`, `pemesanan`.`IDPelanggan` AS `IDPelanggan`, `pemesanan`.`StatusPemesanan` AS `StatusPemesanan` FROM `pemesanan` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`IDBus`),
  ADD KEY `IDTujuan` (`IDTujuan`);

--
-- Indeks untuk tabel `detailpelanggan`
--
ALTER TABLE `detailpelanggan`
  ADD PRIMARY KEY (`IDPelanggan`),
  ADD KEY `idx_NamaLengkap_Telepon` (`NamaLengkap`,`Telepon`);

--
-- Indeks untuk tabel `indextable`
--
ALTER TABLE `indextable`
  ADD PRIMARY KEY (`ID`,`Email`);

--
-- Indeks untuk tabel `kapalpesiar`
--
ALTER TABLE `kapalpesiar`
  ADD PRIMARY KEY (`IDKapalPesiar`),
  ADD KEY `IDTujuan` (`IDTujuan`);

--
-- Indeks untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`IDKaryawan`);

--
-- Indeks untuk tabel `kereta`
--
ALTER TABLE `kereta`
  ADD PRIMARY KEY (`IDKereta`),
  ADD KEY `IDTujuan` (`IDTujuan`);

--
-- Indeks untuk tabel `logtable`
--
ALTER TABLE `logtable`
  ADD PRIMARY KEY (`LogID`);

--
-- Indeks untuk tabel `mobil`
--
ALTER TABLE `mobil`
  ADD PRIMARY KEY (`IDMobil`),
  ADD KEY `IDTujuan` (`IDTujuan`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`IDPembayaran`),
  ADD KEY `idx_IDPelanggan_TanggalPembayaran` (`IDPelanggan`,`TanggalPembayaran`);

--
-- Indeks untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`IDPemesanan`),
  ADD KEY `IDPelanggan` (`IDPelanggan`),
  ADD KEY `IDPembayaran` (`IDPembayaran`);

--
-- Indeks untuk tabel `penerbangan`
--
ALTER TABLE `penerbangan`
  ADD PRIMARY KEY (`IDPenerbangan`),
  ADD KEY `IDTujuan` (`IDTujuan`);

--
-- Indeks untuk tabel `tujuan`
--
ALTER TABLE `tujuan`
  ADD PRIMARY KEY (`IDTujuan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `logtable`
--
ALTER TABLE `logtable`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bus`
--
ALTER TABLE `bus`
  ADD CONSTRAINT `bus_ibfk_1` FOREIGN KEY (`IDTujuan`) REFERENCES `tujuan` (`IDTujuan`);

--
-- Ketidakleluasaan untuk tabel `kapalpesiar`
--
ALTER TABLE `kapalpesiar`
  ADD CONSTRAINT `kapalpesiar_ibfk_1` FOREIGN KEY (`IDTujuan`) REFERENCES `tujuan` (`IDTujuan`);

--
-- Ketidakleluasaan untuk tabel `kereta`
--
ALTER TABLE `kereta`
  ADD CONSTRAINT `kereta_ibfk_1` FOREIGN KEY (`IDTujuan`) REFERENCES `tujuan` (`IDTujuan`);

--
-- Ketidakleluasaan untuk tabel `mobil`
--
ALTER TABLE `mobil`
  ADD CONSTRAINT `mobil_ibfk_1` FOREIGN KEY (`IDTujuan`) REFERENCES `tujuan` (`IDTujuan`);

--
-- Ketidakleluasaan untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`IDPelanggan`) REFERENCES `detailpelanggan` (`IDPelanggan`);

--
-- Ketidakleluasaan untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`IDPelanggan`) REFERENCES `detailpelanggan` (`IDPelanggan`),
  ADD CONSTRAINT `pemesanan_ibfk_2` FOREIGN KEY (`IDPembayaran`) REFERENCES `pembayaran` (`IDPembayaran`);

--
-- Ketidakleluasaan untuk tabel `penerbangan`
--
ALTER TABLE `penerbangan`
  ADD CONSTRAINT `penerbangan_ibfk_1` FOREIGN KEY (`IDTujuan`) REFERENCES `tujuan` (`IDTujuan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
