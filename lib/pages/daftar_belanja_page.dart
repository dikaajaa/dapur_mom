import 'package:flutter/material.dart';

void main() {
  runApp(const DaftarBelanjaApp());
}

// ====== Warna ======
const kOrange = Color(0xFFE86A33);
const kOrangeMuda = Color(0xFFFFE4B2);
const kBackground = Color(0xFFFDFBF7);
const kFont = Color(0xFF4A3428);

class DaftarBelanjaApp extends StatelessWidget {
  const DaftarBelanjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: kOrange),
      ),
      home: const DaftarBelanjaPage(),
    );
  }
}

// ====== Model ======
class ShopItem {
  final String name; // contoh: "Kangkung (2 ikat)"
  final int price;
  bool checked;
  ShopItem(this.name, this.price, {this.checked = false});
}

class ShopCategory {
  final String title;
  final List<ShopItem> items;
  ShopCategory(this.title, this.items);
}

String rupiah(int v) {
  final s = v.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}

// ====== Halaman ======
class DaftarBelanjaPage extends StatefulWidget {
  const DaftarBelanjaPage({super.key});

  @override
  State<DaftarBelanjaPage> createState() => _DaftarBelanjaPageState();
}

class _DaftarBelanjaPageState extends State<DaftarBelanjaPage> {
  String _period = 'Minggu Ini';

  final List<ShopCategory> _categories = [
    ShopCategory('Sayur-Mayur', [
      ShopItem('Kangkung (2 ikat)', 6000, checked: true),
      ShopItem('Tomat (500 gram)', 8000),
      ShopItem('Bayam (1 ikat)', 4000),
    ]),
    ShopCategory('Protein & Daging', [
      ShopItem('Dada Ayam (500 gram)', 23000),
      ShopItem('Tempe (2 papan)', 14000, checked: true),
      ShopItem('Telur (500 gram)', 16000, checked: true),
    ]),
    ShopCategory('Bumbu & Dapur', [
      ShopItem('Bawang Merah (250 gram)', 8000, checked: true),
      ShopItem('Kecap Manis (135 ml)', 8000),
    ]),
  ];

  Iterable<ShopItem> get _allItems => _categories.expand((c) => c.items);
  int get _total => _allItems.fold(0, (s, i) => s + i.price);
  int get _count => _allItems.length;
  int get _done => _allItems.where((i) => i.checked).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Belanja',
                style: TextStyle(
                  color: kFont,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              _buildPeriodDropdown(),
              const SizedBox(height: 16),
              _buildSummary(),
              const SizedBox(height: 20),
              for (final cat in _categories) ...[
                _buildCategory(cat),
                const SizedBox(height: 16),
              ],
              Center(child: _buildAddButton()),
            ],
          ),
        ),
      ),
    );
  }

  // Tombol dropdown "Minggu Ini"
  Widget _buildPeriodDropdown() {
    return PopupMenuButton<String>(
      onSelected: (v) => setState(() => _period = v),
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'Minggu Ini', child: Text('Minggu Ini')),
        PopupMenuItem(value: 'Minggu Depan', child: Text('Minggu Depan')),
      ],
      child: Container(
        width: 156,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: kOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                _period,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: kBackground, size: 20),
          ],
        ),
      ),
    );
  }

  // Kartu ringkasan: total estimasi + progress barang
  Widget _buildSummary() {
    final progress = _count == 0 ? 0.0 : _done / _count;
    const labelStyle = TextStyle(
      color: kFont,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.5,
      letterSpacing: 0.14,
    );
    const valueStyle = TextStyle(
      color: kOrange,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.5,
      letterSpacing: 0.14,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(13, 10, 13, 12),
      decoration: BoxDecoration(
        color: kOrangeMuda,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 105,
                child: Text('Total Estimasi', style: labelStyle),
              ),
              const SizedBox(width: 20, child: Text(':', style: labelStyle)),
              Text(rupiah(_total), style: valueStyle),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 105,
                child: Text('Total Barang', style: labelStyle),
              ),
              const SizedBox(width: 20, child: Text(':', style: labelStyle)),
              Container(
                width: 100,
                height: 15,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: kBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kOrange),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Text('$_done/$_count', style: valueStyle),
            ],
          ),
        ],
      ),
    );
  }

  // Kartu kategori (Sayur-Mayur, dll.)
  Widget _buildCategory(ShopCategory cat) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(13, 8, 17, 14),
      decoration: BoxDecoration(
        color: kOrangeMuda,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cat.title,
            style: const TextStyle(
              color: kFont,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: 0.16,
            ),
          ),
          const SizedBox(height: 6),
          for (final item in cat.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: _ItemRow(
                item: item,
                onChanged: () => setState(() => item.checked = !item.checked),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _showAddDialog,
      child: Container(
        width: 205,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: kOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: kOrangeMuda, size: 20),
            SizedBox(width: 3),
            Flexible(
              child: Text(
                'Tambah Barang Manual',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kOrangeMuda,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog sederhana untuk menambah barang manual
  void _showAddDialog() {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama (mis. Cabai 1 ons)',
              ),
            ),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga (Rp)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              final price = int.tryParse(priceCtrl.text.trim()) ?? 0;
              if (name.isNotEmpty) {
                setState(() {
                  _categories.last.items.add(ShopItem(name, price));
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}

// Satu baris barang: checkbox + nama + harga
class _ItemRow extends StatelessWidget {
  final ShopItem item;
  final VoidCallback onChanged;
  const _ItemRow({required this.item, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: item.checked ? kOrange : kBackground,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kFont),
            ),
            child: item.checked
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              item.name,
              style: const TextStyle(
                color: kFont,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.5,
                letterSpacing: 0.14,
              ),
            ),
          ),
          Text(
            rupiah(item.price),
            style: const TextStyle(
              color: kOrange,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: 0.14,
            ),
          ),
        ],
      ),
    );
  }
}
