import 'dart:async';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'Controllers/search/search_controller.dart';
import 'widget/bottomnavigation.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(SearchCarsController());
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  await SharedPrefs.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocaFri',
      home: BottomNavigator(),
    );
  }
}
