import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(const {});
  void tandai(String namaLayanan) =>
      emit(Set.unmodifiable({...state, namaLayanan}));
  void batalTandai(String namaLayanan) =>
      emit(Set.unmodifiable({...state}..remove(namaLayanan)));
}
