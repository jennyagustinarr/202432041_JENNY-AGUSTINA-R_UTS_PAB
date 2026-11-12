import 'package:flutter/material.dart';
import '../data/app_store.dart';
import '../models/lost_item.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();
  final _contact = TextEditingController();
  final _imageUrl = TextEditingController();
  ReportType _type = ReportType.lost;
  String _category = 'Elektronik';
  String _placeType = 'Stasiun';
  DateTime _date = DateTime.now();
  bool _isSubmitting = false;

  final _categories = ['Elektronik', 'Dompet', 'Dokumen', 'Aksesori', 'Kunci', 'Tas', 'Lainnya'];
  final _places = ['Stasiun', 'Halte', 'Terminal', 'Kampus', 'Pusat perbelanjaan', 'Tempat wisata', 'Lainnya'];

  @override
  void dispose() {
    _name.dispose(); _location.dispose(); _description.dispose(); _contact.dispose(); _imageUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat laporan', style: TextStyle(fontWeight: FontWeight.w800))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFEAF5EF), borderRadius: BorderRadius.circular(18)),
              child: const Row(children: [
                Icon(Icons.info_outline_rounded, color: Color(0xFF287A59)),
                SizedBox(width: 10),
                Expanded(child: Text('Isi informasi dengan jelas agar pemilik atau penemu barang lebih mudah terhubung.', style: TextStyle(color: Color(0xFF426354), fontSize: 12, height: 1.45))),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('Jenis laporan', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF18382D))),
            const SizedBox(height: 9),
            SegmentedButton<ReportType>(
              segments: const [
                ButtonSegment(value: ReportType.lost, label: Text('Saya kehilangan'), icon: Icon(Icons.search_rounded)),
                ButtonSegment(value: ReportType.found, label: Text('Saya menemukan'), icon: Icon(Icons.check_circle_outline)),
              ],
              selected: {_type},
              onSelectionChanged: (value) => setState(() => _type = value.first),
              style: ButtonStyle(visualDensity: VisualDensity.compact, textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 11, fontWeight: FontWeight.w700))),
            ),
            const SizedBox(height: 20),
            _label('Nama barang'),
            TextFormField(controller: _name, textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Contoh: Dompet kulit hitam'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Nama barang wajib diisi' : null),
            const SizedBox(height: 15),
            _label('Kategori'),
            DropdownButtonFormField<String>(
              value: _category, decoration: const InputDecoration(),
              items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            const SizedBox(height: 15),
            _label('Lokasi ${_type == ReportType.lost ? 'kehilangan' : 'penemuan'}'),
            TextFormField(controller: _location, decoration: const InputDecoration(hintText: 'Contoh: Peron 2, Stasiun Sudirman'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Lokasi wajib diisi' : null),
            const SizedBox(height: 15),
            _label('Jenis tempat'),
            DropdownButtonFormField<String>(
              value: _placeType, decoration: const InputDecoration(),
              items: _places.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _placeType = v ?? _placeType),
            ),
            const SizedBox(height: 15),
            _label('Tanggal dan waktu'),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month_outlined),
              label: Text('${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}  •  ${_date.hour.toString().padLeft(2, '0')}.${_date.minute.toString().padLeft(2, '0')}'),
              style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft, padding: const EdgeInsets.all(16), foregroundColor: const Color(0xFF426354), side: const BorderSide(color: Color(0xFFE4ECE7))),
            ),
            const SizedBox(height: 15),
            _label('Deskripsi dan ciri khusus'),
            TextFormField(controller: _description, minLines: 3, maxLines: 5,
              decoration: const InputDecoration(hintText: 'Warna, merek, ciri unik, kondisi, atau informasi lain...'),
              validator: (v) => v == null || v.trim().length < 8 ? 'Deskripsi minimal 8 karakter' : null),
            const SizedBox(height: 15),
            _label('Kontak yang bisa dihubungi'),
            TextFormField(controller: _contact, keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Nomor telepon / petugas lokasi'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Kontak wajib diisi' : null),
            const SizedBox(height: 15),
            _label('URL foto (opsional)'),
            TextFormField(controller: _imageUrl, keyboardType: TextInputType.url,
              decoration: const InputDecoration(hintText: 'https://...')),
            const SizedBox(height: 8),
            const Text('Untuk versi praktikum, foto ditampilkan melalui URL. Jika kosong, aplikasi memakai gambar placeholder.', style: TextStyle(fontSize: 11, color: Color(0xFF819188))),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Kirim laporan'),
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFF146B50), foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF345344))),
  );

  Future<void> _pickDate() async {
    final date = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime.now().add(const Duration(days: 1)));
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_date));
    if (time == null || !mounted) return;
    setState(() => _date = DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final item = LostItem(
      id: 'TK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: _name.text.trim(),
      category: _category,
      type: _type,
      location: _location.text.trim(),
      placeType: _placeType,
      date: _date,
      description: _description.text.trim(),
      contact: _contact.text.trim(),
      imageUrl: _imageUrl.text.trim().isEmpty ? 'local-placeholder' : _imageUrl.text.trim(),
      isMine: true,
    );
    AppStore.instance.addItem(item);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Laporan berhasil ditambahkan.')));
    Navigator.pop(context);
  }
}
