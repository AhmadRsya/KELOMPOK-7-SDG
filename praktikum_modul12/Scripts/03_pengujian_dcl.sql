-- 1. Membuat role dan memberi hak baca (dijalankan sebagai administrator)
CREATE ROLE app_baca WITH PASSWORD = 'GANTI_PASSWORD_KUAT' AND LOGIN = true;
GRANT SELECT ON TABLE airkita_db.laporan_by_wilayah TO app_baca;
LIST ALL PERMISSIONS OF app_baca;

-- 2. Pengujian sebagai app_baca (login: cqlsh -u app_baca -p GANTI_PASSWORD_KUAT)
-- Operasi yang diizinkan (SELECT):
SELECT id_laporan, tanggal_lapor, kelurahan
FROM airkita_db.laporan_by_wilayah
WHERE id_wilayah = 26 AND tanggal_lapor >= '2026-11-01';

-- Operasi tanpa izin (DELETE -> diharapkan ditolak / Unauthorized):
DELETE FROM airkita_db.laporan_by_wilayah
WHERE id_wilayah = 26 AND tanggal_lapor = '2026-11-02 08:10:00' AND id_laporan = 101;

-- 3. Mencabut hak akses (dijalankan sebagai administrator)
REVOKE SELECT ON TABLE airkita_db.laporan_by_wilayah FROM app_baca;
LIST ALL PERMISSIONS OF app_baca;

-- 4. Pengujian ulang sebagai app_baca setelah REVOKE (tunggu 2-3 detik, diharapkan ditolak / Unauthorized)
SELECT id_laporan FROM airkita_db.laporan_by_wilayah WHERE id_wilayah = 26;
