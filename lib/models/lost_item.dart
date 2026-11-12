enum ReportType { lost, found }

class LostItem {
  const LostItem({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.location,
    required this.placeType,
    required this.date,
    required this.description,
    required this.contact,
    required this.imageUrl,
    this.isResolved = false,
    this.isMine = false,
  });

  final String id;
  final String name;
  final String category;
  final ReportType type;
  final String location;
  final String placeType;
  final DateTime date;
  final String description;
  final String contact;
  final String imageUrl;
  final bool isResolved;
  final bool isMine;

  String get typeLabel => type == ReportType.lost ? 'Barang hilang' : 'Barang ditemukan';
}
