import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';
import '../cubit/keranjang_cubit.dart';
import '../widgets/product_card.dart';
import '../widgets/theme_toggle_button.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Kantin Kampus'),
      actions: const [ThemeToggleButton()],
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: daftarProduk
          .map(
            (p) => ProductCard(
              produk: p,
              onTambah: () => context.read<KeranjangCubit>().tambah(p),
            ),
          )
          .toList(),
    ),
  );
}
