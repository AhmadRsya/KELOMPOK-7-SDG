SELECT p.id_pengguna, p.nama, COUNT(l.id_laporan) AS kalkulasi_total_laporan
   FROM pengguna p
   LEFT JOIN laporan l ON p.id_pengguna = l.id_pengguna
   GROUP BY p.id_pengguna, p.nama;
