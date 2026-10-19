import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

// Halaman keranjang belanja
class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  String formatHarga(double harga) {
    return 'Rp ${harga.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final keranjang = appData.keranjang;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: const Text('Keranjang',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Tombol kosongkan keranjang
          if (keranjang.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Kosongkan Keranjang'),
                    content:
                        const Text('Yakin ingin menghapus semua item?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          appData.kosongkanKeranjang();
                          Navigator.pop(context);
                        },
                        child: const Text('Hapus',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Kosongkan',
                  style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: keranjang.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE65100)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Lihat Menu',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // List item keranjang
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: keranjang.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final item = keranjang[i];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Gambar kecil
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 65,
                                  height: 65,
                                  child: Image.asset(
                                    item.menu.gambar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFFFBE9E7),
                                      child: const Icon(Icons.restaurant,
                                          color: Color(0xFFE65100)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Nama dan harga satuan
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.menu.nama,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formatHarga(item.menu.harga),
                                      style: const TextStyle(
                                          color: Color(0xFFE65100),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              // Kontrol jumlah
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Color(0xFFE65100)),
                                    onPressed: () =>
                                        appData.updateJumlah(
                                            item.menu.id, item.jumlah - 1),
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    iconSize: 26,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      '${item.jumlah}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Color(0xFFE65100)),
                                    onPressed: () =>
                                        appData.updateJumlah(
                                            item.menu.id, item.jumlah + 1),
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    iconSize: 26,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Ringkasan total dan tombol pesan
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, -3))
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pesanan',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            formatHarga(appData.totalKeranjang),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE65100),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE65100),
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/checkout'),
                          child: const Text(
                            'Lanjut ke Pembayaran',
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
              ],
            ),
    );
  }
}
