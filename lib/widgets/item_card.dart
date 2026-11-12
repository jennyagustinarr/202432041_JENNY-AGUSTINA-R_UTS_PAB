import 'package:flutter/material.dart';
import '../models/lost_item.dart';
import 'status_badge.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.onTap});
  final LostItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEAF0EC)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 94, height: 94,
                  child: item.imageUrl.startsWith('http')
                      ? Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset('assets/images/item_placeholder.png', fit: BoxFit.cover),
                        )
                      : Image.asset('assets/images/item_placeholder.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusBadge(type: item.type),
                    const SizedBox(height: 7),
                    Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF18382D))),
                    const SizedBox(height: 5),
                    Row(children: [
                      const Icon(Icons.place_outlined, size: 14, color: Color(0xFF7D9187)),
                      const SizedBox(width: 3),
                      Expanded(child: Text(item.location, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF71847A)))),
                    ]),
                    const SizedBox(height: 5),
                    Text(_timeAgo(item.date), style: const TextStyle(fontSize: 11, color: Color(0xFF9AA79F))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF9AA79F)),
            ],
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }
}
