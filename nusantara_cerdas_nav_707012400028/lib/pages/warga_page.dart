import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../models/layanan.dart';
import 'layanan_page.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(
        'Sabit Mugni • 707012400028',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => SwitchListTile(
          title: const Text('Mode gelap'),
          value: mode == ThemeMode.dark,
          onChanged: (_) => context.read<ThemeCubit>().toggle(),
        ),
      ),
      Text('Layanan Favorit', style: Theme.of(context).textTheme.titleLarge),
      BlocBuilder<FavoritCubit, Set<String>>(
        builder: (context, names) => names.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Belum ada layanan favorit'),
              )
            : Column(
                children: daftarLayanan
                    .where((l) => names.contains(l.nama))
                    .map((l) => LayananCard(layanan: l))
                    .toList(),
              ),
      ),
      const SizedBox(height: 24),
      Text(
        'Keranjang Pengajuan',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      BlocBuilder<PengajuanCubit, List<String>>(
        builder: (context, names) => Column(
          children: [
            if (names.isEmpty)
              const ListTile(title: Text('Belum ada pengajuan')),
            for (final n in names)
              ListTile(
                title: Text(n),
                trailing: IconButton(
                  tooltip: 'Hapus $n',
                  onPressed: () => context.read<PengajuanCubit>().hapus(n),
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            ElevatedButton(
              onPressed: names.isEmpty
                  ? null
                  : () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text('Kirim seluruh pengajuan'),
                          content: Text(
                            '${names.length} layanan akan dicatat dalam demonstrasi lokal. Tidak dikirim ke server dinas.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(c, false),
                              child: const Text('Batal'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(c, true),
                              child: const Text('Kirim'),
                            ),
                          ],
                        ),
                      );
                      if (!context.mounted || ok != true) return;
                      context.read<PengajuanCubit>().kosongkan();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pengajuan kolektif selesai pada demonstrasi lokal',
                          ),
                        ),
                      );
                    },
              child: const Text('Kirim Semua Pengajuan'),
            ),
          ],
        ),
      ),
    ],
  );
}
