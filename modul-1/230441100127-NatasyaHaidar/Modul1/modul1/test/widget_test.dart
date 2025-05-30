import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modul1/main.dart';

void main() {
  testWidgets('HomePage shows key UI elements', (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(MyApp());

    // Verifikasi bahwa teks "Hi, User 👋" muncul
    expect(find.text('Hi, User 👋'), findsOneWidget);

    // Verifikasi bahwa bagian "Hot Places" muncul
    expect(find.text('Hot Places'), findsOneWidget);

    // Verifikasi bahwa bagian "Best Hotels" muncul
    expect(find.text('Best Hotels'), findsOneWidget);

    // Verifikasi ada minimal satu gambar hot place
    expect(find.byType(Image), findsWidgets);
  });
}
