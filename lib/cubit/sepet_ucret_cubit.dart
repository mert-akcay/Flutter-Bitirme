import 'package:bitirme_projesi/repo/yemek_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetUcretCubit extends Cubit<int> {
  SepetUcretCubit():super(0);

  var repo = YemekRepository();


  Future<void> sepetUcret() async {
    int ucret = await repo.sepetUcreti();
    emit(ucret);
  }
}