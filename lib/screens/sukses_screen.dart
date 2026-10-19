import 'package:flutter/material.dart';

// Halaman sukses setelah pesanan berhasil
class HalamanSukses extends StatelessWidget {
  const HalamanSukses({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data yang dikirim dari halaman checkout
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final nama = args['nama'] ?? '-';
    final meja = args['meja'] ?? '-';
    final metode = args['metode'] ?? '-';

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon centang
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFFFBE9E7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFFE65100),
                  size: 80,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Pesanan Berhasil!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Terima kasih, pesananmu sedang diproses',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Kartu detail pesanan
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _barisInfo(Icons.person, 'Nama', nama),
                      const Divider(height: 20),
                      _barisInfo(
                          Icons.table_restaurant, 'Nomor Meja', meja),
                      const Divider(height: 20),
                      _barisInfo(
                          Icons.payment, 'Metode Bayar', metode),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol kembali ke menu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false),
                  icon: const Icon(Icons.home, color: Colors.white),
                  label: const Text(
                    'Kembali ke Menu',
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
    );
  }

  // Widget baris info di kartu detail
  Widget _barisInfo(IconData ikon, String label, String nilai) {
    return Row(
      children: [
        Icon(ikon, color: const Color(0xFFE65100), size: 22),
        const SizedBox(width: 12),
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const Spacer(),
        Text(nilai,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
