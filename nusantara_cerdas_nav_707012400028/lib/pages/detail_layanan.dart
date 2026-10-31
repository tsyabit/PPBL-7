import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/pengajuan_cubit.dart';

class DetailLayanan extends StatefulWidget {
  final Layanan layanan;
  const DetailLayanan({super.key, required this.layanan});
  @override
  State<DetailLayanan> createState() => _DetailLayananState();
}

class _DetailLayananState extends State<DetailLayanan> {
  bool sedangMengirim = false;
  Future<void> ajukan() async {
    if (sedangMengirim) return;
    setState(() => sedangMengirim = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.read<PengajuanCubit>().tambah(widget.layanan.nama);
    Navigator.pop(context, widget.layanan.nama);
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !sedangMengirim,
    child: Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            widget.layanan.nama,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(widget.layanan.deskripsi),
          const SizedBox(height: 24),
          const Text(
            'Permohonan disimpan pada purwarupa lokal, belum terhubung ke dinas.',
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: sedangMengirim ? null : ajukan,
            icon: sedangMengirim
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
            label: Text(
              sedangMengirim ? 'Sedang mengirim…' : 'Ajukan Permohonan',
            ),
          ),
        ],
      ),
    ),
  );
}
