import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'theme/app_theme.dart';
import 'models/layanan.dart';
import 'pages/detail_layanan.dart';
import 'pages/layanan_page.dart';
import 'pages/warga_page.dart';
import 'widgets/warga_badge.dart';

void main() => runApp(const NusantaraApp());

class NusantaraApp extends StatelessWidget {
  const NusantaraApp({super.key});
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => FavoritCubit()),
      BlocProvider(create: (_) => PengajuanCubit()),
      BlocProvider(create: (_) => ThemeCubit()),
    ],
    child: BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nusantara Cerdas Mobile',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: mode,
        routes: {
          '/': (_) => const KerangkaUtama(),
          '/bantuan': (_) => Scaffold(
            appBar: AppBar(title: const Text('Bantuan')),
            body: const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Pilih layanan, tandai favorit, atau buka rincian untuk menambahkan pengajuan. Data disimpan selama aplikasi terbuka.',
              ),
            ),
          ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/detail' && settings.arguments is Layanan) {
            return MaterialPageRoute<String>(
              settings: settings,
              builder: (_) =>
                  DetailLayanan(layanan: settings.arguments as Layanan),
            );
          }
          return null;
        },
        onUnknownRoute: (_) => MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
            body: const Center(
              child: Text('Gunakan tombol kembali untuk melanjutkan.'),
            ),
          ),
        ),
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
  final labels = const ['Beranda', 'Layanan', 'Warga'];
  void pilih(int value) => setState(() => index = value);
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, size) {
      final wide = size.maxWidth >= 800;
      return Scaffold(
        appBar: AppBar(title: Text(labels[index])),
        drawer: NavigationDrawer(
          selectedIndex: index,
          onDestinationSelected: (i) {
            Navigator.pop(context);
            if (i < 3) {
              pilih(i);
            } else {
              Navigator.pushNamed(context, '/bantuan');
            }
          },
          children: const [
            Padding(
              padding: EdgeInsets.all(24),
              child: Text('Nusantara Cerdas Mobile'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.grid_view),
              label: Text('Layanan'),
            ),
            NavigationDrawerDestination(
              icon: WargaBadge(),
              label: Text('Warga'),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.help_outline),
              label: Text('Bantuan'),
            ),
          ],
        ),
        body: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: index,
                onDestinationSelected: pilih,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Beranda'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.grid_view),
                    label: Text('Layanan'),
                  ),
                  NavigationRailDestination(
                    icon: WargaBadge(),
                    label: Text('Warga'),
                  ),
                ],
              ),
            Expanded(
              child: IndexedStack(
                index: index,
                children: [
                  ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Text(
                        'Nusantara Cerdas Mobile',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Layanan warga untuk perizinan, kesehatan, dan transportasi.',
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () => pilih(1),
                        child: const Text('Jelajahi Layanan'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/bantuan'),
                        child: const Text('Bantuan'),
                      ),
                    ],
                  ),
                  const LayananPage(),
                  const WargaPage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: wide
            ? null
            : NavigationBar(
                selectedIndex: index,
                onDestinationSelected: pilih,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.grid_view),
                    label: 'Layanan',
                  ),
                  NavigationDestination(icon: WargaBadge(), label: 'Warga'),
                ],
              ),
      );
    },
  );
}
