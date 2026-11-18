import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color kBackground = Color(0xFFFDFBF7);
const Color kOrange = Color(0xFFE86A33);
const Color kOrangeMuda = Color(0xFFFFE4B2);
const Color kFont = Color(0xFF4A3428);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'Inter',
      ),
      home: const AkunPage(),
    );
  }
}

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    const Padding(
                      padding: EdgeInsets.fromLTRB(19, 12, 19, 14),
                      child: Text(
                        'Profil',
                        style: TextStyle(
                          color: kFont,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    // Banner gradient + avatar + tombol pengaturan
                    const _ProfileHeader(),

                    // Nama & email
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
                      child: Text(
                        'Ibu Fatma',
                        style: TextStyle(
                          color: kFont,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
                      child: Text(
                        'fatmawati@gmail.com',
                        style: TextStyle(
                          color: kFont,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Kartu statistik
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: const [
                          Expanded(
                            child: _StatCard(value: '12', label: 'Resep Saya'),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child:
                                _StatCard(value: '28', label: 'Resep Favorit'),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.savings_outlined,
                              label: 'Keuangan',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    _MenuItem(
                      icon: Icons.menu_book_outlined,
                      title: 'Resep Buatan Saya',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.favorite,
                      title: 'Koleksi Favorit',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.savings_outlined,
                      title: 'Status Keuangan',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.kitchen,
                      title: 'Stok Kulkas Saya',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.notifications,
                      title: 'Pengingat Jadwal Masak',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.question_mark,
                      title: 'Bantuan & FAQ',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: Icons.logout,
                      title: 'Keluar',
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== Header: banner + avatar + tombol ======
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          // Banner gradient
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [kOrangeMuda, kOrange],
                ),
              ),
            ),
          ),

          // Avatar
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: kBackground,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundColor: kOrangeMuda,
                backgroundImage: NetworkImage('https://placehold.co/90x90'),
              ),
            ),
          ),

          // Tombol Pengaturan profil
          Positioned(
            right: 20,
            top: 80,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 118,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kOrange, width: 2),
                ),
                child: const Text(
                  'Pengaturan profil',
                  style: TextStyle(
                    color: kOrange,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====== Kartu statistik ======
class _StatCard extends StatelessWidget {
  final String? value;
  final IconData? icon;
  final String label;

  const _StatCard({this.value, this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
        color: kOrangeMuda,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (value != null)
            Text(
              value!,
              style: const TextStyle(
                color: kOrange,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Icon(icon, color: kOrange, size: 29),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kOrange,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ====== Item menu ======
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: kFont.withOpacity(0.12),
          ),
          InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 39,
              child: Row(
                children: [
                  Icon(icon, color: kFont, size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: kFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: kFont, size: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}