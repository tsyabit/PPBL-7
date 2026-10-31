import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class WargaBadge extends StatelessWidget {
  const WargaBadge({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocSelector<PengajuanCubit, List<String>, int>(
        selector: (state) => state.length,
        builder: (context, total) => Badge(
          label: Text('$total'),
          isLabelVisible: total > 0,
          child: const Icon(Icons.person_outline),
        ),
      );
}
