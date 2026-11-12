import 'package:flutter/material.dart';
import 'data/app_store.dart';
import 'screens/activity_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/report_screen.dart';
import 'screens/splash_screen.dart';

class TemuKembaliApp extends StatefulWidget {
  const TemuKembaliApp({super.key});

  @override
  State<TemuKembaliApp> createState() => _TemuKembaliAppState();
}

class _TemuKembaliAppState extends State<TemuKembaliApp> {
  int _selectedIndex = 0;
  bool _showSplash = true;

  static const Color forest = Color(0xFF146B50);
  static const Color mint = Color(0xFFEAF5EF);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ActivityScreen(),
      const ProfileScreen(),
    ];

    return MaterialApp(
      title: 'TemuKembali',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7FAF8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          secondary: const Color(0xFF62A889),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7FAF8),
          foregroundColor: Color(0xFF18382D),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE4ECE7)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE4ECE7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: forest, width: 1.5),
          ),
        ),
      ),
      home: _showSplash
          ? SplashScreen(
              onFinished: () {
                if (mounted) setState(() => _showSplash = false);
              },
            )
          : Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () => _openReport(context),
                backgroundColor: forest,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Buat laporan', style: TextStyle(fontWeight: FontWeight.w700)),
              )
            : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          backgroundColor: Colors.white,
          indicatorColor: mint,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Beranda'),
            NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Aktivitas'),
            NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
          ],
        ),
      ),
    );
  }

  Future<void> _openReport(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ReportScreen()),
    );
  }
}
