import 'package:flutter/material.dart';
import '../models/lost_item.dart';
import '../widgets/status_badge.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.item});
  final LostItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail laporan', style: TextStyle(fontWeight: FontWeight.w800))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(aspectRatio: 1.55, child: item.imageUrl.startsWith('http')
              ? Image.network(item.imageUrl, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset('assets/images/item_placeholder.png', fit: BoxFit.cover))
              : Image.asset('assets/images/item_placeholder.png', fit: BoxFit.cover)),
          ),
          const SizedBox(height: 18),
          Row(children: [StatusBadge(type: item.type), const Spacer(), Text(item.id, style: const TextStyle(color: Color(0xFF91A097), fontSize: 11, fontWeight: FontWeight.w700))]),
          const SizedBox(height: 10),
          Text(item.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
          const SizedBox(height: 5),
          Text(item.category, style: const TextStyle(color: Color(0xFF819188))),
          const SizedBox(height: 20),
          _infoTile(Icons.location_on_outlined, 'Lokasi', item.location),
          _infoTile(Icons.place_outlined, 'Jenis tempat', item.placeType),
          _infoTile(Icons.schedule_rounded, 'Waktu laporan', _formatDate(item.date)),
          const SizedBox(height: 16),
          const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF18382D))),
          const SizedBox(height: 8),
          Text(item.description, style: const TextStyle(color: Color(0xFF61756A), height: 1.6)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFEAF5EF), borderRadius: BorderRadius.circular(18)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Informasi kontak', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
              const SizedBox(height: 6),
              Row(children: [const Icon(Icons.person_outline, size: 18, color: Color(0xFF347A5B)), const SizedBox(width: 8),
                Expanded(child: Text(item.contact, style: const TextStyle(color: Color(0xFF426354))))]),
            ]),
          ),
          const SizedBox(height: 14),
          const Text('Tips keamanan: pastikan ciri barang sesuai dan lakukan serah-terima di tempat umum atau melalui petugas resmi.', style: TextStyle(fontSize: 11, color: Color(0xFF819188), height: 1.5)),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 19, color: const Color(0xFF398064)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF91A097))),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF345344))),
      ])),
    ]),
  );

  String _formatDate(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} • ${date.hour.toString().padLeft(2, '0')}.${date.minute.toString().padLeft(2, '0')}';
}
