import 'package:flutter/material.dart';

void main() {
  runApp(const MealPlannerApp());
}

// ====== Warna ======
const kOrange = Color(0xFFE86A33);
const kOrangeMuda = Color(0xFFFFE4B2);
const kBackground = Color(0xFFFDFBF7);
const kFont = Color(0xFF4A3428);
const kFontMuted = Color(0xFF8E7970);
const kBorder = Color(0xFFEFE6E0);

class MealPlannerApp extends StatelessWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: kOrange),
      ),
      home: const JadwalPage(),
    );
  }
}

class Meal {
  final String name;
  final String duration;
  final String image; // ganti dengan asset/URL gambar asli
  const Meal(this.name, this.duration, this.image);
}

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  final List<String> _days = const [
    'Sen 14',
    'Sel 15',
    'Rab 16',
    'Kam 17',
    'Jum 18',
    'Sab 19',
    'Min 20',
  ];
  int _selectedDay = 0;

  final Meal _breakfast = const Meal(
    'Nasi Goreng Kampung',
    '20 Menit',
    'https://placehold.co/153x92',
  );
  final Meal _lunch = const Meal(
    'Ayam Kecap Manis',
    '40 Menit',
    'https://placehold.co/153x92',
  );
  Meal? _dinner; // null = belum ada menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text(
                'Jadwal',
                style: TextStyle(
                  color: kFont,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _buildWeekBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: [
                    _buildDayChips(),
                    const SizedBox(height: 12),
                    _sectionTitle('Sarapan'),
                    MealCard(meal: _breakfast),
                    _sectionTitle('Makan Siang'),
                    MealCard(meal: _lunch),
                    _sectionTitle('Makan Malam'),
                    _dinner != null
                        ? MealCard(meal: _dinner!)
                        : _buildEmptyDinner(),
                    const SizedBox(height: 20),
                    _buildShoppingButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  // Bar "Minggu Ini" dengan panah kiri/kanan
  Widget _buildWeekBar() {
    return Container(
      height: 52,
      color: kOrangeMuda,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_left, color: kOrange, size: 40),
          ),
          const Text(
            'Minggu Ini (14 - 20 Sep)',
            style: TextStyle(
              color: kFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_right, color: kOrange, size: 40),
          ),
        ],
      ),
    );
  }

  // Chip hari (Sen 14 ... Min 20), bisa digeser horizontal
  Widget _buildDayChips() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final selected = i == _selectedDay;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = i),
            child: Container(
              width: 59,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? kOrange : kBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kOrange),
              ),
              child: Text(
                _days[i],
                style: TextStyle(
                  color: selected ? kOrangeMuda : kFont,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kFont,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildEmptyDinner() {
    return GestureDetector(
      onTap: () => setState(() {
        _dinner = const Meal(
          'Sup Ayam',
          '30 Menit',
          'https://placehold.co/153x92',
        );
      }),
      child: Container(
        height: 118,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorder),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: kOrange, size: 18),
            SizedBox(width: 4),
            Text(
              'Tambah Menu Makan Malam',
              style: TextStyle(
                color: kOrange,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShoppingButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: kOrange,
        foregroundColor: kOrangeMuda,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Buat Daftar Belanja Minggu Ini',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// Kartu menu: gambar kiri, nama + durasi kanan
class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              meal.image,
              width: 140,
              height: 92,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 140,
                height: 92,
                color: kOrangeMuda,
                child: const Icon(Icons.restaurant, color: kOrange),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  meal.name,
                  style: const TextStyle(
                    color: kFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: kOrange),
                    const SizedBox(width: 4),
                    Text(
                      meal.duration,
                      style: const TextStyle(
                        color: kFontMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom navigation dengan tombol tengah (+)
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _item(Icons.home_outlined, 'Home', false),
          _item(Icons.calendar_month_outlined, 'Jadwal', true),
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: kOrange,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: kOrangeMuda, size: 28),
          ),
          _item(Icons.shopping_basket_outlined, 'Belanja', false),
          _item(Icons.person, 'Akun', false),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, bool active) {
    final color = active ? kOrange : Colors.black.withValues(alpha: 0.2);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
