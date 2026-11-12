import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../models/lost_item.dart';
import 'detail_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
        animation: AppStore.instance,
        builder: (context, _) {
          final items = AppStore.instance.items;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            children: [
              const Text('Aktivitas', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
              const SizedBox(height: 5),
              const Text('Riwayat laporan barang di TemuKembali.', style: TextStyle(color: Color(0xFF819188))),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFEAF5EF), borderRadius: BorderRadius.circular(18)),
                child: Row(children: [
                  const Icon(Icons.bolt_rounded, color: Color(0xFF287A59), size: 25),
                  const SizedBox(width: 10),
                  Expanded(child: Text('${items.length} laporan tersedia dalam sesi aplikasi ini.', style: const TextStyle(color: Color(0xFF426354), fontWeight: FontWeight.w700))),
                ]),
              ),
              const SizedBox(height: 18),
              if (items.isEmpty)
                const Center(child: Padding(padding: EdgeInsets.all(30), child: Text('Belum ada aktivitas.')))
              else
                ListView.separated(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const Divider(height: 20, color: Color(0xFFE8EFEB)),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final found = item.type == ReportType.found;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: found ? const Color(0xFFE5F5EC) : const Color(0xFFFFF1E7),
                        child: Icon(found ? Icons.inventory_2_outlined : Icons.search_rounded,
                          color: found ? const Color(0xFF18734F) : const Color(0xFFB7652C)),
                      ),
                      title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF345344))),
                      subtitle: Text('${item.typeLabel} • ${item.location}', maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF819188))),
                      trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF91A097)),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(item: item))),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
