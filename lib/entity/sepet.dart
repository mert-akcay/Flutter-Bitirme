class Sepet {
  int sepet_yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;
  int yemek_siparis_adet;
  String kullanici_adi;

  Sepet(this.sepet_yemek_id, this.yemek_adi, this.yemek_resim_adi,
      this.yemek_fiyat, this.yemek_siparis_adet, this.kullanici_adi);

  factory Sepet.fromJson(Map<String,dynamic> json) {
    return Sepet(int.parse(json["sepet_yemek_id"]), json["yemek_adi"], json["yemek_resim_adi"], int.parse(json["yemek_fiyat"]), int.parse(json["yemek_siparis_adet"]), json["kullanici_adi"]);
  }
}