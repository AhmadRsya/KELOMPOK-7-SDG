CREATE DATABASE IF NOT EXISTS praktikum_modul11;
USE praktikum_modul11;

-- Tabel kategori
CREATE TABLE IF NOT EXISTS kategori (
    id_kategori   INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Tabel produk (kolom spesifikasi bertipe JSON)
CREATE TABLE IF NOT EXISTS produk (
    id_produk   INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga       DECIMAL(12,2) NOT NULL,
    spesifikasi JSON NOT NULL,
    CONSTRAINT fk_produk_kategori
        FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
) ENGINE=InnoDB;

-- Data kategori
INSERT INTO kategori (nama_kategori)
VALUES ('Laptop'), ('Smartphone'), ('Layanan Digital');

SELECT * FROM kategori;

-- Data produk dengan atribut JSON yang berbeda-beda
INSERT INTO produk (id_kategori, nama_produk, harga, spesifikasi)
VALUES (1, 'Laptop Pro', 8500000,
  '{"ram": "16GB", "storage": "512GB SSD",
    "prosesor": "Intel Core i7", "ukuran_layar": "14 inch"}');

INSERT INTO produk (id_kategori, nama_produk, harga, spesifikasi)
VALUES (2, 'Smartphone X', 4500000,
  '{"ram": "8GB", "storage": "256GB",
    "kamera": "50MP", "baterai": "5000mAh"}');

INSERT INTO produk (id_kategori, nama_produk, harga, spesifikasi)
VALUES (3, 'Paket Premium', 150000,
  '{"durasi": "30 hari", "jumlah_pengguna": 5,
    "fitur": ["Cloud Storage", "Backup", "Multi Device"]}');

SELECT * FROM produk;
