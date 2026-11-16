-- 4. Membaca atribut JSON
--    (hasil bertanda kutip karena bertipe string JSON;
--     produk tanpa atribut tersebut menghasilkan NULL)
-- ------------------------------------------------------------
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram
FROM produk;

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.storage') AS kapasitas_storage
FROM produk;

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.baterai') AS kapasitas_baterai
FROM produk;

-- ------------------------------------------------------------
-- 5. Mengubah atribut JSON (RAM laptop 16GB -> 32GB)
-- ------------------------------------------------------------
UPDATE produk
SET spesifikasi = JSON_SET(spesifikasi, '$.ram', '32GB')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram
FROM produk WHERE nama_produk = 'Laptop Pro';

-- ------------------------------------------------------------
-- 6. Menambahkan atribut JSON baru (warna) tanpa ALTER TABLE
-- ------------------------------------------------------------
UPDATE produk
SET spesifikasi = JSON_SET(spesifikasi, '$.warna', 'Silver')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, spesifikasi FROM produk
WHERE nama_produk = 'Laptop Pro';

-- ------------------------------------------------------------
-- 7. Menghapus atribut JSON (warna)
-- ------------------------------------------------------------
UPDATE produk
SET spesifikasi = JSON_REMOVE(spesifikasi, '$.warna')
WHERE nama_produk = 'Laptop Pro';

SELECT nama_produk, spesifikasi FROM produk;

-- ------------------------------------------------------------
-- 8. Mencari produk berdasarkan atribut JSON
-- ------------------------------------------------------------
-- RAM 16GB (tidak ada hasil: RAM laptop sudah diubah jadi 32GB di langkah 5)
SELECT nama_produk, harga, spesifikasi FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '16GB';

-- RAM 32GB (menemukan Laptop Pro)
SELECT nama_produk, harga, spesifikasi FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '32GB';

-- Storage 256GB (menemukan Smartphone X)
SELECT nama_produk, harga FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.storage')) = '256GB';

-- ------------------------------------------------------------
-- 9. Menguji fungsi JSON lainnya
-- ------------------------------------------------------------
SELECT JSON_OBJECT('nama', 'Budi', 'umur', 21, 'status', 'Mahasiswa')
       AS data_mahasiswa;

SELECT JSON_ARRAY('WiFi', 'Bluetooth', 'USB-C') AS daftar_fitur;

SELECT JSON_VALID('{"nama":"Budi","umur":21}') AS json_valid;

-- Jumlah atribut level atas (array fitur dihitung satu)
SELECT nama_produk, JSON_LENGTH(spesifikasi) AS jumlah_atribut
FROM produk;
