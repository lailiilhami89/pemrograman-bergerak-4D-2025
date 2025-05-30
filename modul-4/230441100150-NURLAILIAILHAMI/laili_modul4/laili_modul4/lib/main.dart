import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pastikan ini diimpor untuk format tanggal
import 'package:intl/date_symbol_data_local.dart'; // Untuk menginisialisasi simbol lokal
import 'screen/pengeluaranscren.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
      'id_ID', null); // Inisialisasi format tanggal 'id_ID'
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengeluaran Kuliah',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id', 'ID'),
        const Locale('en', 'US'),
      ],
      home: PengeluaranScreen(),
    );
  }
}
