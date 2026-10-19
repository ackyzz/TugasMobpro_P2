import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorit_screen.dart';
import 'profil_screen.dart';
import 'keranjang_screen.dart';

// Halaman wrapper dengan BottomNavigationBar
class HalamanWrapper extends StatefulWidget {
  const HalamanWrapper({super.key});

  @override
  State<HalamanWrapper> createState() => _HalamanWrapperState();
}

class _HalamanWrapperState extends State<HalamanWrapper> {
  int _halamanAktif = 0;

  // Daftar halaman yang bisa diakses lewat bottom nav
  final List<Widget> _halaman = const [
    HalamanUtama(),
    HalamanKeranjang(),
    HalamanFavorit(),
    HalamanProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _halamanAktif,
        children: _halaman,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _halamanAktif,
        onTap: (i) => setState(() => _halamanAktif = i),
        selectedItemColor: const Color(0xFFE65100),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
