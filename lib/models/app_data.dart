import 'package:flutter/material.dart';
import 'menu_item.dart';

// State management pakai ChangeNotifier
class AppData extends ChangeNotifier {
  // Daftar menu yang tersedia
  final List<MenuItem> _daftarMenu = [
    MenuItem(
      id: '1',
      nama: 'Nasi Goreng Spesial',
      deskripsi: 'Nasi goreng dengan telur, ayam, dan sayuran',
      harga: 15000,
      gambar: 'assets/images/nasi_goreng.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '2',
      nama: 'Mie Ayam',
      deskripsi: 'Mie dengan topping ayam dan bakso',
      harga: 12000,
      gambar: 'assets/images/mie_ayam.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '3',
      nama: 'Gado-Gado',
      deskripsi: 'Sayuran rebus dengan bumbu kacang',
      harga: 10000,
      gambar: 'assets/images/gado_gado.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '4',
      nama: 'Soto Ayam',
      deskripsi: 'Soto kuning dengan nasi dan pelengkap',
      harga: 13000,
      gambar: 'assets/images/soto_ayam.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '5',
      nama: 'Nasi Pecel',
      deskripsi: 'Nasi dengan sayuran dan sambal kacang',
      harga: 11000,
      gambar: 'assets/images/nasi_pecel.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '6',
      nama: 'Ayam Bakar',
      deskripsi: 'Ayam bakar bumbu kecap dengan lalapan',
      harga: 18000,
      gambar: 'assets/images/ayam_bakar.jpg',
      kategori: 'Makanan',
    ),
    MenuItem(
      id: '7',
      nama: 'Es Teh Manis',
      deskripsi: 'Teh manis segar dengan es batu',
      harga: 5000,
      gambar: 'assets/images/es_teh.jpg',
      kategori: 'Minuman',
    ),
    MenuItem(
      id: '8',
      nama: 'Es Jeruk',
      deskripsi: 'Jeruk peras segar dengan es batu',
      harga: 7000,
      gambar: 'assets/images/es_jeruk.jpg',
      kategori: 'Minuman',
    ),
    MenuItem(
      id: '9',
      nama: 'Jus Alpukat',
      deskripsi: 'Jus alpukat dengan susu dan coklat',
      harga: 10000,
      gambar: 'assets/images/jus_alpukat.jpg',
      kategori: 'Minuman',
    ),
    MenuItem(
      id: '10',
      nama: 'Kopi Susu',
      deskripsi: 'Kopi dengan susu kental manis',
      harga: 8000,
      gambar: 'assets/images/kopi_susu.jpg',
      kategori: 'Minuman',
    ),
    MenuItem(
      id: '11',
      nama: 'Pisang Goreng',
      deskripsi: 'Pisang goreng renyah dengan taburan gula',
      harga: 6000,
      gambar: 'assets/images/pisang_goreng.jpg',
      kategori: 'Snack',
    ),
    MenuItem(
      id: '12',
      nama: 'Tempe Mendoan',
      deskripsi: 'Tempe mendoan crispy dengan cabe rawit',
      harga: 5000,
      gambar: 'assets/images/tempe_mendoan.jpg',
      kategori: 'Snack',
    ),
  ];

  // Keranjang belanja
  final List<ItemKeranjang> _keranjang = [];

  List<MenuItem> get daftarMenu => _daftarMenu;

  // Filter berdasarkan kategori
  List<MenuItem> ambilPerKategori(String kategori) {
    if (kategori == 'Semua') return _daftarMenu;
    return _daftarMenu.where((m) => m.kategori == kategori).toList();
  }

  List<ItemKeranjang> get keranjang => _keranjang;

  int get jumlahKeranjang =>
      _keranjang.fold(0, (total, item) => total + item.jumlah);

  double get totalKeranjang =>
      _keranjang.fold(0.0, (total, item) => total + item.totalHarga);

  // Tambah ke keranjang
  void tambahKeKeranjang(MenuItem menu) {
    final index = _keranjang.indexWhere((k) => k.menu.id == menu.id);
    if (index >= 0) {
      _keranjang[index].jumlah++;
    } else {
      _keranjang.add(ItemKeranjang(menu: menu));
    }
    notifyListeners();
  }

  // Hapus dari keranjang
  void hapusDariKeranjang(String id) {
    _keranjang.removeWhere((k) => k.menu.id == id);
    notifyListeners();
  }

  // Update jumlah item
  void updateJumlah(String id, int jumlah) {
    final index = _keranjang.indexWhere((k) => k.menu.id == id);
    if (index >= 0) {
      if (jumlah <= 0) {
        _keranjang.removeAt(index);
      } else {
        _keranjang[index].jumlah = jumlah;
      }
      notifyListeners();
    }
  }

  void kosongkanKeranjang() {
    _keranjang.clear();
    notifyListeners();
  }

  // Tambah/hapus favorit
  void toggleFavorit(String id) {
    final index = _daftarMenu.indexWhere((m) => m.id == id);
    if (index >= 0) {
      _daftarMenu[index].isFavorit = !_daftarMenu[index].isFavorit;
      notifyListeners();
    }
  }

  List<MenuItem> get favorit => _daftarMenu.where((m) => m.isFavorit).toList();
}
