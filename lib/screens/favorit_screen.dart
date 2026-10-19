import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';
import '../screens/detail_screen.dart';

// Halaman daftar menu favorit
class HalamanFavorit extends StatelessWidget {
  const HalamanFavorit({super.key});

  String formatHarga(double harga) {
    return 'Rp ${harga.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final favorit = appData.favorit;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: const Text('Favorit Saya',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: favorit.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada menu favorit',
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tekan ikon hati di kartu menu untuk menambahkan',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey[400]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorit.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final item = favorit[i];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HalamanDetail(item: item)),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Image.asset(
                          item.gambar,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFFBE9E7),
                            child: const Icon(Icons.restaurant,
                                color: Color(0xFFE65100)),
                          ),
                        ),
                      ),
                    ),
                    title: Text(item.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(formatHarga(item.harga),
                        style:
                            const TextStyle(color: Color(0xFFE65100))),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => appData.toggleFavorit(item.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
