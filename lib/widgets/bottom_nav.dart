import 'package:flutter/material.dart';

// Definisikan warna yang digunakan (atau sesuaikan dengan file tema Anda)
const kOrange = Color(0xFFE86A33);
const kOrangeMuda = Color(0xFFFFE4B2);

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 64 + bottom,
      padding: EdgeInsets.only(bottom: bottom),
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
          _item(Icons.home_outlined, 'Home', 0),
          _item(Icons.calendar_month_outlined, 'Jadwal', 1),
          
          // Tombol tambah (+) di tengah (opsional, bisa diberi aksi jika ditekan)
          GestureDetector(
            onTap: () {
              // Contoh: Buka dialog tambah menu cepat atau aksi lainnya
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: kOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: kOrangeMuda, size: 28),
            ),
          ),
          
          _item(Icons.shopping_basket_outlined, 'Belanja', 2),
          _item(Icons.person, 'Akun', 3),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final active = currentIndex == index;
    // Jika tab aktif berwarna oranye, jika tidak agak transparan/abu-abu
    final color = active ? kOrange : Colors.black.withValues(alpha: 0.2);
    
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index), // Mengirim indeks saat tab diklik ke MainPage
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
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
        ),
      ),
    );
  }
}