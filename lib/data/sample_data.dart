import '../models/lost_item.dart';

final List<LostItem> sampleItems = [
  LostItem(
    id: 'TK-1024', name: 'Dompet kulit cokelat', category: 'Dompet',
    type: ReportType.found, location: 'Stasiun Sudirman, dekat pintu keluar', placeType: 'Stasiun',
    date: DateTime.now().subtract(const Duration(hours: 2)),
    description: 'Ditemukan di bangku ruang tunggu. Ada beberapa kartu di dalamnya. Diserahkan sementara kepada petugas informasi.',
    contact: 'Petugas Informasi', imageUrl: 'https://images.unsplash.com/photo-1627123424574-724758594e93?w=900',
  ),
  LostItem(
    id: 'TK-1023', name: 'Tumbler hijau', category: 'Aksesori',
    type: ReportType.lost, location: 'Halte TransJakarta Bundaran HI', placeType: 'Halte',
    date: DateTime.now().subtract(const Duration(hours: 5)),
    description: 'Tumbler warna hijau sage, terdapat stiker kecil berbentuk matahari. Terakhir terlihat di area tempat duduk halte.',
    contact: '0812-3456-7890', imageUrl: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=900',
  ),
  LostItem(
    id: 'TK-1022', name: 'Headphone wireless', category: 'Elektronik',
    type: ReportType.found, location: 'Peron 2, Stasiun Tanah Abang', placeType: 'Stasiun',
    date: DateTime.now().subtract(const Duration(days: 1)),
    description: 'Headphone warna hitam ditemukan setelah kereta tiba. Pemilik dapat menjelaskan ciri khususnya.',
    contact: '0813-2222-1010', imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=900',
  ),
  LostItem(
    id: 'TK-1021', name: 'Kartu identitas', category: 'Dokumen',
    type: ReportType.lost, location: 'Terminal Blok M, area keberangkatan', placeType: 'Terminal',
    date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    description: 'Kartu identitas atas nama pemilik. Mohon hubungi pelapor jika menemukan.',
    contact: '0812-8888-2121', imageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=900',
  ),
  LostItem(
    id: 'TK-1020', name: 'Payung lipat navy', category: 'Aksesori',
    type: ReportType.found, location: 'Mall Kota Kasablanka, food court', placeType: 'Pusat perbelanjaan',
    date: DateTime.now().subtract(const Duration(days: 2)),
    description: 'Payung lipat warna biru tua tertinggal di kursi dekat jendela.',
    contact: '0812-1111-9090', imageUrl: 'https://images.unsplash.com/photo-1534274988757-a28bf1a57c17?w=900',
  ),
];
