import 'package:flutter/material.dart';
import '../models/app_data.dart';
import '../models/menu_item.dart';

// Widget kartu untuk setiap menu
class KartuMenu extends StatelessWidget {
  final MenuItem item;
  final AppData appData;
  final VoidCallback onTap;

  const KartuMenu({
    super.key,
    required this.item,
    required this.appData,
    required this.onTap,
  });

  String formatHarga(double harga) {
    return 'Rp ${harga.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian gambar dan badge
            Stack(
              children: [
                SizedBox(
                  height: 110,
                  width: double.infinity,
                  child: Image.asset(
                    item.gambar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFFBE9E7),
                      child: const Center(
                        child: Icon(Icons.restaurant,
                            color: Color(0xFFE65100), size: 40),
                      ),
                    ),
                  ),
                ),
                // Badge kategori
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE65100).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.kategori,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Tombol favorit
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => appData.toggleFavorit(item.id),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white.withValues(alpha: 0.85),
                      child: Icon(
                        item.isFavorit
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Nama, deskripsi, harga
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.deskripsi,
                    style:
                        TextStyle(color: Colors.grey[600], fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatHarga(item.harga),
                        style: const TextStyle(
                          color: Color(0xFFE65100),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      // Tombol tambah ke keranjang
                      GestureDetector(
                        onTap: () {
                          appData.tambahKeKeranjang(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${item.nama} ditambahkan ke keranjang'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: const Color(0xFFE65100),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE65100),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
