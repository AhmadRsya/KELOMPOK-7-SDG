"id_laporan": 1,
  "jenis_masalah": "Air Keruh",
  "deskripsi": "Air sumur warga berwarna cokelat sejak tiga hari lalu",
  "status": "Diproses",
  "tanggal_laporan": "2026-11-10",
  "pelapor": {
    "id_pengguna": 12,
    "nama": "Budi Santoso"
  },
  "lokasi": {
    "wilayah": "Kediri",
    "kecamatan": "Mojoroto",
    "koordinat": {
      "latitude": -7.8167,
      "longitude": 112.0167
    }
  },
  "hasil_pengukuran": {
    "ph": 6.2,
    "kekeruhan_ntu": 18,
    "berbau": false
  },
  "foto_bukti": [
    "uploads/laporan1_a.jpg",
    "uploads/laporan1_b.jpg"
  ],
  "jumlah_dukungan": 7
}
*/

-- ------------------------------------------------------------
-- Penerapan JSON pada sistem AirKita
-- Objek yang sama dijalankan sebagai SQL (berlaku di MySQL).
-- Tidak perlu memilih database karena hanya memakai variabel.
-- ------------------------------------------------------------
SET @laporan = '{
  "id_laporan": 1,
  "jenis_masalah": "Air Keruh",
  "deskripsi": "Air sumur warga berwarna cokelat sejak tiga hari lalu",
  "status": "Diproses",
  "tanggal_laporan": "2026-11-10",
  "pelapor": {"id_pengguna": 12, "nama": "Budi Santoso"},
  "lokasi": {
    "wilayah": "Kediri",
    "kecamatan": "Mojoroto",
    "koordinat": {"latitude": -7.8167, "longitude": 112.0167}
  },
  "hasil_pengukuran": {"ph": 6.2, "kekeruhan_ntu": 18, "berbau": false},
  "foto_bukti": ["uploads/laporan1_a.jpg", "uploads/laporan1_b.jpg"],
  "jumlah_dukungan": 7
}';

-- 1. Memeriksa apakah JSON valid (hasil 1 = valid)
SELECT JSON_VALID(@laporan) AS json_valid;

-- 2. Membaca atribut biasa dan atribut bersarang
SELECT JSON_UNQUOTE(JSON_EXTRACT(@laporan, '$.jenis_masalah'))       AS jenis_masalah,
       JSON_UNQUOTE(JSON_EXTRACT(@laporan, '$.status'))              AS status,
       JSON_UNQUOTE(JSON_EXTRACT(@laporan, '$.lokasi.wilayah'))      AS wilayah,
       JSON_EXTRACT(@laporan, '$.hasil_pengukuran.ph')               AS ph,
       JSON_EXTRACT(@laporan, '$.hasil_pengukuran.kekeruhan_ntu')    AS kekeruhan_ntu;

-- 3. Membaca elemen array (foto pertama) dan menghitung jumlah foto
SELECT JSON_UNQUOTE(JSON_EXTRACT(@laporan, '$.foto_bukti[0]')) AS foto_pertama,
       JSON_LENGTH(JSON_EXTRACT(@laporan, '$.foto_bukti'))     AS jumlah_foto;

-- 4. Mengubah status laporan (objek berubah, atribut lain tetap)
SELECT JSON_SET(@laporan, '$.status', 'Selesai') AS laporan_diperbarui;

-- 5. Menambah atribut baru tanpa mengubah struktur tabel
SELECT JSON_SET(@laporan, '$.petugas', 'Tim Lapangan A') AS laporan_dengan_petugas;
