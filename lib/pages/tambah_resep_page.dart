import 'package:flutter/material.dart';

void main() {
  runApp(const ResepApp());
}

class AppColors {
  static const background = Color(0xFFFDFBF7);
  static const background2 = Color(0xFFF5ECE5);
  static const orange = Color(0xFFE86A33);
  static const orangeMuda = Color(0xFFFFE4B2);
  static const font = Color(0xFF4A3428);
}

class ResepApp extends StatelessWidget {
  const ResepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
        useMaterial3: true,
      ),
      home: const BuatResepSendiri(),
    );
  }
}

class Bahan {
  String nama;
  String jumlah;
  Bahan(this.nama, this.jumlah);
}

class BuatResepSendiri extends StatefulWidget {
  const BuatResepSendiri({super.key});

  @override
  State<BuatResepSendiri> createState() => _BuatResepSendiriState();
}

class _BuatResepSendiriState extends State<BuatResepSendiri> {
  final _namaController = TextEditingController(text: '');

  final List<String> _kategoriList = ['Ayam', 'Daging', 'Ikan', 'Sayur', 'Dessert'];
  String _kategori = 'Kategori';

  String _harga = 'Rp 25.000';
  String _durasi = '20 Menit';
  String _porsi = '3 Porsi';

  final List<Bahan> _bahan = [
    Bahan('Ayam Fillet', '250 gram'),
    Bahan('Daun Kemangi', '1 ikat'),
  ];

  final List<String> _langkah = [
    'Rebus ayam lalu suwir-suwir.',
    'Tumis bumbu halus dan kemangi.',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }


  Future<String?> _inputDialog(String title, {String? initial, String? hint}) {
    final c = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(title,
            style: const TextStyle(
                color: AppColors.font, fontWeight: FontWeight.w700, fontSize: 18)),
        content: TextField(
          controller: c,
          autofocus: true,
          decoration: InputDecoration(hintText: hint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: AppColors.font)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, c.text.trim()),
            child: const Text('OK', style: TextStyle(color: AppColors.orange)),
          ),
        ],
      ),
    );
  }

  Future<void> _editChip(String title, String current, ValueChanged<String> onSave) async {
    final v = await _inputDialog(title, initial: current);
    if (v != null && v.isNotEmpty) setState(() => onSave(v));
  }

  Future<void> _tambahBahan() async {
    final nama = TextEditingController();
    final jumlah = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('Tambah Bahan',
            style: TextStyle(color: AppColors.font, fontWeight: FontWeight.w700, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nama,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Nama bahan')),
            TextField(
                controller: jumlah,
                decoration: const InputDecoration(hintText: 'Jumlah (mis. 250 gram)')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal', style: TextStyle(color: AppColors.font))),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Tambah', style: TextStyle(color: AppColors.orange))),
        ],
      ),
    );
    if (ok == true && nama.text.trim().isNotEmpty) {
      setState(() => _bahan.add(Bahan(nama.text.trim(), jumlah.text.trim())));
    }
  }

  Future<void> _tambahLangkah() async {
    final v = await _inputDialog('Tambah Langkah', hint: 'Tulis langkah memasak');
    if (v != null && v.isNotEmpty) setState(() => _langkah.add(v));
  }

  void _simpan({bool jadwalkan = false}) {
    // TODO: simpan ke database / state management
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.orange,
        content: Text(
          jadwalkan ? 'Resep disimpan & dijadwalkan' : 'Resep disimpan',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildBahan(),
            const _GarisPembatas(),
            _buildLangkah(),
            const _GarisPembatas(),
            const SizedBox(height: 22),
            _buildTombolSimpan(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.orange, AppColors.orangeMuda],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App bar
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.maybePop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.arrow_back, color: AppColors.font, size: 24),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Tambah Resep',
                    style: TextStyle(
                      color: AppColors.font,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                },
                child: Container(
                  height: 153,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera_outlined, color: AppColors.orange, size: 24),
                      SizedBox(width: 5),
                      Text(
                        'Unggah Foto Masakan',
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  const SizedBox(
                    width: 140,
                    child: Text('Nama Masakan  :',
                        style: _labelStyle),
                  ),
                  Expanded(
                    child: _FieldBox(
                      child: TextField(
                        controller: _namaController,
                        style: _labelStyle,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  const SizedBox(
                    width: 125,
                    child: Text('Kategori', style: _labelStyle),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(':', style: _labelStyle),
                  ),
                  Expanded(
                    child: _FieldBox(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _kategori,
                          isDense: true,
                          isExpanded: true,
                          dropdownColor: AppColors.orangeMuda,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.orange, size: 20),
                          style: _labelStyle,
                          items: _kategoriList
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => setState(() => _kategori = v ?? _kategori),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Chip: harga, durasi, porsi
              Row(
                children: [
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.monetization_on_outlined,
                      text: _harga,
                      onTap: () => _editChip('Estimasi Harga', _harga, (v) => _harga = v),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.access_time,
                      text: _durasi,
                      onTap: () => _editChip('Durasi Memasak', _durasi, (v) => _durasi = v),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _InfoChip(
                      icon: Icons.restaurant,
                      text: _porsi,
                      onTap: () => _editChip('Jumlah Porsi', _porsi, (v) => _porsi = v),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBahan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(icon: Icons.edit_note, title: 'Bahan-Bahan'),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final b in _bahan)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Text('•  ', style: _bodyStyle),
                        Flexible(
                          child: Text('${b.nama}  —  ${b.jumlah}', style: _bodyStyle),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                _AddButton(label: 'Tambah Bahan', onTap: _tambahBahan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangkah() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(icon: Icons.restaurant_menu, title: 'Langkah Memasak'),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < _langkah.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${i + 1}. ${_langkah[i]}', style: _bodyStyle),
                  ),
                const SizedBox(height: 8),
                _AddButton(label: 'Tambah Langkah', onTap: _tambahLangkah),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTombolSimpan() {
    return Column(
      children: [
        _PrimaryButton(
          icon: Icons.save_outlined,
          label: 'Simpan ke Resep Saya',
          onTap: () => _simpan(),
        ),
        const SizedBox(height: 14),
        _PrimaryButton(
          icon: Icons.calendar_month_outlined,
          label: 'Simpan & Jadwalkan Masak',
          onTap: () => _simpan(jadwalkan: true),
        ),
      ],
    );
  }
}

const _labelStyle = TextStyle(
  color: AppColors.font,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const _bodyStyle = TextStyle(
  color: AppColors.font,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

class _FieldBox extends StatelessWidget {
  final Widget child;
  const _FieldBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.orangeMuda,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.orange, width: 1),
      ),
      child: child,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const _InfoChip({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.orangeMuda,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.orange, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: AppColors.orange),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.font,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.orange, size: 24),
        const SizedBox(width: 3),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.font,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _AddButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.orangeMuda,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 18, color: AppColors.orange),
            const SizedBox(width: 3),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.orange,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.orangeMuda),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.orangeMuda,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GarisPembatas extends StatelessWidget {
  const _GarisPembatas();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: AppColors.background2);
  }
}