import 'package:bitirme_projesi/entity/yemek.dart';

class YemekCevap {
  List<Yemek> yemekListesi;
  int success;

  YemekCevap({required this.yemekListesi,required this.success});

  factory YemekCevap.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    List<Yemek> yemekListesi = jsonArray.map((e) => Yemek.fromJson(e)).toList();
    return YemekCevap(yemekListesi: yemekListesi, success: json["success"]);
  }
}