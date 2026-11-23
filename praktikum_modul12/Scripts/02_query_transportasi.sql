-- Query seleksi laporan per kelurahan (id_wilayah = 26 sejak 1 November 2026)
SELECT id_laporan, tanggal_lapor, kelurahan
FROM airkita_db.laporan_by_wilayah
WHERE id_wilayah = 26 AND tanggal_lapor >= '2026-11-01';

-- Inspeksi rencana/langkah eksekusi menggunakan TRACING
TRACING ON;
SELECT id_laporan, tanggal_lapor, kelurahan
FROM airkita_db.laporan_by_wilayah
WHERE id_wilayah = 26 AND tanggal_lapor >= '2026-11-01';
TRACING OFF;
