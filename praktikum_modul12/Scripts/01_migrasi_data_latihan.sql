CREATE KEYSPACE IF NOT EXISTS airkita_db
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE airkita_db;

CREATE TABLE IF NOT EXISTS laporan_by_wilayah (
    id_wilayah    int,
    tanggal_lapor timestamp,
    id_laporan    int,
    kelurahan     text,
    status        text,
    PRIMARY KEY (id_wilayah, tanggal_lapor, id_laporan)
);

-- Data latihan laporan (101 - 106) pada tabel laporan_by_wilayah
INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (26, '2026-11-02 08:10:00', 101, 'Pandean', 'terkirim');

INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (20, '2026-11-02 09:20:00', 102, 'Demangan', 'selesai');

INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (26, '2026-11-03 10:05:00', 103, 'Pandean', 'sedang diproses');

INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (1, '2026-10-29 07:45:00', 104, 'Kanigoro', 'selesai');

INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (26, '2026-11-05 15:30:00', 105, 'Pandean', 'terkirim');

INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (20, '2026-11-06 11:00:00', 106, 'Demangan', 'ditolak');
