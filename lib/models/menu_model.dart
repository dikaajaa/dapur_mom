class MenuModel {
  String waktuMakan;
  String namaMenu;
  String durasi;
  String imagePath;

  MenuModel({
    required this.waktuMakan,
    required this.namaMenu,
    required this.durasi,
    required this.imagePath,
  });

  static List<MenuModel> getMenuHariIni() {
    List<MenuModel> menuHariIni = [];

    menuHariIni.add(
      MenuModel(
        waktuMakan: "Sarapan",
        namaMenu: "Nasi Goreng Kampung",
        durasi: "20 menit",
        imagePath: "assets/images/nasi_goreng.jpg",
      ),
    );

    menuHariIni.add(
      MenuModel(
        waktuMakan: "Siang",
        namaMenu: "Ayam Kecap Manis",
        durasi: "40 menit",
        imagePath: "assets/images/ayam_kecap.jpg",
      ),
    );
    menuHariIni.add(
      MenuModel(
        waktuMakan: "Malam",
        namaMenu: "Kwetiau Goreng",
        durasi: "15 menit",
        imagePath: "assets/images/kwetiau.jpg",
      ),
    );
    
    return menuHariIni;
  }
}
