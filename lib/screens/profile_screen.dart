import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const Text('Profil & informasi', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
          const SizedBox(height: 5),
          const Text('Kenali cara kerja dan gunakan layanan dengan aman.', style: TextStyle(color: Color(0xFF819188))),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF176D51), Color(0xFF2E9870)]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Row(children: [
              CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Icon(Icons.person_rounded, color: Colors.white, size: 30)),
              SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Pengguna TemuKembali', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                SizedBox(height: 4),
                Text('Bersama bantu barang kembali.', style: TextStyle(color: Color(0xFFDDF2E5), fontSize: 11)),
              ])),
            ]),
          ),
          const SizedBox(height: 22),
          const Text('Panduan penggunaan', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF18382D))),
          const SizedBox(height: 12),
          _guide(Icons.search_rounded, 'Cari laporan', 'Gunakan kolom pencarian, kategori, dan tab Hilang atau Ditemukan untuk menemukan laporan yang sesuai.'),
          _guide(Icons.edit_note_rounded, 'Buat laporan', 'Pilih jenis laporan, isi nama barang, lokasi, waktu, deskripsi, dan kontak yang dapat dihubungi.'),
          _guide(Icons.fact_check_outlined, 'Periksa detail', 'Baca ciri khusus barang sebelum menghubungi pelapor atau mengklaim barang.'),
          const SizedBox(height: 10),
          const Text('Tips keamanan', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Color(0xFF18382D))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFFFF7E9), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFF4E8CF))),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _SafetyLine('Jangan cantumkan nomor identitas, PIN, atau data sensitif pada deskripsi.'),
              _SafetyLine('Jangan mengirim uang sebagai syarat pengambilan barang.'),
              _SafetyLine('Lakukan serah-terima di tempat ramai atau melalui petugas resmi.'),
              _SafetyLine('Minta pemilik menyebutkan ciri khusus yang tidak dipublikasikan.'),
            ]),
          ),
          const SizedBox(height: 22),
          const Center(child: Text('TemuKembali • Versi 1.0.0', style: TextStyle(color: Color(0xFF9AA79F), fontSize: 11))),
        ],
      ),
    );
  }

  Widget _guide(IconData icon, String title, String description) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFEAF0EC))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFEAF5EF), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: const Color(0xFF287A59))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF345344))),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 11, color: Color(0xFF819188), height: 1.45)),
      ])),
    ]),
  );
}

class _SafetyLine extends StatelessWidget {
  const _SafetyLine(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Icon(Icons.shield_outlined, size: 17, color: Color(0xFF9A7835)),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 11, height: 1.4, color: Color(0xFF76623B)))),
    ]),
  );
}
