import 'package:flutter/material.dart';

import '../models/produk.dart';

class ProductCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback onTambah;
  const ProductCard({super.key, required this.produk, required this.onTambah});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(Icons.restaurant, color: theme.colorScheme.primary),
        title: Text(produk.nama, style: theme.textTheme.titleMedium),
        subtitle: Text(
          rupiah(produk.harga),
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        trailing: IconButton(
          tooltip: 'Tambah ${produk.nama}',
          onPressed: onTambah,
          icon: const Icon(Icons.add_circle),
        ),
      ),
    );
  }
}
