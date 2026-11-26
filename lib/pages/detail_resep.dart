import 'package:flutter/material.dart';

void main() {
  runApp(const DetailResepApp());
}

// ====== Warna ======
const kOrange = Color(0xFFE86A33);
const kOrangeMuda = Color(0xFFFFE4B2);
const kBackground = Color(0xFFFDFBF7);
const kFont = Color(0xFF4A3428);
const kBorder = Color(0xFFEFE6E0);

class DetailResepApp extends StatelessWidget {
  const DetailResepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: kOrange),
      ),
      home: const DetailResepPage(),
    );
  }
}

// ====== Model & data ======
class Ingredient {
  final String name;
  final String amount;
  const Ingredient(this.name, this.amount);
}

class Recipe {
  final String title;
  final String image;
  final String duration;
  final String price;
  final String servings;
  final List<Ingredient> ingredients;
  final List<String> steps;
  const Recipe({
    required this.title,
    required this.image,
    required this.duration,
    required this.price,
    required this.servings,
    required this.ingredients,
    required this.steps,
  });
}

const nasiGoreng = Recipe(
  title: 'Nasi Goreng Kampung',
  image: 'assets/images/nasi_goreng.jpg',
  duration: '20 Menit',
  price: 'Rp 15.000',
  servings: '2 Porsi',
  ingredients: [
    Ingredient('Nasi Putih', '300 gram'),
    Ingredient('Telur Ayam', '2 butir'),
    Ingredient('Bawang Putih', '2 siung'),
    Ingredient('Bawang Merah', '5 siung'),
    Ingredient('Minyak Goreng', '4 sendok makan'),
    Ingredient('Garam', 'Secukupnya'),
    Ingredient('Gula Pasir', 'Secukupnya'),
    Ingredient('Terasi Matang', '5 - 1 buah'),
  ],
  steps: [
    'Haluskan bawang putih, garam, dan kaldu jamur.',
    'Masukkan bawang merah, cabai rawit, dan terasi, lalu ulek kasar.',
    'Tumis bumbu: Panaskan minyak goreng di wajan.',
    'Tumis bumbu ulek sampai harum dan matang agar tidak bau langu.',
    'Masukkan telur: Sisihkan bumbu ke pinggir wajan. Pecahkan telur di sisi yang kosong, lalu orak-arik sampai matang.',
    'Campurkan nasi: Masukkan nasi putih dingin dan sedikit gula pasir. Aduk rata dengan bumbu dan telur.',
    'Matangkan: Besarkan api sedikit dan masak sambil diaduk sampai nasi agak berasap dan sedap. Angkat dan sajikan.',
  ],
);

// ====== Halaman ======
class DetailResepPage extends StatefulWidget {
  final Recipe? recipe;
  const DetailResepPage({super.key, this.recipe});

  @override
  State<DetailResepPage> createState() => _DetailResepPageState();
}

class _DetailResepPageState extends State<DetailResepPage> {
  late final Recipe recipe = widget.recipe ?? nasiGoreng;
  bool _favorite = true;

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Latar gradasi oranye di bagian atas
            Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kOrange, kOrangeMuda, kBackground],
                  stops: [0.0, 0.7, 1.0],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 24),
                    _buildImage(),
                    const SizedBox(height: 12),
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        color: kFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(),
                    const SizedBox(height: 18),
                    _SectionTitle(
                      icon: Icons.assignment_outlined,
                      text: 'Bahan-Bahan',
                    ),
                    const SizedBox(height: 6),
                    for (final ing in recipe.ingredients) _bullet(ing),
                    const SizedBox(height: 14),
                    Center(
                      child: _ActionButton(
                        icon: Icons.shopping_basket_outlined,
                        label: 'Tambah Bahan ke Daftar Belanja',
                        onTap: () =>
                            _toast('Bahan ditambahkan ke daftar belanja'),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionTitle(
                      icon: Icons.restaurant,
                      text: 'Langkah Memasak',
                    ),
                    const SizedBox(height: 6),
                    for (int i = 0; i < recipe.steps.length; i++)
                      _stepRow(i + 1, recipe.steps[i]),
                    const SizedBox(height: 20),
                    Center(
                      child: _ActionButton(
                        label: 'Selesai Memasak',
                        onTap: () => _toast('Selamat menikmati!'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol kembali + favorit + bagikan
  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: kFont, size: 22),
        ),
        const Spacer(),
        _SquareIcon(
          icon: _favorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
          onTap: () => setState(() => _favorite = !_favorite),
        ),
        const SizedBox(width: 11),
        _SquareIcon(
          icon: Icons.share_outlined,
          color: kFont,
          onTap: () => _toast('Bagikan resep'),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        recipe.image,
        width: double.infinity,
        fit: BoxFit.cover,
        alignment: const Alignment(
          0,
          0.8,
        ), // fokus ke piring, sama seperti di Figma
        errorBuilder: (_, error, stackTrace) => Container(
          color: kOrangeMuda,
          child: const Icon(Icons.restaurant, color: kOrange, size: 40),
        ),
      ),
    );
  }

  // Waktu | Harga | Porsi
  Widget _buildInfoRow() {
    Widget cell(IconData icon, String text) => Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: kOrange),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: kOrange,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          cell(Icons.schedule, recipe.duration),
          const VerticalDivider(
            width: 1,
            indent: 10,
            endIndent: 10,
            color: kBorder,
          ),
          cell(Icons.payments_outlined, recipe.price),
          const VerticalDivider(
            width: 1,
            indent: 10,
            endIndent: 10,
            color: kBorder,
          ),
          cell(Icons.restaurant_menu, recipe.servings),
        ],
      ),
    );
  }

  // • Nasi Putih — 300 gram
  Widget _bullet(Ingredient ing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: _bodyStyle),
          Expanded(
            child: Text('${ing.name} — ${ing.amount}', style: _bodyStyle),
          ),
        ],
      ),
    );
  }

  // 1. Langkah...
  Widget _stepRow(int no, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24, child: Text('$no.', style: _bodyStyle)),
          Expanded(child: Text(text, style: _bodyStyle.copyWith(height: 1.5))),
        ],
      ),
    );
  }
}

const _bodyStyle = TextStyle(
  color: kFont,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

// ====== Komponen kecil ======
class _SquareIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _SquareIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: kOrangeMuda,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  const _SectionTitle({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kOrange, size: 22),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: kFont,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback onTap;
  const _ActionButton({this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kOrange,
        foregroundColor: kOrangeMuda,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 4)],
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
