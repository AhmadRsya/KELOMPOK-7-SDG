ALTER TABLE pengguna ADD COLUMN total_laporan INT NOT NULL DEFAULT 0;

UPDATE pengguna
   SET total_laporan = (SELECT COUNT(*) FROM laporan l WHERE l.id_pengguna = pengguna.id_pengguna);
