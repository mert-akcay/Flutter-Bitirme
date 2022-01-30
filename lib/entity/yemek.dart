class Yemek{
  int yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;

  Yemek(
      {required this.yemek_id, required this.yemek_adi, required this.yemek_resim_adi, required this.yemek_fiyat});

  factory Yemek.fromJson(Map<String,dynamic> json) {
    return Yemek(yemek_id: int.parse(json["yemek_id"]), yemek_adi: json["yemek_adi"], yemek_resim_adi: json["yemek_resim_adi"], yemek_fiyat: int.parse(json["yemek_fiyat"]));

  }

}