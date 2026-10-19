import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';
import '../models/menu_item.dart';

// Halaman detail menu
class HalamanDetail extends StatefulWidget {
  final MenuItem item;

  const HalamanDetail({super.key, required this.item});

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  int _jumlah = 1;

  String formatHarga(double harga) {
    return 'Rp ${harga.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final item = widget.item;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      body: CustomScrollView(
        slivers: [
          // AppBar dengan gambar
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: const Color(0xFFE65100),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                item.gambar,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFFBE9E7),
                  child: const Center(
                    child: Icon(Icons.restaurant,
                        color: Color(0xFFE65100), size: 60),
                  ),
                ),
              ),
            ),
            actions: [
              // Tombol favorit di detail
              IconButton(
                icon: Icon(
                  item.isFavorit ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () => appData.toggleFavorit(item.id),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama dan kategori
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.nama,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Chip(
                        label: Text(
                          item.kategori,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFE65100),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    formatHarga(item.harga),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi
                  const Text(
                    'Deskripsi',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.deskripsi,
                    style: TextStyle(
                        color: Colors.grey[700], fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Divider pemisah
                  const Divider(),
                  const SizedBox(height: 16),

                  // Pilih jumlah
                  const Text(
                    'Jumlah',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Tombol kurang
                      IconButton(
                        onPressed: () {
                          if (_jumlah > 1) setState(() => _jumlah--);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: const Color(0xFFE65100),
                        iconSize: 30,
                      ),
                      // Teks jumlah
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$_jumlah',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Tombol tambah
                      IconButton(
                        onPressed: () => setState(() => _jumlah++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: const Color(0xFFE65100),
                        iconSize: 30,
                      ),
                      const Spacer(),
                      // Total harga sesuai jumlah
                      Text(
                        formatHarga(item.harga * _jumlah),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol tambah ke keranjang
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE65100),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        for (int i = 0; i < _jumlah; i++) {
                          appData.tambahKeKeranjang(item);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${item.nama} x$_jumlah ditambahkan ke keranjang'),
                            backgroundColor: const Color(0xFFE65100),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.shopping_cart,
                          color: Colors.white),
                      label: const Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
