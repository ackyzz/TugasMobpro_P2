import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';
import '../models/menu_item.dart';
import '../widgets/menu_card.dart';
import 'detail_screen.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  String _kategoriDipilih = 'Semua';
  final TextEditingController _controllerCari = TextEditingController();
  String _kataCari = '';

  final List<String> _daftarKategori = ['Semua', 'Makanan', 'Minuman', 'Snack'];

  @override
  void dispose() {
    _controllerCari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    // Filter menu sesuai kategori dan kata pencarian
    List<MenuItem> hasilFilter = appData
        .ambilPerKategori(_kategoriDipilih)
        .where((m) =>
            m.nama.toLowerCase().contains(_kataCari.toLowerCase()) ||
            m.deskripsi.toLowerCase().contains(_kataCari.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Kantin Bu Sari 🍽️',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Selamat datang!',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          // Ikon keranjang dengan badge jumlah
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/keranjang'),
              ),
              if (appData.jumlahKeranjang > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${appData.jumlahKeranjang}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header dengan search bar
          Container(
            width: double.infinity,
            color: const Color(0xFFE65100),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: TextField(
              controller: _controllerCari,
              onChanged: (v) => setState(() => _kataCari = v),
              decoration: InputDecoration(
                hintText: 'Cari menu...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _kataCari.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _controllerCari.clear();
                          setState(() => _kataCari = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // Chip pilihan kategori
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _daftarKategori.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, i) {
                  final kat = _daftarKategori[i];
                  final dipilih = kat == _kategoriDipilih;
                  return ChoiceChip(
                    label: Text(kat),
                    selected: dipilih,
                    selectedColor: const Color(0xFFE65100),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: dipilih ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (_) =>
                        setState(() => _kategoriDipilih = kat),
                  );
                },
              ),
            ),
          ),

          // Info jumlah menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${hasilFilter.length} menu tersedia',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const Spacer(),
                const Icon(Icons.grid_view,
                    color: Color(0xFFE65100), size: 20),
              ],
            ),
          ),

          // Grid daftar menu
          Expanded(
            child: hasilFilter.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text(
                          'Menu tidak ditemukan',
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: hasilFilter.length,
                    itemBuilder: (ctx, i) => KartuMenu(
                      item: hasilFilter[i],
                      appData: appData,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              HalamanDetail(item: hasilFilter[i]),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      // Tombol lihat pesanan
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFE65100),
        onPressed: () => Navigator.pushNamed(context, '/pesanan'),
        icon: const Icon(Icons.receipt_long, color: Colors.white),
        label:
            const Text('Pesanan Saya', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
