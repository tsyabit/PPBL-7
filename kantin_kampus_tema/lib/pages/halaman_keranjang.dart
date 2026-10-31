import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';
import '../cubit/keranjang_cubit.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/theme_toggle_button.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Keranjang'),
      actions: const [ThemeToggleButton()],
    ),
    body: BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
      builder: (context, items) {
        final cubit = context.read<KeranjangCubit>();
        return Column(
          children: [
            Expanded(
              child: items.isEmpty
                  ? const Center(child: Text('Keranjang kosong'))
                  : ListView(
                      children: items
                          .map(
                            (i) => ListTile(
                              title: Text(i.produk.nama),
                              subtitle: Text(
                                '${i.jumlah} × ${rupiah(i.produk.harga)} = ${rupiah(i.subtotal)}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: 'Kurangi ${i.produk.nama}',
                                    onPressed: () => cubit.kurangi(i.produk),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  IconButton(
                                    tooltip: 'Tambah ${i.produk.nama}',
                                    onPressed: () => cubit.tambah(i.produk),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            CartSummaryBar(
              totalItem: cubit.totalItem,
              totalHarga: cubit.totalHarga,
              onKosongkan: cubit.kosongkan,
            ),
          ],
        );
      },
    ),
  );
}
