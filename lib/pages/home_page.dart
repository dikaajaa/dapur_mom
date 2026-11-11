import 'package:latihan_flutter/models/kategori_model.dart';
import 'package:latihan_flutter/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<CategoryModel> categories = [];
  List<MenuModel> menuHariIni = [];
  
  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    menuHariIni = MenuModel.getMenuHariIni();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          SizedBox(height: 10),
          _headerContainer(),
          SizedBox(height: 25),
          _categoriesSection(),
          SizedBox(height: 25),
          _menuHariIniSection(),
        ],
      ),
    );
  }

  Column _menuHariIniSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu Hari Ini",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff4A3428),
                    ),
                  ),
                  Text(
                    "Jum'at, 18 Sep",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffE86A33),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              itemCount: menuHariIni.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuHariIni[index].waktuMakan,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4A3428),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              menuHariIni[index].imagePath,
                              width: 140,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  menuHariIni[index].namaMenu,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4A3428),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Color(0xffE86A33),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      menuHariIni[index].durasi,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4A3428),
                ),
              ),
              Text(
                "Lihat Semua",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffE86A33),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 100,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 70,
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: categories[index].boxColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            categories[index].iconPath,
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4A3428),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _headerContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffE86A33),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Cari resep makanan...",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xffFDFBF7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/ilustrasi-ayam-goreng-lengkuas_169 1.png',
                fit: BoxFit
                    .cover, // Berubah dari contain ke cover agar memenuhi lebar
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color(0xffFDFBF7),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: Color(0xff4A3428)),
      ),
      title: Text(
        "Halo Mom!",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xff4A3428),
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, color: Colors.grey, size: 20.0),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: Color(0xff4A3428)),
        ),
      ],
    );
  }
}
