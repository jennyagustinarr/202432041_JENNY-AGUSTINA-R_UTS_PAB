import 'package:flutter/foundation.dart';
import '../models/lost_item.dart';
import 'sample_data.dart';

class AppStore extends ChangeNotifier {
  AppStore._() : _items = List<LostItem>.from(sampleItems);
  static final AppStore instance = AppStore._();

  final List<LostItem> _items;
  List<LostItem> get items => List.unmodifiable(_items);

  void addItem(LostItem item) {
    _items.insert(0, item);
    notifyListeners();
  }

  int get lostCount => _items.where((item) => item.type == ReportType.lost && !item.isResolved).length;
  int get foundCount => _items.where((item) => item.type == ReportType.found && !item.isResolved).length;
}
