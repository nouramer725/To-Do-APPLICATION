import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'Home_Layout.dart';
import 'shared/cubit/cubit_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown,),
        useMaterial3: true,
      ),
      home: HomeLayout() ,
    );
  }
}
