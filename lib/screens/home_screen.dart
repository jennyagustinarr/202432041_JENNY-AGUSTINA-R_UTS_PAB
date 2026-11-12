import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../models/lost_item.dart';
import '../widgets/item_card.dart';
import 'detail_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _category = 'Semua kategori';
  final List<String> _categories = ['Semua kategori', 'Elektronik', 'Dompet', 'Dokumen', 'Aksesori', 'Kunci', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    AppStore.instance.addListener(_refresh);
  }

  void _refresh() { if (mounted) setState(() {}); }

  @override
  void dispose() {
    AppStore.instance.removeListener(_refresh);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Row(
              children: [
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(color: const Color(0xFFE4F2E9), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.travel_explore_rounded, color: Color(0xFF146B50), size: 24),
                ),
                const SizedBox(width: 10),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('TemuKembali', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
                  Text('Temukan. Hubungkan. Kembali.', style: TextStyle(fontSize: 11, color: Color(0xFF819188))),
                ])),
                IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportScreen())),
                  icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF146B50), size: 28)),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: store,
              builder: (context, _) => ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
                children: [
                  _heroBanner(),
                  const SizedBox(height: 18),
                  Row(children: [
                    Expanded(child: _statCard('Barang hilang', store.lostCount.toString(), Icons.search_rounded, const Color(0xFFFFF2E8), const Color(0xFFB7652C))),
                    const SizedBox(width: 10),
                    Expanded(child: _statCard('Barang ditemukan', store.foundCount.toString(), Icons.check_circle_outline_rounded, const Color(0xFFE7F5EC), const Color(0xFF18734F))),
                  ]),
                  const SizedBox(height: 22),
                  const Text('Cari barang', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: 'Nama barang, lokasi, atau kata kunci...',
                      prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF6D8A7B)),
                      suffixIcon: _query.isEmpty ? null : IconButton(icon: const Icon(Icons.close), onPressed: () {
                        _searchController.clear(); setState(() => _query = '');
                      }),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Jelajahi laporan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _categories.map((category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _category == category,
                        onSelected: (_) => setState(() => _category = category),
                        selectedColor: const Color(0xFFDDF0E4),
                        labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                          color: _category == category ? const Color(0xFF146B50) : const Color(0xFF71847A)),
                        side: BorderSide(color: _category == category ? const Color(0xFFB8DCC5) : const Color(0xFFE5ECE7)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    )).toList()),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFEAF0EC))),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: const Color(0xFF146B50),
                      unselectedLabelColor: const Color(0xFF91A097),
                      indicatorColor: const Color(0xFF146B50),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                      tabs: const [Tab(text: 'Semua'), Tab(text: 'Hilang'), Tab(text: 'Ditemukan')],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildCurrentList(store.items),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentList(List<LostItem> items) {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, _) {
        final type = _tabController.index == 1 ? ReportType.lost : _tabController.index == 2 ? ReportType.found : null;
        final filtered = _filteredItems(items, type, _query);
        if (filtered.isEmpty) return const Center(child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.inbox_outlined, size: 36, color: Color(0xFF9BB0A3)),
            SizedBox(height: 8), Text('Belum ada laporan yang cocok.', style: TextStyle(color: Color(0xFF819188))),
          ]),
        ));
        return ListView.builder(
          itemCount: filtered.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ItemCard(item: filtered[index], onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => DetailScreen(item: filtered[index])))),
          ),
        );
      },
    );
  }

  List<LostItem> _filteredItems(List<LostItem> items, ReportType? type, String? query) {
    return items.where((item) {
      final typeMatch = type == null || item.type == type;
      final categoryMatch = _category == 'Semua kategori' || item.category == _category;
      final q = query ?? '';
      final searchMatch = q.isEmpty || '${item.name} ${item.location} ${item.description} ${item.category}'.toLowerCase().contains(q);
      return typeMatch && categoryMatch && searchMatch;
    }).toList();
  }

  Widget _heroBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF176D51), Color(0xFF2E9870)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(children: [
        Positioned(right: -8, top: -12, child: Icon(Icons.travel_explore_rounded, size: 112, color: Colors.white.withOpacity(.10))),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(30)),
            child: const Text('RUANG PUBLIK, LEBIH TERHUBUNG', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: .7))),
          const SizedBox(height: 12),
          const Text('Barangmu bisa\npulang kembali.', style: TextStyle(color: Colors.white, fontSize: 23, height: 1.15, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('Laporkan kehilangan atau bantu orang lain\nmenemukan barangnya.', style: TextStyle(color: Color(0xFFE1F3E9), fontSize: 12, height: 1.5)),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportScreen())),
            icon: const Icon(Icons.add_rounded, size: 17),
            label: const Text('Buat laporan sekarang'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white70),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          ),
        ]),
      ]),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFEAF0EC))),
      child: Row(children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: fg, size: 20)),
        const SizedBox(width: 9),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Color(0xFF819188))),
        ])),
      ]),
    );
  }
}
