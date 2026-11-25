import 'package:flutter/material.dart';

void main() {
  runApp(const MealPlannerApp());
}

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

  // Semua slot dibuat nullable supaya bisa dihapus (null = belum ada menu)
  Meal? _breakfast = const Meal(
    'Nasi Goreng Kampung',
    '20 Menit',
    'https://placehold.co/153x92',
  );
  Meal? _lunch = const Meal(
    'Ayam Kecap Manis',
    '40 Menit',
    'https://placehold.co/153x92',
  );
  Meal? _dinner;

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
                    _buildMealSlot(
                      meal: _breakfast,
                      emptyLabel: 'Tambah Menu Sarapan',
                      onAdd: () => setState(() {
                        _breakfast = const Meal(
                          'Nasi Goreng Kampung',
                          '20 Menit',
                          'https://placehold.co/153x92',
                        );
                      }),
                      onDelete: () => setState(() => _breakfast = null),
                    ),
                    _sectionTitle('Makan Siang'),
                    _buildMealSlot(
                      meal: _lunch,
                      emptyLabel: 'Tambah Menu Makan Siang',
                      onAdd: () => setState(() {
                        _lunch = const Meal(
                          'Ayam Kecap Manis',
                          '40 Menit',
                          'https://placehold.co/153x92',
                        );
                      }),
                      onDelete: () => setState(() => _lunch = null),
                    ),
                    _sectionTitle('Makan Malam'),
                    _buildMealSlot(
                      meal: _dinner,
                      emptyLabel: 'Tambah Menu Makan Malam',
                      onAdd: () => setState(() {
                        _dinner = const Meal(
                          'Sup Ayam',
                          '30 Menit',
                          'https://placehold.co/153x92',
                        );
                      }),
                      onDelete: () => setState(() => _dinner = null),
                    ),
                    const SizedBox(height: 20),
                    _buildShoppingButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        separatorBuilder: (_, _) => const SizedBox(width: 10),
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

  // Menampilkan kartu menu jika ada, atau tombol tambah jika kosong
  Widget _buildMealSlot({
    required Meal? meal,
    required String emptyLabel,
    required VoidCallback onAdd,
    required VoidCallback onDelete,
  }) {
    if (meal == null) {
      return _buildEmptySlot(emptyLabel, onAdd);
    }
    return MealCard(
      meal: meal,
      onDelete: () => _confirmDelete(meal, onDelete),
    );
  }

  // Dialog konfirmasi sebelum menghapus
  Future<void> _confirmDelete(Meal meal, VoidCallback onDelete) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text(
          'Hapus Menu?',
          style: TextStyle(
            color: kFont,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Menu "${meal.name}" akan dihapus dari jadwal.',
          style: const TextStyle(color: kFontMuted, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: kFontMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: kOrange, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      onDelete();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${meal.name}" dihapus dari jadwal'),
          backgroundColor: kFont,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildEmptySlot(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 118,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: kOrange, size: 18),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
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

// Kartu menu: gambar kiri, nama + durasi kanan, tombol hapus di pojok kanan atas
class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onDelete;
  const MealCard({super.key, required this.meal, this.onDelete});

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
              errorBuilder: (_, _, _) => Container(
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
          if (onDelete != null)
            InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.delete_outline,
                  size: 22,
                  color: kFontMuted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}