import 'package:flutter/material.dart';
import 'home_page.dart';
import 'jadwal_page.dart';
import 'daftar_belanja_page.dart';
// import 'akun_page.dart'; // Uncomment jika file akun sudah ada
import '../widgets/bottom_nav.dart'; // Sesuaikan path folder widget Anda

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Daftar halaman yang diatur oleh BottomNavigationBar
  final List<Widget> _pages = [
    HomePage(),
    const JadwalPage(),
    const DaftarBelanjaPage(),
    // const AkunPage(), // Masukkan halaman akun di sini jika sudah ada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}