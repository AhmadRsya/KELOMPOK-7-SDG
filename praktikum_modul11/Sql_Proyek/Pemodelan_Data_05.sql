-- ------------------------------------------------------------
-- 3. Memetakan objek ke tabel relasional
--    Atribut umum  -> kolom biasa
--    Jenis objek   -> kolom jenis_produk
--    Atribut khusus tiap kelas -> kolom JSON (spesifikasi)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS produk_objek (
    id_produk    INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk  VARCHAR(150) NOT NULL,
    jenis_produk VARCHAR(50)  NOT NULL,
    harga        DECIMAL(12,2) NOT NULL,
    spesifikasi  JSON
) ENGINE=InnoDB;

INSERT INTO produk_objek (nama_produk, jenis_produk, harga, spesifikasi)
VALUES
('Laptop Pro', 'Laptop', 8500000,
 '{"ram": "16GB", "storage": "512GB SSD", "prosesor": "Intel Core i7"}'),
('Smartphone X', 'Smartphone', 4500000,
 '{"ram": "8GB", "kamera": "50MP", "baterai": "5000mAh"}');

SELECT * FROM produk_objek;

-- ------------------------------------------------------------
-- 4. Mengambil data berdasarkan jenis objek
-- ------------------------------------------------------------
SELECT id_produk, nama_produk, harga, spesifikasi
FROM produk_objek WHERE jenis_produk = 'Laptop';

SELECT id_produk, nama_produk, harga, spesifikasi
FROM produk_objek WHERE jenis_produk = 'Smartphone';

-- ------------------------------------------------------------
-- 5. Menggabungkan data objek (JSON) dan relasional (JOIN)
-- ------------------------------------------------------------
SELECT p.nama_produk, k.nama_kategori, p.harga,
       JSON_UNQUOTE(JSON_EXTRACT(p.spesifikasi, '$.ram')) AS ram,
       p.spesifikasi
FROM produk p
JOIN kategori k ON k.id_kategori = p.id_kategori;
