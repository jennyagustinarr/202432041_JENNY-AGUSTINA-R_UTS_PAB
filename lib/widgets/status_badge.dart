import 'package:flutter/material.dart';
import '../models/lost_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.type});
  final ReportType type;

  @override
  Widget build(BuildContext context) {
    final isFound = type == ReportType.found;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isFound ? const Color(0xFFE5F5EC) : const Color(0xFFFFF1E7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        isFound ? 'Ditemukan' : 'Hilang',
        style: TextStyle(
          color: isFound ? const Color(0xFF18734F) : const Color(0xFFB7652C),
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
