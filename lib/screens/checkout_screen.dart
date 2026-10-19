import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

// Halaman checkout / konfirmasi pesanan
class HalamanCheckout extends StatefulWidget {
  const HalamanCheckout({super.key});

  @override
  State<HalamanCheckout> createState() => _HalamanCheckoutState();
}

class _HalamanCheckoutState extends State<HalamanCheckout> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNama = TextEditingController();
  final _controllerMeja = TextEditingController();
  String _metodeBayar = 'Tunai';
  bool _sedangProses = false;

  final List<String> _pilihanBayar = ['Tunai', 'Transfer', 'QRIS'];

  String formatHarga(double harga) {
    return 'Rp ${harga.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+$)'),
          (m) => '${m[1]}.',
        )}';
  }

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerMeja.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE65100),
        title: const Text('Konfirmasi Pesanan',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ringkasan pesanan
              const Text(
                'Ringkasan Pesanan',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appData.keranjang.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, i) {
                    final item = appData.keranjang[i];
                    return ListTile(
                      leading: const Icon(Icons.restaurant_menu,
                          color: Color(0xFFE65100)),
                      title: Text(item.menu.nama,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      subtitle: Text(
                          '${formatHarga(item.menu.harga)} x ${item.jumlah}'),
                      trailing: Text(
                        formatHarga(item.totalHarga),
                        style: const TextStyle(
                            color: Color(0xFFE65100),
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Data pemesan
              const Text(
                'Data Pemesan',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Input nama
              TextFormField(
                controller: _controllerNama,
                decoration: InputDecoration(
                  labelText: 'Nama Pemesan',
                  prefixIcon: const Icon(Icons.person,
                      color: Color(0xFFE65100)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFE65100)),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 14),

              // Input nomor meja
              TextFormField(
                controller: _controllerMeja,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nomor Meja',
                  prefixIcon: const Icon(Icons.table_restaurant,
                      color: Color(0xFFE65100)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFE65100)),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nomor meja wajib diisi' : null,
              ),
              const SizedBox(height: 20),

              // Pilih metode pembayaran
              const Text(
                'Metode Pembayaran',
                style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: _pilihanBayar.map((metode) {
                  return RadioListTile<String>(
                    title: Text(metode),
                    value: metode,
                    groupValue: _metodeBayar,
                    activeColor: const Color(0xFFE65100),
                    onChanged: (v) =>
                        setState(() => _metodeBayar = v!),
                    contentPadding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Total
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE9E7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pembayaran',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(
                      formatHarga(appData.totalKeranjang),
                      style: const TextStyle(
                        color: Color(0xFFE65100),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tombol konfirmasi pesanan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65100),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _sedangProses
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _sedangProses = true);
                            // Simulasi proses loading
                            await Future.delayed(
                                const Duration(seconds: 2));
                            appData.kosongkanKeranjang();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/sukses',
                                (route) => route.isFirst,
                                arguments: {
                                  'nama': _controllerNama.text,
                                  'meja': _controllerMeja.text,
                                  'metode': _metodeBayar,
                                },
                              );
                            }
                          }
                        },
                  child: _sedangProses
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Konfirmasi Pesanan',
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
}
