import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});
  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: 'Ganti mode tema',
    onPressed: () => context.read<ThemeCubit>().toggle(),
    icon: Icon(
      Theme.of(context).brightness == Brightness.dark
          ? Icons.light_mode
          : Icons.dark_mode,
    ),
  );
}
