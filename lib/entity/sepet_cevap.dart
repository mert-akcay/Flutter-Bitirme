import 'package:bitirme_projesi/entity/sepet.dart';

class SepetCevap {
  List<Sepet> sepetListesi;
  int success;

  SepetCevap(this.sepetListesi, this.success);

  factory SepetCevap.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    List<Sepet> sepetListesi = jsonArray.map((e) => Sepet.fromJson(e)).toList();
    return SepetCevap(sepetListesi,json["success"]);
  }
}