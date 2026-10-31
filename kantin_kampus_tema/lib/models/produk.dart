class Produk {
  final String nama;
  final int harga;
  const Produk(this.nama, this.harga);
}

class ItemKeranjang {
  final Produk produk;
  final int jumlah;
  const ItemKeranjang(this.produk, this.jumlah);
  int get subtotal => produk.harga * jumlah;
}

const daftarProduk = [
  Produk('Nasi Goreng', 15000),
  Produk('Mie Ayam', 12000),
  Produk('Es Teh', 5000),
  Produk('Jus Alpukat', 10000),
];
String rupiah(int n) =>
    'Rp${n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
