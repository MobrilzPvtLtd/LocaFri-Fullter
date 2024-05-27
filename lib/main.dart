
import 'dart:async';

import 'package:carapp/screen/Introduction/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 5));
   FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
   
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      home: IntroductionPage(),
    );
  }
}
