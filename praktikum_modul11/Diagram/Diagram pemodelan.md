# Diagram Pemodelan Objek – Katalog Produk

Gambar: [`diagram_pemodelan.png`](diagram_pemodelan.png)

```mermaid
classDiagram
    class Produk {
        +int id_produk
        +string nama_produk
        +decimal harga
        +tampilkanInformasi()
        +hitungDiskon()
        +ubahHarga()
    }
    class Laptop {
        +string ram
        +string storage
        +string prosesor
        +string ukuran_layar
    }
    class Smartphone {
        +string ram
        +string storage
        +string kamera
        +string baterai
    }
    class LayananDigital {
        +string durasi
        +int jumlah_pengguna
        +array fitur
    }
    Produk <|-- Laptop
    Produk <|-- Smartphone
    Produk <|-- LayananDigital
```

## Pemetaan ke tabel relasional

| Konsep objek | Representasi di MySQL |
| ------------ | --------------------- |
| Kelas `Produk` | Tabel `produk_objek` |
| Atribut umum (`id_produk`, `nama_produk`, `harga`) | Kolom biasa |
| Kelas turunan (Laptop, Smartphone, LayananDigital) | Kolom `jenis_produk` |
| Atribut khusus tiap kelas | Kolom JSON `spesifikasi` |
| Method | Tidak disimpan di tabel (ada di aplikasi / stored program) |
