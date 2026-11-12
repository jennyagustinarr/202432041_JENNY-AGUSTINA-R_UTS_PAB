
import 'package:flutter_test/flutter_test.dart';
import 'package:temukembali/app.dart';

void main() {
  testWidgets('TemuKembali app renders successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TemuKembaliApp());

    expect(find.text('TemuKembali'), findsWidgets);
    expect(find.text('Cari barang'), findsOneWidget);
  });
}
