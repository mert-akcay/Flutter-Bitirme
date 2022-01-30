import 'package:bitirme_projesi/cubit/sepet_ucret_cubit.dart';
import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/repo/yemek_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetCubit extends Cubit<List<Sepet>> {
  SepetCubit():super(<Sepet>[]);

  var repo = YemekRepository();

  Future<void> sepetiYukle() async {
    var liste = await repo.sepetiGetir();
    emit(liste);
  }

  Future<void> sepetUrunSil(sepet_yemek_id) async {
    await repo.sepetUrunSil(sepet_yemek_id);
    sepetiYukle();
  }

}