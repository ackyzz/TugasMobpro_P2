// Model data menu
class MenuItem {
  final String id;
  final String nama;
  final String deskripsi;
  final double harga;
  final String gambar;
  final String kategori;
  bool isFavorit;

  MenuItem({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.kategori,
    this.isFavorit = false,
  });
}

// Model item di keranjang
class ItemKeranjang {
  final MenuItem menu;
  int jumlah;
  String? catatan;

  ItemKeranjang({
    required this.menu,
    this.jumlah = 1,
    this.catatan,
  });

  double get totalHarga => menu.harga * jumlah;
}
