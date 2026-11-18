import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:latihan_flutter/pages/jadwal_page.dart';

void main() {
  testWidgets('halaman jadwal tampil dengan benar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: JadwalPage()));
    await tester.pump();

    expect(find.text('Jadwal'), findsWidgets);
    expect(find.text('Sarapan'), findsOneWidget);
    expect(find.text('Makan Siang'), findsOneWidget);
    expect(find.text('Makan Malam'), findsOneWidget);
    expect(find.text('Nasi Goreng Kampung'), findsOneWidget);
  });
}
