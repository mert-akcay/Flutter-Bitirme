import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/entity/sepet_cevap.dart';
import 'package:bitirme_projesi/entity/yemek.dart';
import 'package:bitirme_projesi/entity/yemek_cevap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class YemekRepository {

  List<Yemek> parseYemeklerCevap(String cevap) {
    return YemekCevap.fromJson(json.decode(cevap)).yemekListesi;
  }
  List<Sepet> parseSepetCevap(String cevap) {
    return SepetCevap.fromJson(json.decode(cevap)).sepetListesi;
  }

  Future<List<Yemek>> tumYemekleriAl() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepeteEkle(Yemek yemek, {int adet=1}) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi":"${yemek.yemek_adi}",
      "yemek_resim_adi":"${yemek.yemek_resim_adi}",
      "yemek_fiyat":"${yemek.yemek_fiyat}",
      "yemek_siparis_adet": "${adet}",
      "kullanici adi": "mert_a"
    };
    var cevap = await http.post(url, body: veri);
  }
  
  Future<List<Sepet>> sepetiGetir() async {
    try {
      var url = Uri.parse(
          "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
      var veri = {"kullanici_adi": "mert_a"};
      var cevap = await http.post(url, body: veri);
      return parseSepetCevap(cevap.body);
    }catch(err) {
      return [];
    }
  }

  Future<int> sepetUcreti() async {
    var liste = await sepetiGetir();
    var top = 0;
    liste.forEach((yemek) {
      top += yemek.yemek_fiyat * yemek.yemek_siparis_adet;
    });
    return top;
  }

  Future<void> sepetUrunSil(sepet_yemek_id) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {"sepet_yemek_id": sepet_yemek_id.toString(), "kullanici_adi": "mert_a"};
    await http.post(url,body: veri);
  }
}