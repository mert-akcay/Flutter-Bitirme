import 'package:bitirme_projesi/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/cubit/sepet_ucret_cubit.dart';
import 'package:bitirme_projesi/entity/yemek.dart';
import 'package:bitirme_projesi/repo/yemek_repository.dart';
import 'package:bitirme_projesi/views/sepet_sayfasi.dart';
import 'package:bitirme_projesi/views/yemek_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  List<String> images = [
    "https://i4.hurimg.com/i/hurriyet/75/750x422/5f75a54fd3806c1c480c29f8.jpg",
    "https://i.ytimg.com/vi/hy6x9FY6Yaw/maxresdefault.jpg",
    "https://www.castajans.blue/anasayfa-resim/34ci_anasayfa.jpg"
  ];


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SepetSayfasi())).then((value) => context.read<SepetUcretCubit>().sepetUcret());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                ),
                height: 150,
                child: PageView.builder(
                    itemCount: widget.images.length,
                    pageSnapping: true,
                    itemBuilder: (context,index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Image.network(widget.images[index]),
                      );
                    }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Popular",style: TextStyle(fontSize: 24),),
            ),
            SizedBox(height: 120,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 275,
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(height: 100,width: 150,
                              child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/tiramisu.png")
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text("Tiramisu",style: TextStyle(fontSize: 18),),
                              ),
                              Row(
                                children: [
                                  Text("₺ 29.00",style: TextStyle(fontSize: 20,color: Colors.pink,fontWeight: FontWeight.bold),),
                                ],
                              )
                            ],),
                        ],
                      ),),
                  ),
                  Container(
                    width: 275,
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(height: 100,width: 150,
                              child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/makarna.png")
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text("Makarna",style: TextStyle(fontSize: 18),),
                              ),
                              Text("₺ 28.00",style: TextStyle(fontSize: 20,color: Colors.pink,fontWeight: FontWeight.bold),)
                            ],),
                        ],
                      ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0,bottom: 10.0),
              child: Text("All Foods",style: TextStyle(fontSize: 24),),
            ),
            Expanded(
              child: BlocBuilder<AnasayfaCubit,List<Yemek>>(
                builder: (context,yemekListesi){
                  if(yemekListesi.isNotEmpty){
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.60
                        ),
                        itemCount: yemekListesi.length,
                        itemBuilder: (context,index) {
                          var yemek = yemekListesi[index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> YemekDetaySayfa(yemek)));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                    Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 18),),
                                    Text("₺ ${yemek.yemek_fiyat}",style: TextStyle(fontSize: 20,color: Colors.pink,fontWeight: FontWeight.bold),),
                                    Container(
                                      margin: EdgeInsets.only(top: 8.0),
                                      height: 30,
                                      width: 75,
                                      decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                            context.read<AnasayfaCubit>().sepeteEkle(yemek);
                                            context.read<SepetUcretCubit>().sepetUcret();
                                        },
                                        child: Text("Add",style: TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                    return Center();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}