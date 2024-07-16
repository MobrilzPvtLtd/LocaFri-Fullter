import 'dart:async';
import 'package:carapp/screen/auth/Otp/otp.dart';
import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:carapp/screen/contract/checkin_contract.dart';
import 'package:carapp/screen/customer_detail/additional_options/selectdays.dart';
import 'package:carapp/screen/image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'widget/bottomnavigation.dart';

void main() async {
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
      initialRoute: "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => BottomNavigator(),
        ),
        GetPage(
          name: "/login",
          page: () => const Sign_in(),
        ),
        GetPage(
          name: "/otp",
          page: () => const Otp_screen(),
        ),
        GetPage(
          name: "/contract",
          page: () => const checkin_contract(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: checkin_contract()
      home: BottomNavigator(),
      // home: BottomNav(),
    );
  }
}
