# TemuKembali – Lost & Found

Aplikasi Flutter untuk membantu masyarakat melaporkan, mencari, dan menelusuri barang hilang maupun barang temuan di tempat umum.

## Fitur
- Beranda dengan ringkasan laporan dan daftar barang.
- Tab **Semua / Hilang / Ditemukan**.
- Pencarian berdasarkan nama barang, lokasi, dan deskripsi.
- Filter kategori.
- Detail laporan: foto, lokasi, waktu, deskripsi, dan kontak pelapor.
- Formulir untuk membuat laporan kehilangan atau penemuan.
- Validasi input dan konfirmasi sebelum laporan disimpan.
- Aktivitas laporan yang baru ditambahkan.
- Profil dan panduan keamanan serah-terima barang.
- Data contoh (dummy) dan data baru disimpan di memori selama aplikasi berjalan.

## Teknologi
- Flutter + Dart
- Material 3
- Tidak memerlukan Firebase, database, API, atau package eksternal.

## Menjalankan di VS Code
1. Pastikan Flutter SDK dan Android Studio/Android SDK sudah terpasang.
2. Ekstrak ZIP, lalu buka folder `temukembali_flutter` di VS Code.
3. Buka terminal pada folder proyek.
4. Jalankan:
   ```bash
   flutter pub get
   flutter devices
   flutter run
   ```
5. Pilih emulator Android atau perangkat Android yang terhubung.

> Jika folder platform Android belum tersedia pada lingkungan lokal, jalankan `flutter create --platforms=android .` dari root proyek, kemudian `flutter run`.

## Struktur folder
```text
lib/
  main.dart
  app.dart
  models/
    lost_item.dart
  data/
    sample_data.dart
    app_store.dart
  screens/
    home_screen.dart
    report_screen.dart
    detail_screen.dart
    activity_screen.dart
    profile_screen.dart
  widgets/
    item_card.dart
    status_badge.dart
assets/
  images/
    item_placeholder.png
```

## Catatan ruang lingkup UTS
Sesuai ketentuan UTS Praktikum Pemrograman Aplikasi Bergerak, data awal menggunakan dummy data. Laporan baru disimpan dalam List selama aplikasi berjalan dan tidak dijamin tetap ada setelah aplikasi ditutup. Fitur autentikasi, peta interaktif, upload foto kamera, notifikasi, dan sinkronisasi server dapat menjadi pengembangan lanjutan.

## Splash screen
Aplikasi menampilkan splash screen beranimasi selama sekitar 2,4 detik sebelum membuka halaman utama. Splash screen dibuat menggunakan widget Flutter bawaan tanpa package tambahan.
