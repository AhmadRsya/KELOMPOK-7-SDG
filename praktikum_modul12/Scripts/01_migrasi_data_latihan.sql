CREATE KEYSPACE IF NOT EXISTS airkita_db
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
 
CREATE TABLE airkita_db.laporan_by_wilayah (
    id_wilayah    int,
    tanggal_lapor timestamp,
    id_laporan    int,
    kelurahan     text,
    status        text,
    PRIMARY KEY (id_wilayah, tanggal_lapor, id_laporan)
);
 
INSERT INTO airkita_db.laporan_by_wilayah (id_wilayah, tanggal_lapor, id_laporan, kelurahan, status)
VALUES (26, '2026-11-02 08:10:00', 101, 'Pandean', 'terkirim');
-- laporan 102 sampai 106 ditulis dengan pola yang sama (lengkapnya ada di berkas 01_migrasi_data_latihan.cql)
