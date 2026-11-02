DROP DATABASE IF EXISTS airkita;
CREATE DATABASE airkita
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE airkita;

 1. TABEL

 Entitas Pengguna (data store D1 sisi pelapor)
CREATE TABLE pengguna (
    id_pengguna INT          NOT NULL AUTO_INCREMENT,
    nama        VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_pengguna)
) ENGINE=InnoDB;

-- Entitas Admin (data store D4 Akun Admin)
CREATE TABLE admin (
    id_admin INT          NOT NULL AUTO_INCREMENT,
    nama     VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,   -- simpan HASH (mis. bcrypt), bukan teks asli
    PRIMARY KEY (id_admin)
) ENGINE=InnoDB;

 Entitas Laporan (data store D1 Laporan)
 Relasi "membuat"      -> id_pengguna + tanggal_lapor
 Relasi "memperbarui"  -> id_admin + tanggal_update (kosong sampai admin memperbarui)
CREATE TABLE laporan (
    id_laporan     INT          NOT NULL AUTO_INCREMENT,
    id_pengguna    INT          NOT NULL,
    id_admin       INT          NULL,
    jenis_masalah  ENUM('air keruh',
                        'air berbau',
                        'air berwarna',
                        'sampah di sungai',
                        'pencemaran sumber air',
                        'sanitasi tidak layak') NOT NULL,
    deskripsi      TEXT         NOT NULL,
    lokasi         VARCHAR(255) NOT NULL,
    foto           VARCHAR(255) NULL,          -- path/URL foto bukti
    status         ENUM('terkirim','sedang diproses','selesai')
                                NOT NULL DEFAULT 'terkirim',
    tanggal_lapor  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tanggal_update DATETIME     NULL,
    PRIMARY KEY (id_laporan),
    CONSTRAINT fk_laporan_pengguna FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_laporan_admin FOREIGN KEY (id_admin)
        REFERENCES admin(id_admin)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE INDEX idx_laporan_status ON laporan(status);
CREATE INDEX idx_laporan_jenis  ON laporan(jenis_masalah);

-- Entitas Saran (data store D3 Saran) - relasi "memberi"
CREATE TABLE saran (
    id_saran    INT  NOT NULL AUTO_INCREMENT,
    id_pengguna INT  NOT NULL,
    isi_saran   TEXT NOT NULL,
    PRIMARY KEY (id_saran),
    CONSTRAINT fk_saran_pengguna FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Entitas Artikel (data store D2 Artikel Edukasi) - relasi "mengelola"
CREATE TABLE artikel (
    id_artikel INT          NOT NULL AUTO_INCREMENT,
    id_admin   INT          NOT NULL,
    judul      VARCHAR(200) NOT NULL,
    isi        TEXT         NOT NULL,
    PRIMARY KEY (id_artikel),
    CONSTRAINT fk_artikel_admin FOREIGN KEY (id_admin)
        REFERENCES admin(id_admin)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


 2. VIEW UNTUK PRIVASI (KNF-10) DAN PETA (KF-10)
 Identitas pelapor tidak ditampilkan ke pengguna umum.

CREATE VIEW v_laporan_publik AS
SELECT id_laporan, jenis_masalah, deskripsi, lokasi, foto, status, tanggal_lapor
FROM laporan;

 3. DATA CONTOH

INSERT INTO pengguna (nama) VALUES
    ('Ani'), ('Budi'), ('Citra');

 Password di bawah hanya penanda; isi dengan hash asli di aplikasi.
INSERT INTO admin (nama, password) VALUES
    ('Admin AirKita', 'HASH_PASSWORD_CONTOH');

INSERT INTO laporan (id_pengguna, jenis_masalah, deskripsi, lokasi, foto) VALUES
    (1, 'air keruh',        'Air sumur berwarna cokelat sejak kemarin', 'Kel. Oro-oro Ombo, Madiun', 'foto/lap1.jpg'),
    (2, 'sampah di sungai', 'Tumpukan sampah menyumbat aliran sungai',  'Sungai Madiun dekat jembatan', 'foto/lap2.jpg'),
    (3, 'air berbau',       'Air PDAM berbau menyengat',                'Kec. Taman, Madiun',           NULL),
    (1, 'air keruh',        'Air keran keruh setelah hujan',            'Kel. Oro-oro Ombo, Madiun',    NULL);

INSERT INTO saran (id_pengguna, isi_saran) VALUES
    (1, 'Tambahkan fitur filter laporan berdasarkan wilayah'),
    (2, 'Mohon ada pengingat jika laporan belum diproses');

INSERT INTO artikel (id_admin, judul, isi) VALUES
    (1, 'Ciri Air Bersih yang Layak Pakai', 'Air bersih tidak berwarna, tidak berbau, dan tidak berasa ...'),
    (1, 'Cara Menjaga Kebersihan Sungai',   'Hindari membuang sampah langsung ke sungai ...');

 4. QUERY CONTOH SESUAI KEBUTUHAN FUNGSIONAL

 KF membuat laporan: laporan baru otomatis berstatus 'terkirim'
INSERT INTO laporan (id_pengguna, jenis_masalah, deskripsi, lokasi, foto)
VALUES (2, 'sanitasi tidak layak', 'Saluran pembuangan tersumbat', 'Kel. Pandean, Madiun', 'foto/lap5.jpg');

 KF-08 melihat status & riwayat laporan milik satu pengguna
SELECT id_laporan, jenis_masalah, status, tanggal_lapor
FROM laporan
WHERE id_pengguna = 1
ORDER BY tanggal_lapor DESC;

 KF-10 peta area bermasalah (tanpa identitas pelapor)
SELECT id_laporan, jenis_masalah, lokasi, status
FROM v_laporan_publik;

 KF-16 admin memperbarui status laporan
UPDATE laporan
SET status = 'sedang diproses',
    id_admin = 1,
    tanggal_update = CURRENT_TIMESTAMP
WHERE id_laporan = 1;

 Admin melihat daftar semua laporan beserta pelapor dan admin pemeriksa
SELECT l.id_laporan, p.nama AS pelapor, l.jenis_masalah, l.status,
       a.nama AS diperbarui_oleh, l.tanggal_update
FROM laporan l
JOIN pengguna p     ON l.id_pengguna = p.id_pengguna
LEFT JOIN admin a   ON l.id_admin    = a.id_admin
ORDER BY l.tanggal_lapor DESC;

 KF-18 ringkasan: jenis masalah paling sering dilaporkan
SELECT jenis_masalah, COUNT(*) AS jumlah_laporan
FROM laporan
GROUP BY jenis_masalah
ORDER BY jumlah_laporan DESC;

 KF-18 ringkasan: lokasi paling sering dilaporkan
SELECT lokasi, COUNT(*) AS jumlah_laporan
FROM laporan
GROUP BY lokasi
ORDER BY jumlah_laporan DESC;

 Ringkasan jumlah laporan per status
SELECT status, COUNT(*) AS jumlah
FROM laporan
GROUP BY status;

 Kelola artikel edukasi oleh admin
INSERT INTO artikel (id_admin, judul, isi)
VALUES (1, 'Pentingnya Sanitasi Layak', 'Sanitasi yang baik mencegah penyakit ...');

 Tampilkan edukasi (daftar artikel)
SELECT id_artikel, judul FROM artikel;

 Simpan saran dari pengguna
INSERT INTO saran (id_pengguna, isi_saran)
VALUES (3, 'Tambahkan mode gelap pada aplikasi');

5. OPSIONAL
 Jika peta memerlukan koordinat terpisah (KF-03, "Koordinat laporan"),
tambahkan kolom berikut, lalu perbarui ERD agar tetap konsisten:
ALTER TABLE laporan
ADD COLUMN latitude  DECIMAL(10,7) NULL,
ADD COLUMN longitude DECIMAL(10,7) NULL;
