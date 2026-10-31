import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/keranjang_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'theme/app_theme.dart';
import 'pages/halaman_produk.dart';
import 'pages/halaman_keranjang.dart';

void main() => runApp(const KantinApp());

class KantinApp extends StatelessWidget {
  const KantinApp({super.key});
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => KeranjangCubit()),
      BlocProvider(create: (_) => ThemeCubit()),
    ],
    child: BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kantin Kampus',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: mode,
        home: const KerangkaUtama(),
      ),
    ),
  );
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});
  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(
      index: index,
      children: const [HalamanProduk(), HalamanKeranjang()],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (i) => setState(() => index = i),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.restaurant_menu),
          label: 'Produk',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
      ],
    ),
  );
}
