import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/entity/yemek.dart';
import 'package:bitirme_projesi/repo/yemek_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemek>> {
  AnasayfaCubit():super(<Yemek>[]);

  var repo = YemekRepository();

  Future<void> yemekleriYukle() async {
    var liste = await repo.tumYemekleriAl();
    emit(liste);
  }

  Future<List<Sepet>> sepetiYukle() async {
    var liste = await repo.sepetiGetir();
    return liste;
  }

  Future<void> sepeteEkle(Yemek yemek, {int adet = 1}) async {
    await repo.sepeteEkle(yemek,adet: adet);
  }

  Future<int> sepetUcret() async {
    int ucret = await repo.sepetUcreti();
    return ucret;
  }
}