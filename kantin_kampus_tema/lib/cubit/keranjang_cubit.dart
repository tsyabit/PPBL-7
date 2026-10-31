import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';

class KeranjangCubit extends Cubit<List<ItemKeranjang>> {
  KeranjangCubit() : super(const []);
  int get totalItem => state.fold(0, (n, i) => n + i.jumlah);
  int get totalHarga => state.fold(0, (n, i) => n + i.subtotal);
  void tambah(Produk p) {
    final found = state.any((i) => i.produk.nama == p.nama);
    emit(
      List.unmodifiable(
        found
            ? state.map(
                (i) => i.produk.nama == p.nama
                    ? ItemKeranjang(p, i.jumlah + 1)
                    : i,
              )
            : [...state, ItemKeranjang(p, 1)],
      ),
    );
  }

  void kurangi(Produk p) => emit(
    List.unmodifiable(
      state
          .map(
            (i) => i.produk.nama == p.nama ? ItemKeranjang(p, i.jumlah - 1) : i,
          )
          .where((i) => i.jumlah > 0),
    ),
  );
  void kosongkan() => emit(const []);
}
