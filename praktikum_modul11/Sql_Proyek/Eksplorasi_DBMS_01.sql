-- 1. Versi dan jenis DBMS
SELECT VERSION();
SELECT @@version_comment;

-- 2. Daftar database yang ada
SHOW DATABASES;

-- 3. Karakter set dan collation server
SHOW VARIABLES LIKE 'character_set_server';
SHOW VARIABLES LIKE 'collation_server';

-- 4. Storage engine (cari yang berstatus DEFAULT -> InnoDB)
SHOW ENGINES;

-- 5. Cek dukungan fitur JSON
SELECT JSON_VALID('{"nama":"Budi"}') AS json_valid,
       JSON_EXTRACT('{"nama":"Budi"}', '$.nama') AS nama;

-- 6. Waktu server dan database aktif
SELECT NOW();
SELECT DATABASE();
