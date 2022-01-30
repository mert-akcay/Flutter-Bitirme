import 'package:bitirme_projesi/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/cubit/sepet_ucret_cubit.dart';
import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfasi extends StatefulWidget {
  const SepetSayfasi({Key? key}) : super(key: key);

  @override
  _SepetSayfasiState createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {

  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().sepetiYukle();
    context.read<SepetUcretCubit>().sepetUcret();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text("ordER"),
          actions: [
            MaterialButton(
              onPressed:(){} ,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 2.0),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.shopping_bag_rounded,size: 25,),
                    ),
                    BlocBuilder<SepetUcretCubit,int>(
                        builder: (context,ucret) {
                          if (ucret != null) {
                            return Text("$ucret TL", style: TextStyle(fontSize: 16),);
                          }else {
                            return Center();
                          }
                        }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      body: BlocBuilder<SepetCubit,List<Sepet>>(
        builder: (context, yemekListesi){
          if(yemekListesi.isNotEmpty) {
            return ListView.builder(
                itemCount: yemekListesi.length,
                itemBuilder: (context,index){
                  var yemek = yemekListesi[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: ListTile(
                      leading: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                      title: Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 18),),
                      subtitle: Text("${yemek.yemek_siparis_adet} adet"),
                      tileColor: Colors.black12,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 66,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.pink.shade100,
                              borderRadius: BorderRadius.circular(12.0)
                            ),
                            child: Center(child: Text("${yemek.yemek_siparis_adet*yemek.yemek_fiyat} TL",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,color: Colors.pink,),
                            onPressed: (){
                              context.read<SepetCubit>().sepetUrunSil(yemek.sepet_yemek_id);
                              context.read<SepetUcretCubit>().sepetUcret();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }else {
            return Center();
          }
        },
      )
    );
  }
}
