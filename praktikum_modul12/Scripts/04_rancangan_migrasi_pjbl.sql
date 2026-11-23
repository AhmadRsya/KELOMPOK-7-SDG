-- Rancangan tabel riwayat laporan pengguna (KF-09) pada keyspace airkita_db
CREATE TABLE IF NOT EXISTS airkita_db.laporan_by_pengguna (
    id_pengguna   int,
    tanggal_lapor timestamp,
    id_laporan    int,
    nama_jenis    text,
    status        text,
    PRIMARY KEY (id_pengguna, tanggal_lapor, id_laporan)
) WITH CLUSTERING ORDER BY (tanggal_lapor DESC, id_laporan ASC);

-- Query riwayat laporan satu pengguna sejak tanggal tertentu
SELECT id_laporan, tanggal_lapor, nama_jenis, status
FROM airkita_db.laporan_by_pengguna
WHERE id_pengguna = 100 AND tanggal_lapor >= '2026-01-01';

-- Role dan hak akses (DCL) pada tabel laporan_by_pengguna
CREATE ROLE app_pengguna WITH PASSWORD = 'GANTI_PASSWORD_KUAT' AND LOGIN = true;
CREATE ROLE app_admin WITH PASSWORD = 'GANTI_PASSWORD_KUAT' AND LOGIN = true;

GRANT SELECT ON TABLE airkita_db.laporan_by_pengguna TO app_pengguna;
GRANT SELECT, MODIFY ON TABLE airkita_db.laporan_by_pengguna TO app_admin;
