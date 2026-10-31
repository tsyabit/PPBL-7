import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(const []);
  int get totalPengajuan => state.length;
  void tambah(String nama) {
    if (!state.contains(nama)) emit(List.unmodifiable([...state, nama]));
  }

  void hapus(String nama) =>
      emit(List.unmodifiable(state.where((n) => n != nama)));
  void kosongkan() => emit(const []);
}
