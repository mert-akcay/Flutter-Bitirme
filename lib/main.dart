import 'package:bitirme_projesi/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/cubit/sepet_cubit.dart';
import 'package:bitirme_projesi/cubit/sepet_ucret_cubit.dart';
import 'package:bitirme_projesi/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> AnasayfaCubit()),
        BlocProvider(create: (context)=> SepetUcretCubit()),
        BlocProvider(create: (context)=> SepetCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage(),
      ),
    );
  }
}


