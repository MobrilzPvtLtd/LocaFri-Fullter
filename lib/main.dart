
import 'dart:async';

import 'package:carapp/screen/Introduction/introduction.dart';
import 'package:carapp/screen/contact_us/contact_us.dart';
import 'package:carapp/screen/find_a_vehical/find_a_vehical.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/screen/mainpage/main-2.dart';
import 'package:carapp/screen/mainpage/mainpage.dart';
import 'package:carapp/widget/bottomnavigation.dart';
import 'package:carapp/widget/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
   
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: Contact_us(),
      home: BottomNavigator(),
      // home: BottomNav(),
    );
  }
}
