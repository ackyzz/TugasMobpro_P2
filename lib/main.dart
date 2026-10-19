import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_data.dart';
import 'screens/wrapper_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/sukses_screen.dart';

void main() {
  runApp(
    // Pakai ChangeNotifierProvider supaya semua halaman bisa akses AppData
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const AplikasiKantin(),
    ),
  );
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantin Bu Sari',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE65100)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HalamanWrapper(),
        '/checkout': (_) => const HalamanCheckout(),
        '/sukses': (_) => const HalamanSukses(),
      },
    );
  }
}
