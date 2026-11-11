import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: "Protein",
        iconPath: "assets/icons/noto_cut-of-meat.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Sayuran",
        iconPath: "assets/icons/fluent-emoji-flat_leafy-green.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Cepat",
        iconPath: "assets/icons/flat-color-icons_clock.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Hemat",
        iconPath: "assets/icons/noto_money-bag.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Sarapan",
        iconPath: "assets/icons/noto_egg.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Sambal",
        iconPath: "assets/icons/noto-v1_hot-pepper.svg",
        boxColor: Color(0xffFFE4B2),
      ),
    );

    return categories;
  }
}
