import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

// Halaman profil kantin
class HalamanProfil extends StatefulWidget {
  const HalamanProfil({super.key});

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  bool _notifAktif = true;
  double _rating = 4.5;

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: const Text('Profil Kantin',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header profil kantin
            Container(
              width: double.infinity,
              color: const Color(0xFFE65100),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  // Foto kantin
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 70,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.storefront,
                        size: 60,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Kantin Bu Sari',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Gedung A Lt. 1 - Kampus',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  // Bintang rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return Icon(
                        i < _rating.floor()
                            ? Icons.star
                            : (i < _rating ? Icons.star_half : Icons.star_border),
                        color: Colors.yellow,
                        size: 22,
                      );
                    }),
                  ),
                  Text(
                    '$_rating / 5.0',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Info statistik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _kartuStat('${appData.daftarMenu.length}', 'Total Menu'),
                  const SizedBox(width: 12),
                  _kartuStat('${appData.favorit.length}', 'Difavoritkan'),
                  const SizedBox(width: 12),
                  _kartuStat('08.00 - 16.00', 'Jam Buka'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Pengaturan notifikasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SwitchListTile(
                  title: const Text('Notifikasi Pesanan'),
                  subtitle: const Text('Aktifkan notifikasi status pesanan'),
                  value: _notifAktif,
                  activeColor: const Color(0xFFE65100),
                  onChanged: (v) => setState(() => _notifAktif = v),
                  secondary: const Icon(Icons.notifications,
                      color: Color(0xFFE65100)),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Menu navigasi profil
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _itemMenu(Icons.favorite, 'Menu Favorit', () {
                      Navigator.pushNamed(context, '/favorit');
                    }),
                    const Divider(height: 1),
                    _itemMenu(Icons.info_outline, 'Tentang Kantin', () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Kantin Bu Sari',
                        applicationVersion: '1.0.0',
                        children: const [
                          Text(
                              'Aplikasi pemesanan makanan Kantin Bu Sari.\nBuat tugas MobPro.'),
                        ],
                      );
                    }),
                    const Divider(height: 1),
                    _itemMenu(Icons.star_outline, 'Beri Rating', () {
                      _dialogRating(context);
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget kartu statistik kecil
  Widget _kartuStat(String nilai, String label) {
    return Expanded(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Text(nilai,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFE65100))),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  // Widget baris menu di profil
  Widget _itemMenu(IconData ikon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(ikon, color: const Color(0xFFE65100)),
      title: Text(label),
      trailing:
          const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Dialog beri rating
  void _dialogRating(BuildContext context) {
    double ratingTemp = _rating;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setStateDialog) => AlertDialog(
          title: const Text('Beri Rating'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Geser untuk memberi rating:'),
              const SizedBox(height: 10),
              Slider(
                value: ratingTemp,
                min: 1,
                max: 5,
                divisions: 8,
                activeColor: const Color(0xFFE65100),
                label: ratingTemp.toStringAsFixed(1),
                onChanged: (v) =>
                    setStateDialog(() => ratingTemp = v),
              ),
              Text(
                '${ratingTemp.toStringAsFixed(1)} / 5.0',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE65100)),
              onPressed: () {
                setState(() => _rating = ratingTemp);
                Navigator.pop(ctx);
              },
              child: const Text('Simpan',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
