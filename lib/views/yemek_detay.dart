import 'package:bitirme_projesi/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/cubit/sepet_ucret_cubit.dart';
import 'package:bitirme_projesi/entity/yemek.dart';
import 'package:bitirme_projesi/views/sepet_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetaySayfa extends StatefulWidget {
  Yemek yemek;
  int adet=1;


  YemekDetaySayfa(this.yemek);

  @override
  _YemekDetaySayfaState createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {

  @override
  void initState() {
    super.initState();
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
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SepetSayfasi()));
            } ,
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
      body: Column(
        children: [
          Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
          Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 35),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    setState(() {
                      if(widget.adet > 1) {
                        widget.adet -= 1;
                      }
                    });
                  },
                  icon: Icon(Icons.remove_circle,size: 40,)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 16.0),
                child: Text("${widget.adet}",style: TextStyle(fontSize: 40),),
              ),
              IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    setState(() {
                      widget.adet += 1;
                    });
                  },
                  icon: Icon(Icons.add_circle,size: 40,)
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(12.0)
            ),
            child: MaterialButton(
                onPressed: (){
                  context.read<AnasayfaCubit>().sepeteEkle(widget.yemek,adet: widget.adet);
                  Navigator.pop(context);
                },
                child: Text("Sepete Ekle",style: TextStyle(fontSize: 30,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
